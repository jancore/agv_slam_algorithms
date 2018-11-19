// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: com_nav350.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2015/11/27

/*
  * File:   com_nav350.h
  * Author: jesus
  *
  * Created on 27 de noviembre de 2015, 17:49
  */

#pragma once

#ifndef COM_NAV350_H
#define COM_NAV350_H

#include "../../Librerias.h"
#include "../../generales/geometria.h"
#include "../../generales/geometria/matriz_transformacion.h"
#include "../../generales/tipos_dato.h"
#include "../sockets/tcp/cliente_tcp.h"

#include <string>
#include <sstream>
#include <stdexcept>

namespace agv
{
	namespace comtcp
	{
		namespace nav350
		{
			enum class Modo_Func : char
			{
				PDOWN = 0, STANDBY = 1, MAPPING = 2, DET_MARCAS = 3, NAVEGACION = 4
			};

			enum class Tipo_Salida : char
			{
				NORMAL = 0, EXTRAPOLADA = 1
			};

			enum class Modo_Pos : char
			{
				INICIAL = 0, CONTINUA = 1, VIRTUAL = 2, EN_PAUSA = 3, INVALIDA = 4, EXTERNA = 5
			};

			enum class Codigo_Error : char
			{
				SIN_ERROR = 0,
				MODO_OP_INCORRECTO = 1,
				TERMINADO_ASICRONO = 2,
				DATOS_INVALIDOS = 3,
				SIN_POS_DISPONIBLE = 4,
				TIMEOUT_SOBREPASADO = 5,
				METODO_YA_ACTIVO = 6,
				ERROR_GENERAL = 7,
			};

			struct DatosNav
			{
				agv::DatosPose pose;
				Codigo_Error cod_error;
				int extrapolado = 0;
				int timestamp = 0;
				int modo_posicionamiento = 3;
				long informacion_diag = 0;
				int num_reflectores = 0;
				bool pose_data = false;
				bool optional_data = false;
			};

			std::string codigo_error_to_string(Codigo_Error p_cod_error);
			std::string mensajes_error_sfa_to_string(int p_codigo_error);

			enum class Tipo_Landmark : char
			{
				INDEFINIDO = 0,
				REFLECTOR = 1
			};

			enum class Subtipo_Landmark : char
			{
				INDEFINIDO = 0,
				PLANO = 1,
				CILINDRICO = 2
			};

			struct Landmark
			{
				uint16_t id_landmark;
				DatosPose posicion;
				Tipo_Landmark tipo;
				Subtipo_Landmark subtipo;
				uint16_t longitud;
				int num_layers;
				int layer_1;
				int layer_2;
				int layer_3;

				Landmark()
				{
					id_landmark = -1;
					num_layers = 0;
					layer_1 = -1;
					layer_2 = -1;
					layer_3 = -1;
				}

				virtual ~Landmark() = default;

				friend std::ostream& operator<< (std::ostream& stream, const Landmark& landmark)
				{
					stream << landmark.id_landmark << '\t'
						<< landmark.posicion.pos_x << '\t'
						<< landmark.posicion.pos_y << '\t'
						<< static_cast<int>(landmark.tipo) << '\t'
						<< static_cast<int>(landmark.subtipo) << '\t'
						<< landmark.longitud << '\t';

					if (landmark.num_layers > 0)
						stream << landmark.layer_1 << '\t';
					if (landmark.num_layers > 1)
						stream << landmark.layer_2 << '\t';
					if (landmark.num_layers > 2)
						stream << landmark.layer_3 << '\t';

					return stream;
				}

