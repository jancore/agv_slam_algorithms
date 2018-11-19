/*
* File:   protocolo_red_agv.h
* Author: Jesus Rueda
*
* Created on 28-09-2017
*/

#pragma once

//Librerias
#include "../cliente_tcp.h"
#include "../async_server_tcp.h"
#include "../../../../generales/utils.h"
#include "../../../../generales/delegate.h"
//STL
#include <atomic>
#include <cstdint>
#include <vector>
#include <string>

//
//	Comunicacion con los clientes
//

namespace agv
{
	namespace comtcp
	{
		/**
		* @brief Comandos estandar de comunicacion en alto nivel para el conjunto de herramientas AGV
		*
		* Los siguientes comandos han sido propuestos para estandarizar todas las comunicaciones de alto nivel entre el AGV, el Servidor, las Estaciones y los Clientes.
		* Para mas informacion acudir a @ref protocolo_com_agv
		*/
		enum class Comandos_Red_Agv
		{
			//Comandos de red
			logIn,				///<Autentifica al usuario al conectar con el servidor. Es necesario autentificarse antes de enviar comandos. Argumentos: ninguno, el nombre de usuario se toma de la cabecera, en el futuro se incluira un password
			logOut,				///<Cierre de sesion del usuario. Argumentos: ninguno
			rawMessage,			///<Envia un mensaje directo a un cliente. Argumentos: Mensaje en crudo hasta el fin de trama
			configHeartbeatPayload,
			hbSync,
			getVersionInfo,

			//Comandos de control del agv
			getStatus,			///<Obtiene los datos de estado del destinatario. Argumentos: ninguno
			newProgram,			///<Solicita que el destinatario ejecute un programa. Argumentos: tag_programa argumento1=valor2 argumento2=valor2 ... argumenton=valorn
			cancelProgram,		///<Termina la ejecucion del programa del destinatario. Argumentos: ninguno
			setMode,			///<Cambia el modo de ejecucion del destinatario. Argumentos: [modo de funcionamiento](@ref agv::programas::Modo_Funcionamiento) en string (UNA_EJECUCION, CICLICO, CON_MAESTRO...)
			reloadSettings,		///<Fuerza que el destinatario recargue la configuracion desde fichero. Argumentos: ninguno
			setParameter,		///<Modifica parametros de configuracion del destinatario. Argumentos: parametro1=valor1 parametro2=valor2 ... parametron=valorn
			getParameter,		///<Lee parametros de configuracion del destinatario. parametro1 parametro2 ... parametron
			setVariable,		///<Modifica variables de programa en el destinatario. Argumentos: variable1=valor1 variable2=valor2 ... variablen=valorn
			getVariable,		///<Lee variables de programa del destinatario. Argumentos: variable1 variable2 ... variablen
			resetProgramWatchdog, ///Reinicia el contador watchdog de programa
			changeHmiMessage,   ///<Cambia el mensaje a mostrar en la pantalla emergente del PLC. Argumentos: timeout_s message

			//Comandos del maestro
			getAgvInfo,			///<Recibe informacion de los AGVs conectados al maestro. Responde una trama con el numero de AGVs conectados seguido de los tags de red de los AGVs separados por espacios

			getZoneStatus,		///<[NO DISPONIBLE]Obtiene el estado de una zona. Argumentos por definir
			checkZonePermission, ///<Comprueba si un AGV tiene permiso para transitar por una zona. Argumentos: id_zona id_agv
			reserveZone,		///<Reserva una zona para un AGV concreto. Argumentos: id_zona id_agv condiciones_desbloqueo timeout_s
			freeZone,			///<Libera una zona de un AGV. Argumentos: id_zona id_agv
			newZone,			///<Genera una nueva zona en el maestro. Argumentos: tag_zona, Tipo_Zona, Point[x,y]...
			delZone,			///<Elimina una zona del maestro mediante su tag. Argumentos: tag_zona
			
			setVariableIf,		///<Modifica el valor de una variable si se cumple la condicion. Argumentos condicion="expresion booleana" variable=nombre_var valor=valor_variable. Responde 1 o 0 y el valor de la variable

			//Comandos del ITC
			reserveRoute,
			freeRoute,
			getLayoutCrc,

			//Comandos del SGA
			loadSpot,			///<Genera una carga en un punto de carga del SGA
			unloadSpot,			///<Descarga un punto de carga del SGA
			modifyLoad,			///<Cambia las propiedades de una carga
			getSpotInfo,		///<Obtiene la información de un punto de carga del SGA
			getLoadInfo,		///<Obtiene la información de una carga