				friend Landmark& operator>> (std::istream& stream, Landmark& landmark)
				{
					std::string linea_leida;
					std::getline(stream, linea_leida, '\n');
					std::stringstream strstream(linea_leida);
					strstream >> landmark.id_landmark;
					strstream >> landmark.posicion.pos_x;
					strstream >> landmark.posicion.pos_y;
					int entero;
					strstream >> entero;
					landmark.tipo = static_cast<Tipo_Landmark>(entero);
					strstream >> entero;
					landmark.subtipo = static_cast<Subtipo_Landmark>(entero);
					strstream >> landmark.longitud;

					if (strstream.eof())
						throw(std::invalid_argument("Informacion de landmark incompleta"));

					strstream >> entero;
					if (!strstream.eof())
					{
						landmark.layer_1 = entero;
						landmark.num_layers = 1;
						strstream >> entero;
						if (!strstream.eof())
						{
							landmark.layer_2 = entero;
							landmark.num_layers = 2;
							strstream >> entero;
							if (!strstream.eof())
							{
								landmark.layer_3 = entero;
								landmark.num_layers = 3;
							}
						}
					}

					return landmark;
				}
			};

			struct MappedLandmark : Landmark
			{
				int pol_dist;
				uint16_t local_id;
				uint16_t timestamp;
				uint16_t hitcount;
				uint16_t mean_echo;
				uint16_t start_scan_index;
				uint16_t end_scan_index;

				//Puede tirar std::runtime_error()
				MappedLandmark desde_socket(std::istream& p_stream);

				using Landmark::Landmark;
				virtual ~MappedLandmark() = default;
			};

			struct NavContourPoint
			{
				NavContourPoint(){}
				NavContourPoint(int p_angulo, int p_distancia) : angulo(p_angulo), distancia(p_distancia) {}
				int angulo = -1;
				int distancia = -1;
			};

			struct NavPositionData
			{
				agv::comtcp::nav350::DatosNav datos_pose;
				std::vector<MappedLandmark> landmarks;
				std::vector<NavContourPoint> contorno;
			};

			constexpr int PUERTO_NAV = 2112;
			constexpr int PUERTO_NAV_2 = 2111;

			class ComNav350
			{
			public:

				ComNav350(int p_dist_ruedas_delanteras_motriz = 1000, int p_numero_datos_promedio = 5, int p_maximo_error_permitido = 250, int p_offset_x = 0, int p_offset_y = 0, int p_offset_ang_mgrad = 0, int p_timeout_conexion_ms = 200, int p_temp_descarte_datos_conexion = 1000, unsigned char p_layer = 0) :
					m_layer(p_layer),
					m_temp_descarte_datos_conexion(p_temp_descarte_datos_conexion),
					m_timeout_pos_virtual(0),
					m_numero_datos_promedio(p_numero_datos_promedio > 0 ? p_numero_datos_promedio : 1),
					m_maximo_error_permitido(p_maximo_error_permitido > 0 ? p_maximo_error_permitido : 1),
					m_dist_ruedas_delanteras_motriz(p_dist_ruedas_delanteras_motriz),
					m_temp_reconexion(1000),
					m_temp_reenvio_velocidad(25)
				{
					m_temp_reconexion.forzar_terminado();
					m_socket.set_delimitadores_trama_ascii(2, 3);
					m_socket.set_timeout_ms(p_timeout_conexion_ms);
					set_offset_pos(p_offset_x, p_offset_y, p_offset_ang_mgrad);
				}

				ComNav350(std::string p_ip, int p_puerto = agv::comtcp::nav350::PUERTO_NAV, int p_dist_ruedas_delanteras_motriz = 1000, int p_numero_datos_promedio = 5, int p_maximo_error_permitido = 250, int p_offset_x = 0, int p_offset_y = 0, int p_offset_ang_mgrad = 0, int p_timeout_conexion_ms = 200, int p_temp_descarte_datos_conexion = 1000, unsigned char p_layer = 0) :
					m_layer(p_layer),
					m_temp_descarte_datos_conexion(p_temp_descarte_datos_conexion),
					m_timeout_pos_virtual(0),
					m_numero_datos_promedio(p_numero_datos_promedio > 0 ? p_numero_datos_promedio : 1),
					m_maximo_error_permitido(p_maximo_error_permitido > 0 ? p_maximo_error_permitido : 1),
					m_dist_ruedas_delanteras_motriz(p_dist_ruedas_delanteras_motriz),
					m_socket(p_ip, p_puerto), 
					m_temp_reconexion(1000),
					m_temp_reenvio_velocidad(25)
				{
					m_temp_reconexion.forzar_terminado();
					m_socket.set_delimitadores_trama_ascii(2, 3);
					m_socket.set_timeout_ms(p_timeout_conexion_ms);
					set_offset_pos(p_offset_x, p_offset_y, p_offset_ang_mgrad);
				}

				~ComNav350() { desconectar(); }

				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void cambia_modo(Modo_Func p_modo, long p_timeout_ms = 0);
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void cambia_layer(unsigned char p_layer, long p_timeout_ms = 0);

				//
				//Funciones de navegacion
				//

				//Necesario modo NAVEGACION
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				DatosNav obten_posicion_raw(long p_timeout_ms = 0, bool p_wait = false);
				//Necesario modo NAVEGACION
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				DatosNav obten_posicion(DatosPose& p_posicion, long p_timeout_ms = 0, bool p_wait = false);
				//Necesario modo NAVEGACION
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				DatosNav obten_posicion_filtrada(DatosPose& p_posicion, double p_velocidad_x_mms, double p_velocidad_y_mms, long p_timeout_ms = 0);
				//Necesario modo NAVEGACION
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				DatosNav obten_datos_posicionamiento(double p_velocidad_x_mms, double p_velocidad_y_mms, bool p_wait, long p_timeout_ms = 0, bool p_obten_contorno = true, int p_min_contorno = 0);
				//Aplicacion por demanda de offset a datos de posicion obtenidos directamente
				DatosPose aplicar_offset_posicion(const DatosPose& p_posicion);
				//Aplicacion por demanda de offset a datos de velocidad
				DatosPose aplicar_offset_velocidad(const DatosPose& p_velocidad);
				/**
				*	Envio de velocidad real al nav sin aplicar offset.
				*
				*	La velocidad se debe proporcionar en el centro de giro del AGV, que corresponde con el offset de posicion aplicado en la funcion [set_offset_pos](@ref set_offset_pos)
				*/
				void input_velocidad_real(int p_vel_x, int p_vel_y, int p_vel_ang, bool p_sistema_absoluto = false, long p_timeout_ms = 0);

				//Parametros de configuracion de la clase
				void set_offset_pos(int p_offset_x = 0, int p_offset_y = 0, int p_offset_ang_mgrad = 0);
				void set_numero_datos_promedio(int p_numero_datos_promedio);
				void set_maximo_error_permitido(int p_maximo_error_permitido);
				void set_timeout_pos_virtual(long p_timeout_ms);
				//Estado del NAV (const)
				DatosNav ultimos_datos_recibidos() const;
				bool esta_conectado() const;
				Modo_Func get_modo_actual() const;

				agv::DatosPose get_ultima_posicion() const { return m_ultima_posicion; }
				agv::DatosPose get_ultima_posicion_raw() const { return m_ultima_posicion_raw; }

				//Necesario modo NAVEGACION
				/**
				* Mask: 0 = pose+reflectores, 1 = pose+contorno 2 = pose+reflectores+contorno
				*/
				NavPositionData get_position_data(long p_timeout_ms = 0, int p_mask = 0, bool p_wait = false, bool p_descarta_contorno_invalido = true);
				NavPositionData get_position_data_no_disconnect(long p_timeout_ms = 0, int p_mask = 0, bool p_wait = false, bool p_descarta_contorno_invalido = true);

				const std::vector<agv::Punto2i>& get_ultimo_contorno() const { return m_ultimo_contorno; }