			//Comandos para el GAO
			newAgvGroup,		///<Crea un nuevo grupo de AGVs en el GAO. Argumentos: group="nombre del grupo" agv="listado de agvs separados por espacios". Especificar ANY para todos los AGV o NONE para ninguno
			removeAgvGroup,		///<Elimina un grupo existente en el GAO. Argumentos: group="nombre del grupo"
			getGroupList,		///<Obtiene el listado de grupos de GAO
			getAgvsInGroup,		///<Obtiene el listado de agvs dentro de un grupo. Argumentos: group="nombre del grupo"
			addAgvToGroup,		///<Añade AGVs de un grupo existente. Argumentos: group="nombre del grupo" agv="listado de agvs separados por espacios". Especificar ANY para todos los AGV o NONE para ninguno
			removeAgvFromGroup, ///<Elimina AGVs de un grupo existente. Argumentos: group="nombre del grupo" agv="listado de agvs separados por espacios". Especificar ANY para todos los AGV o NONE para ninguno
			getGroupsOfAgv,		///<Obtiene el listado de grupos a los que pertenece un AGV. Argumentos: agv="tag del AGV"
			setGroupsOfAgv,		///<Establece los grupos a los que pertenece un AGV, eliminandolo de los que no aparezcan en el listado. Argumentos: agv="listado de agvs separados por espacios" group="listado de grupos separados por espacios"

			newRequest,			///<Envía una solicitud al maestro o actualiza una solicitud ya existente. Argumentos: tipo_solicitud, argumentos_solicitud
			cancelRequest,		///<Cancela solicitudes del maestro. Argumentos: int id_solicitud_a_cancelar ...
			getRequestStatus,	///<Lee datos de solicitudes. Se pueden pasar como argumentos el numero de las solicitudes concretas que se quieren leer o no pasar argumentos para leerlas todas.
		};

		std::string comando_red_to_string(Comandos_Red_Agv p_comando);
		Comandos_Red_Agv string_to_comando_red(const std::string& p_comando);

		#define DESHABILITA_COMPROBACION_TAM_TRAMA
		//#define HABILITA_LOG_NET_CONTROLLER

		constexpr auto gc_tag_red_agv_broadcast = "RBCAST";
		constexpr auto gc_nombre_master = "SRV";
		constexpr auto gc_tag_red_sga = "SGA";
		constexpr auto gc_nombre_red_gao = "GAO";
		constexpr auto gc_nombre_red_itc = "ITC";
		constexpr auto gc_nombre_red_improc = "IMPROC";
		constexpr auto gc_nombre_listeners = "LISTENER";

		class ProtocoloRedAgv
		{
		public:
			struct Paquete;

			struct Cliente : public agv::comtcp::ClienteServidorTcpBase
			{
				friend class ProtocoloRedAgv;
			public:
				using agv::comtcp::ClienteServidorTcpBase::ClienteServidorTcpBase;
				virtual ~Cliente() = default;

				void set_nombre(const std::string p_nombre) { m_nombre = p_nombre; }
				std::string get_nombre() const { return m_nombre; }

				//Thread safe
				void limpia_buffers_protocolo() override final;

			protected:
				//Thread safe
				//Devuelve true si se ha encontrado el paquete de respuesta, devuelve false si no se ha encontrado
				bool evalua_respuesta(const Paquete& p_paquete);
				void paquete_a_espera_respuesta(const Paquete& p_paquete);

			private:
				std::string m_nombre;
				agv::SpinLock sm_sl_buffer_espera_respuestas;
				std::vector<Paquete> sm_buffer_espera_respuestas;
			};

			struct Paquete
			{
				enum class Tipo_Paquete : unsigned char
				{
					CONSULTA = 5,
					BINARIO = 17,
					ACK = 6,
					NACK = 21,
					NET_ERROR = 27,
					RAW = 20,
				};

				static Tipo_Paquete char_to_tipo_paquete(unsigned char c);

				Paquete() = default;
				Paquete(Tipo_Paquete p_tipo, const std::string& p_origen, const std::string& p_destino, const std::string& p_comando, std::weak_ptr<Cliente> p_socket = std::weak_ptr<Cliente>(), long p_timestamp = agv::GlobalTimestamp::now())
					: tipo(p_tipo)
					, origen(p_origen)
					, destino(p_destino)
					, comando(p_comando)
					, timestamp(p_timestamp)
					, socket(p_socket)
				{}

				//Puede tirar std::exception
				Paquete(const std::string& p_string)
				{
					from_network(p_string);
				}

				//Puede tirar std::exception
				void from_network(const std::string& p_network);
				std::vector<unsigned char> to_network();
				std::string to_network_ascii();

				Tipo_Paquete tipo;
				std::string origen;
				std::string destino;
				std::string comando;
				std::vector<unsigned char> comando_binario;
				long timestamp = agv::GlobalTimestamp::now(); //Los paquetes de respuesta deben llevar el timestamp del paquete al que responden!
				long timeout_respuesta = 1000;
				long timeout_paquete = 5000;
				std::weak_ptr<Cliente> socket;