				//
				//Mapeado de reflectores
				//

				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void add_landmark(const std::vector<Landmark>& p_landmark, long p_timeout_ms = 0);
				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void edit_landmark(const std::vector<Landmark>& p_landmark, long p_timeout_ms = 0);
				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::r
				//Necesario modo STANDBYuntime_error)
				void delete_landmark(const std::vector<int>& p_landmark_id, long p_timeout_ms = 0);
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				std::vector<Landmark> read_landmark(const std::vector<int>& p_landmark_id, long p_timeout_ms = 0);
				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				std::vector<Landmark> read_layer_landmarks(int p_id_layer, long p_timeout_ms = 0);
				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				std::vector<Landmark> read_landmark_layout(long p_timeout_ms = 0);
				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void erase_landmark_layout(bool p_borrar_flash = false, long p_timeout_ms = 0);
				//Necesario modo STANDBY
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void guardar_landmark_layout(long p_timeout_ms = 0);

				//
				//Mapping
				//

				//Necesario modo LANDMARK
				std::vector<MappedLandmark> get_current_landmark_view(bool p_wait = 0, long p_timeout_ms = 0);

				//Necesario modo MAPPING
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				std::vector<MappedLandmark> get_mapping_landmarks(DatosPose p_pos_actual_raw, int p_num_scans, bool p_negativo, int p_tam_landmark, Subtipo_Landmark p_subtipo_landmark, long p_timeout_ms = 0);

				//Parametros de comunicacion
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void set_datos_conexion(const std::string p_ip_nav, int p_puerto = PUERTO_NAV);
				void set_timeout_conexion_ms(int p_timeout_conexion_ms);
				void set_tiempo_descarte_conexion(int p_tiempo_descarte_conexion_ms);
				void sincronizar_timestamp(long p_timeout_ms = 0);
				void establece_conexion(long p_timeout_ms = 0);
				void desconectar();
				bool esta_conectado() { return m_socket.esta_conectado(); }

				//protected:
				//Definimos los comandos
				constexpr static auto COMANDO_LOGIN = "SetAccessMode"; //"sMN SetAccessMode 3 F4724744";
				constexpr static auto COMANDO_CAMBIA_MODO = "mNEVAChangeState";
				constexpr static auto COMANDO_CAMBIA_LAYER = "NEVACurrLayer";
				constexpr static auto METODO_SINC_TIMESTAMP = "mNAVGetTimestamp";
				//Posicionamiento
				constexpr static auto COMANDO_CAMBIA_TDATO_POS = "NPOSPoseDataFormat";
				constexpr static auto METODO_GET_POSE = "mNPOSGetPose";
				constexpr static auto METODO_SET_SPEED = "mNPOSSetSpeed";
				constexpr static auto METODO_GET_POS_DATA = "mNPOSGetData";
				//Landmarks
				constexpr static auto METODO_ADD_LANDMARK = "mNLAYAddLandmark";
				constexpr static auto METODO_EDIT_LANDMARK = "mNLAYSetLandmark";
				constexpr static auto METODO_DELETE_LANDMARK = "mNLAYDelLandmark";
				constexpr static auto METODO_READ_LANDMARK = "mNLAYGetLandmark";
				constexpr static auto METODO_READ_LAYER_LANDMARK = "mNLAYGetLayer";
				constexpr static auto METODO_READ_LANDMARK_LAYOUT = "mNLAYGetLayout";
				constexpr static auto METODO_ERASE_LANDMARK_LAYOUT = "mNLAYEraseLayout";
				constexpr static auto METODO_STORE_LANDMARK_LAYOUT = "mNLAYStoreLayout";
				constexpr static auto METODO_CONFIG_MAPPING = "NMAPMapCfg";
				constexpr static auto METODO_DO_MAPPING = "mNMAPDoMapping";
				constexpr static auto METODO_GET_LANDMARKS = "mNLMDGetData";
				//Escritura-lectura de parametros
				constexpr static auto PARAM_TIPO_REFLECTOR = "NLMDReflType";
				constexpr static auto PARAM_LONGITUD_REFLECTOR = "NLMDReflSize";
				//Tipos de solicitud
				constexpr static auto COD_READ_BY_NAME = "sRN";
				constexpr static auto COD_WRITE_BY_NAME = "sWN";
				constexpr static auto COD_METHOD = "sMN";
				constexpr static auto ACK_READ_BY_NAME = "sRA";
				constexpr static auto ACK_WRITE_BY_NAME = "sWA";
				constexpr static auto ACK_METHOD = "sMA";
				constexpr static auto COD_RESPUESTA = "sAN";
				constexpr static auto MSG_ERROR = "sFA";

				constexpr static std::size_t c_max_landmarks_trama = 40;

				//Envio de tramas
				std::string enviar_comando(long p_timeout_ms, const std::string& p_tipo_comando, const std::string& p_comando, const std::string& p_args, const std::string& p_respuesta, const std::string& p_ack = std::string());

			private:
				//Datos de funcionamiento
				Modo_Func m_modo_actual;
				unsigned char m_layer;
				DatosPose m_ultima_posicion;
				DatosPose m_ultima_posicion_raw;
				DatosNav m_ultimos_datos;
				DatosNav m_ultimos_datos_filtrados;
				Temporizador m_temp_descarte_datos_conexion;
				//Filtrado de datos de posicion
				std::vector<DatosNav> m_vector_ultimos_datos;
				int m_contador_medidas_incorrectas;
				Temporizador m_timeout_pos_virtual;
				//Correccion de posicion
				int m_offset_x;
				int m_offset_y;
				int m_offset_ang_mgrad;
				int m_modulo_dist_centro_nav; //Modulo de distancia desde el nav al centro de giro
				int m_angulo_centro_nav_rad; //Angulo desde el centro de giro al nav
				int m_sen_angulo_centro_nav; //Seno en radianes de m_angulo_centro_nav_rad
				int m_cos_angulo_centro_nav; //Coseno en radianes de m_angulo_centro_nav_rad
				int m_numero_datos_promedio;
				int m_maximo_error_permitido;
				int m_dist_ruedas_delanteras_motriz;
				//Cliente tcp
				ClienteTcp m_socket;
				Temporizador m_temp_reconexion;
				Temporizador m_timestamp_nav;
				Temporizador m_temp_reenvio_velocidad;
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void on_sin_posicionamiento();
				//Mapping
				//Puede tirar std::runtime_error y ExcepcionTcp (derivada de std::runtime_error)
				void configurar_mapping(DatosPose p_pos_actual_raw, int p_num_scans, bool p_negativo, int p_tam_landmarks, Subtipo_Landmark p_subtipo_landmarks, long p_timeout_ms);

				DatosNav filtrar_posicion(const DatosNav& p_posicion, double p_velocidad_x_mms, double p_velocidad_y_mms);
				//Ultimo contorno
				std::vector<agv::Punto2i> procesa_contorno(const NavPositionData& p_contorno, int p_min_contorno = 0);
				std::vector<agv::Punto2i> m_ultimo_contorno;
				
				void resolver_disponibilidad(long p_timeout_ms = 0);
				void resolver_disponibilidad(Modo_Func p_modo_actual, long p_timeout_ms = 0);
			};

			void write_landmarks_to_file(const std::string& p_path, const std::vector<Landmark>& p_landmarks);
			std::vector<Landmark> read_landmarks_from_file(const std::string& p_path);

			void landmarks_to_stream(std::vector<Landmark> p_landmarks, std::ostream& p_stream, bool con_id);

			struct LandmarkHmi
			{
				LandmarkHmi() = default;
				LandmarkHmi(const agv::comtcp::nav350::Landmark& p_landmark)
				{
					id_landmark = p_landmark.id_landmark;
					pos_x = (int)p_landmark.posicion.pos_x;
					pos_y = (int)p_landmark.posicion.pos_y;
					muestra_cruceta = true;
				}

				int id_landmark = -1;
				int pos_x = 0;
				int pos_y = 0;
				bool visible = false;
				unsigned char color_visible_r = 0;
				unsigned char color_visible_g = 0;
				unsigned char color_visible_b = 0;
				bool muestra_cruceta = false;
				unsigned char color_cruceta_r = 0;
				unsigned char color_cruceta_g = 0;
				unsigned char color_cruceta_b = 0;
			};

			constexpr double gc_distancia_reflector_coincidente = 300;
						