				//Mucho ojo con la interaccion entre hilos, si los paquetes se gestionan en otro hilo el delegado debe estra protegido contra race conditions
				//Este delegado NO PUEDE TIRAR EXCEPCIONES
				delegate<void(void)> on_enviado_correctamente = nullptr;
				//Mucho ojo con la interaccion entre hilos, si los paquetes se gestionan en otro hilo el delegado debe estra protegido contra race conditions
				//Este delegado NO PUEDE TIRAR EXCEPCIONES
				delegate<void(const std::string&)> on_error_envio = nullptr;
				//Mucho ojo con la interaccion entre hilos, si los paquetes se gestionan en otro hilo el delegado debe estra protegido contra race conditions
				delegate<void(const Paquete&)> on_respuesta = nullptr;
				//Mucho ojo con la interaccion entre hilos, si los paquetes se gestionan en otro hilo el delegado debe estra protegido contra race conditions
				//Este delegado NO PUEDE TIRAR EXCEPCIONES
				delegate<void(void)> on_timeout_respuesta = nullptr;
				//Mucho ojo con la interaccion entre hilos, si los paquetes se gestionan en otro hilo el delegado debe estra protegido contra race conditions
				//Este delegado NO PUEDE TIRAR EXCEPCIONES
				delegate<bool(uint32_t)> check_cancelado = nullptr;

				uint32_t get_numero_paquete() const { return m_numero_paquete; };
				void asigna_numero_paquete();
				Paquete compon_respuesta(bool p_ack_ok, const std::string& p_comando) const;

			private:
				uint32_t m_numero_paquete = 0;
				static std::atomic<unsigned int> m_ultimo_paquete;
			};

			static Paquete nueva_consulta_ascii(const std::string& p_origen, const std::string& p_destino, const std::string& p_comando, std::weak_ptr<Cliente> p_socket = std::weak_ptr<Cliente>());
			static Paquete nueva_consulta_binaria(const std::vector<unsigned char>& p_comando, std::weak_ptr<Cliente> p_socket = std::weak_ptr<Cliente>());
			
			//Puede tirar ExcepcionTcp
			static void recibir_datos(Cliente& p_cliente, std::vector<Paquete>& ret_paquetes_retorno, long p_timeout_por_paquete = 1000);
			//Puede tirar ExcepcionTcp
			static void enviar_datos(Cliente& p_cliente, std::vector<Paquete>& p_paquetes_envio, long p_timeout_por_paquete = 1000);
			//Puede tirar ExcepcionTcp
			static void enviar_datos(Paquete& p_paquete, Cliente& p_cliente, long p_timeout_por_paquete = 1000);
			//Puede tirar ExcepcionTcp
			static void establece_conexion(Cliente& p_cliente, long p_timeout = 1000);
			//Puede tirar ExcepcionTcp
			static void establece_conexion(Cliente& p_cliente, const std::string& p_ip, int p_puerto, long p_timeout = 1000);
			static void desconectar(Cliente& p_cliente);

			static void limpia_buffer(std::vector<Paquete>& p_buffer);
			static void cancela_paquetes(std::vector<Paquete>& p_buffer, const std::string& p_razon);
		};

		template<typename T_Protocolo>
		class WrapperClienteProtocolo : public T_Protocolo::Cliente
		{
		public:
			typedef typename T_Protocolo::Paquete Paquete;
			using T_Protocolo::Cliente::Cliente;
			virtual ~WrapperClienteProtocolo() = default;

			using T_Protocolo::Cliente::listo_para_recibir;

			//Puede tirar ExcepcionTcp
			void recibir_datos(std::vector<Paquete>& ret_paquetes_retorno, long p_timeout_por_paquete = 1000) { T_Protocolo::recibir_datos(*this, ret_paquetes_retorno, p_timeout_por_paquete); }
			//Puede tirar ExcepcionTcp
			void enviar_datos(std::vector<Paquete>& p_paquetes_envio, long p_timeout_por_paquete = 1000) { T_Protocolo::enviar_datos(*this, p_paquetes_envio, p_timeout_por_paquete = 1000); }
			//Puede tirar ExcepcionTcp
			void enviar_datos(Paquete& p_paquete, long p_timeout_por_paquete = 1000) { T_Protocolo::enviar_datos(p_paquete, *this, p_timeout_por_paquete = 1000); }
			//Puede tirar ExcepcionTcp
			void establece_conexion(long p_timeout = 1000) { T_Protocolo::establece_conexion(*this, p_timeout = 1000); }
			//Puede tirar ExcepcionTcp
			void establece_conexion(const std::string& p_ip, int p_puerto, long p_timeout = 1000) 
			{ 
				T_Protocolo::establece_conexion(*this, p_ip, p_puerto, p_timeout = 1000); 
			}
			void desconectar() { T_Protocolo::desconectar(*this); }
		};
	}
}