			/**
			* @brief Wrapper para calibracion del sensor nav350
			*/
			class CalibradorNavBase
			{
			public:
				/**
				* @param p_nav350 Se debe pasar una instancia de ComNav350 que gestione las comunicaciones con el sensor
				*/
				CalibradorNavBase(agv::comtcp::nav350::ComNav350& p_nav350);

				/**
				* @brief Metodo bloqueante, obtiene la posicion actual del AGV sin correcciones de offset
				*/
				agv::DatosPose posicion_actual_raw(long p_timeout_ms = 5000);

				/**
				* @brief Metodo bloqueante, obtiene la posicion actual del AGV con las correcciones de offset especificadas en ComNav350
				*/
				agv::DatosPose posicion_actual(long p_timeout_ms = 5000);

				/**
				* @brief Metodo NO bloqueante, obtiene la ultima posicion del AGV
				*/
				agv::DatosPose ultima_posicion();
				
				/**
				* @brief Establece el origen de coordenadas en funcion de los reflectores visibles
				* @param p_pos_inicial Especifica las coordenadas que queremos que tenga el equipo en el momento de la calibracion
				* ES MUY IMPORTANTE AVISAR QUE EL EQUIPO SE MANTENGA QUIETO MIENTRAS SE REALIZA LA CALIBRACION
				* LA CALIBRACION ES LENTA, PUEDE DURAR MAS DE UN MINUTO.
				*/
				void on_punto_de_partida(agv::DatosPose p_pos_inicial, long p_timeout_ms = 60000);

				/**
				* @brief Realiza un mapeo de los landmarks actuales para incluirlos en el equipo
				* ES MUY IMPORTANTE AVISAR QUE EL EQUIPO SE MANTENGA QUIETO MIENTRAS SE REALIZA LA CALIBRACION
				* LA CALIBRACION ES LENTA, PUEDE DURAR MAS DE UN MINUTO.
				*/
				void on_incluir_reflectores(long p_timeout_ms = 60000);

				/**
				* @brief Elimina todos los reflectores guardados
				*/
				void on_eliminar_reflectores(long p_timeout_ms = 5000);

				/**
				* @brief Carga el layout que tiene el sensor en memoria al PC
				*/
				void on_cargar_layout_actual(long p_timeout_ms = 5000);

				/**
				* @brief Descarga el layout del PC al sensor
				*/
				void on_descargar_layout_actual(long p_timeout_ms = 5000);

				/**
				* @brief Carga el fichero de reflectores de la ruta especificada
				*/
				void on_cargar_reflectores_fichero(std::string p_ruta_fichero, long p_timeout_ms = 5000);

				/**
				* @brief Guarda los reflectores actuales en la ruta especificada
				*/
				void on_guardar_reflectores_fichero(std::string p_ruta_fichero);

				/**
				* @brief Actualiza los datos internos de posicion y landmarks
				* Este metodo solo es util para clases derivadas
				*/
				void on_actualizar_datos(long p_timeout_ms = 5000);

				/**
				* @brief Elimina landmark por ID
				*/
				void on_eliminar_landmark(int p_id_landmark, long p_timeout_ms = 5000);

				/**
				* @brief Elimina landmark por posicion
				*/
				void on_eliminar_landmark(agv::DatosPose p_pos_landmark, long p_timeout_ms = 5000);

				/**
				* @brief Aplica una matriz de transformacion a todos los landmarks temporales
				*/
				void on_offset_landmarks(const agv::MatrizDeTransformacion& p_matriz_transform, long p_timeout_ms = 5000);

				/**
				* @brief Actualiza los datos internos de posicion y landmarks y devuelve la posicion del equipo e informacion de landmarks
				*/
				std::pair<agv::DatosPose, std::vector<LandmarkHmi>> update_data(long p_timeout_ms = 5000);

				std::vector<NavContourPoint> get_contour_data() const { return m_contorno; }

				/*
				* METODOS SIN EXCEPCIONES
				*/

				/**
				* @brief Establece el origen de coordenadas en funcion de los reflectores visibles
				* @param p_pos_inicial Especifica las coordenadas que queremos que tenga el equipo en el momento de la calibracion
				* ES MUY IMPORTANTE AVISAR QUE EL EQUIPO SE MANTENGA QUIETO MIENTRAS SE REALIZA LA CALIBRACION
				* LA CALIBRACION ES LENTA, PUEDE DURAR MAS DE UN MINUTO.
				*/
				std::pair<bool, std::string> on_punto_de_partida_noexcept(agv::DatosPose p_pos_inicial, long p_timeout_ms = 60000);

				/**
				* @brief Realiza un mapeo de los landmarks actuales para incluirlos en el equipo
				* ES MUY IMPORTANTE AVISAR QUE EL EQUIPO SE MANTENGA QUIETO MIENTRAS SE REALIZA LA CALIBRACION
				* LA CALIBRACION ES LENTA, PUEDE DURAR MAS DE UN MINUTO.
				*/
				std::pair<bool, std::string> on_incluir_reflectores_noexcept(long p_timeout_ms = 60000);

				/**
				* @brief Elimina todos los reflectores guardados
				*/
				std::pair<bool, std::string> on_eliminar_reflectores_noexcept(long p_timeout_ms = 5000);

				/**
				* @brief Carga el layout que tiene el sensor en memoria al PC
				*/
				std::pair<bool, std::string> on_cargar_layout_actual_noexcept(long p_timeout_ms = 5000);

				/**
				* @brief Descarga el layout del PC al sensor
				*/
				std::pair<bool, std::string> on_descargar_layout_actual_noexcept(long p_timeout_ms = 5000);
				
				/**
				* @brief Carga el fichero de reflectores de la ruta especificada
				*/
				std::pair<bool, std::string> on_cargar_reflectores_fichero_noexcept(std::string p_ruta_fichero, long p_timeout_ms = 5000);

				/**
				* @brief Guarda los reflectores actuales en la ruta especificada
				*/
				std::pair<bool, std::string> on_guardar_reflectores_fichero_noexcept(std::string p_ruta_fichero);

				/**
				* @brief Actualiza los datos internos de posicion y landmarks
				* Este metodo solo es util para clases derivadas
				*/
				std::pair<bool, std::string> on_actualizar_datos_noexcept(long p_timeout_ms = 5000);

				/**
				* @brief Elimina landmark por ID
				*/
				std::pair<bool, std::string> on_eliminar_landmark_noexcept(int p_id_landmark, long p_timeout_ms = 5000);

				/**
				* @brief Elimina landmark por posicion
				*/
				std::pair<bool, std::string> on_eliminar_landmark_noexcept(agv::DatosPose p_pos_landmark, long p_timeout_ms = 5000);

				/**
				* @brief Actualiza los datos internos de posicion y landmarks y devuelve la posicion del equipo e informacion de landmarks
				*/
				std::pair<std::pair<agv::DatosPose, std::vector<LandmarkHmi>>, std::pair<bool, std::string>> update_data_noexcept(long p_timeout_ms = 5000);

				/**
				* @brief Aplica una matriz de transformacion a todos los landmarks temporales
				*/
				std::pair<bool, std::string> on_offset_landmarks_noexcept(const agv::MatrizDeTransformacion& p_matriz_transform, long p_timeout_ms = 5000);

			protected:
				bool m_sin_reflectores;
				agv::DatosPose m_posicion;
				agv::comtcp::nav350::ComNav350& m_nav350;
				std::vector<agv::comtcp::nav350::Landmark> m_reflectores_actuales;
				std::vector<agv::comtcp::nav350::MappedLandmark> m_reflectores_vistos;
				std::vector<agv::comtcp::nav350::NavContourPoint> m_contorno;
				agv::comtcp::nav350::DatosNav m_datos_nav;

				void enviar_layout_temporal(long p_timeout_ms = 5000);
			};
		}
	}
}
#endif /* COM_NAV350_H */
