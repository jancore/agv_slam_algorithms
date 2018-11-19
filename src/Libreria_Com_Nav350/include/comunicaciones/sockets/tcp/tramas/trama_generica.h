#pragma once

#include "../../../../generales/utils.h"
#include "../../../../generales/logger.h"
#include "../cliente_tcp.h"
#include <vector>

namespace agv
{
	namespace comtcp
	{
		class TramaGenerica
		{
		public:
			struct PaqueteComunicacion
			{
				PaqueteComunicacion(std::vector<unsigned char> p_datos = {}, bool p_espera_respuesta = false, uint64_t p_timestamp = agv::GlobalTimestamp::now())
					: datos(p_datos)
					, espera_respuesta(p_espera_respuesta)
					, timestamp(p_timestamp)
				{}

				std::vector<unsigned char> datos;
				bool espera_respuesta;
				uint64_t timestamp;
			};

			//Estatico
			static void enviar_datos(std::vector<unsigned char> p_vector_datos, ClienteTcp& p_cliente, bool p_espera_respuesta = false, long p_timeout_ms = 0, uint64_t p_timestamp = agv::GlobalTimestamp::now());
			static void enviar_datos(PaqueteComunicacion p_paquete_com, ClienteTcp& p_cliente, long p_timeout_ms = 0);
			template<typename Iterator>
			static void enviar_datos(Iterator p_begin, Iterator p_end, ClienteTcp& p_cliente, bool p_espera_respuesta = false, long p_timeout_ms = 0, uint64_t p_timestamp = agv::GlobalTimestamp::now());
			template<typename Iterator>
			static std::vector<unsigned char> generar_trama(Iterator p_begin, Iterator p_end, bool p_espera_respuesta = false, uint64_t p_timestamp = agv::GlobalTimestamp::now());
			static std::vector<unsigned char> generar_trama(std::vector<unsigned char> p_vector_datos, bool p_espera_respuesta = false, uint64_t p_timestamp = agv::GlobalTimestamp::now());
			static std::vector<unsigned char> generar_trama(PaqueteComunicacion p_paquete_com);
			template<typename Iterator>
			static PaqueteComunicacion pocesar_trama(Iterator p_begin, Iterator p_end);

			static PaqueteComunicacion recibir_datos(ClienteTcp& p_cliente, long p_timeout_ms = 0)
			{
				bool trama_recibida = false;
				Temporizador temporizador_timeout(p_timeout_ms != 0 ? p_timeout_ms : p_cliente.get_timeout_ms());
				ProcesadoDeTrama procesado_trama;

				while (!trama_recibida)
				{
					if (temporizador_timeout.terminado())
					{
						throw (TcpTimeoutExcept("Timeout sobrepasado"));
					}
				
					//Esperamos a que haya datos, el thread duerme mientras tanto
					long tiempo_espera = temporizador_timeout.restante_ms();
					p_cliente.listo_para_recibir(tiempo_espera < 0 ? 0 : tiempo_espera);
				
					//Leer buffer TCP
					std::vector<unsigned char> vector_recibido = p_cliente.lee_buffer_actual(temporizador_timeout.restante_ms(), procesado_trama.get_num_datos_necesarios());

					//Procesamos la trama recibida
					if (!vector_recibido.empty())
					{
						procesado_trama.pocesar_datos(vector_recibido.begin(), vector_recibido.end());

						trama_recibida = procesado_trama.datos_disponibles();
					}
				}

				PaqueteComunicacion paquete_recibido = procesado_trama.get_datos();

				return paquete_recibido;
			}
			
			private:
			class ProcesadoDeTrama
			{
			public:
				ProcesadoDeTrama() 
					: m_estado_procesamiento_trama(Estado_Proceso_Trama::ESPERANDO_CABECERA)
					, m_datos_restantes(c_tam_cabecera)
					, m_hay_datos(false) 
				{};
				
				template<typename Iterator>
				void pocesar_datos(Iterator p_begin, Iterator p_end);
				bool datos_disponibles() const;
				PaqueteComunicacion get_datos() const;
				uint64_t get_timestamp() const{ return m_timestamp; }
				void reiniciar();
				void reiniciar_trama_aux();
				int get_num_datos_necesarios() const { return (int)m_datos_restantes; };
				bool get_espera_respuesta() const { return m_cliente_espera_respuesta; }

				enum class Estado_Proceso_Trama
				{
					ESPERANDO_CABECERA  = 1,
					ESPERANDO_DATOS     = 2,
					ESPERANDO_FIN       = 8
				} m_estado_procesamiento_trama;
				
				static constexpr std::size_t c_tam_cabecera = 3 + 1 + sizeof(uint64_t) + 2;
				static constexpr std::size_t c_tam_fin = 3;
				
				std::vector<unsigned char> m_datos_aux;
				std::vector<unsigned char> m_datos;
				std::size_t m_datos_restantes;
				std::size_t m_tam_datos;
				bool m_hay_datos;
				bool m_cliente_espera_respuesta;
				uint64_t m_timestamp;
			};
		};
		
		inline void agv::comtcp::TramaGenerica::enviar_datos(std::vector<unsigned char> p_vector_datos, ClienteTcp& p_cliente, bool p_espera_respuesta, long p_timeout_ms, uint64_t p_timestamp)
		{
			p_cliente.envia_vector_bytes(generar_trama(p_vector_datos, p_espera_respuesta, p_timestamp), p_timeout_ms);
		}

		inline void TramaGenerica::enviar_datos(PaqueteComunicacion p_paquete_com, ClienteTcp & p_cliente, long p_timeout_ms)
		{
			p_cliente.envia_vector_bytes(generar_trama(p_paquete_com), p_timeout_ms);
		}

		template<typename Iterator>
		void agv::comtcp::TramaGenerica::enviar_datos(Iterator p_begin, Iterator p_end, ClienteTcp& p_cliente, bool p_espera_respuesta, long p_timeout_ms, uint64_t p_timestamp)
		{
			p_cliente.envia_vector_bytes(generar_trama(p_begin, p_end, p_espera_respuesta, p_timestamp), p_timeout_ms);
		}
		
		template<typename Iterator>
		std::vector<unsigned char> TramaGenerica::generar_trama(Iterator p_begin, Iterator p_end, bool p_espera_respuesta, uint64_t p_timestamp)
		{
			uint16_t tam_trama = (p_end - p_begin);

			//En el bit 4 se envia el tipo de trama: 1 = escritura, 2 = lectura_escritura
			std::vector<unsigned char> trama{ 'B', 'E', 'G', (unsigned char)(p_espera_respuesta ? 2 : 1) };
			trama.reserve(tam_trama + ProcesadoDeTrama::c_tam_cabecera + ProcesadoDeTrama::c_tam_fin);

			serializar_entero<decltype(p_timestamp)>(p_timestamp, trama);
			serializar_entero<uint16_t>(tam_trama, trama);
			
			trama.insert(trama.end(), p_begin, p_end);
			
			trama.push_back('F');
			trama.push_back('I');
			trama.push_back('N');

			return trama;
		}

		inline std::vector<unsigned char> TramaGenerica::generar_trama(std::vector<unsigned char> p_vector_datos, bool p_espera_respuesta, uint64_t p_timestamp)
		{
			return generar_trama(p_vector_datos.begin(), p_vector_datos.end(), p_espera_respuesta, p_timestamp);
		}

		inline std::vector<unsigned char> TramaGenerica::generar_trama(PaqueteComunicacion p_paquete_com)
		{
			return generar_trama(p_paquete_com.datos.begin(), p_paquete_com.datos.end(), p_paquete_com.espera_respuesta, p_paquete_com.timestamp);
		}

		template<typename Iterator>
		typename agv::comtcp::TramaGenerica::PaqueteComunicacion TramaGenerica::pocesar_trama(Iterator p_begin, Iterator p_end)
		{
			ProcesadoDeTrama procesado_trama;
			procesado_trama.pocesar_datos(p_begin, p_end);
			
			PaqueteComunicacion paquete_recibido;
			if (procesado_trama.datos_disponibles())
				paquete_recibido = procesado_trama.get_datos();
			
			return paquete_recibido;
		}

		template<typename Iterator>
		void TramaGenerica::ProcesadoDeTrama::pocesar_datos(Iterator p_begin, Iterator p_end)
		{
			for (auto iterador_trama = p_begin; iterador_trama != p_end;)
			{
				int tam_length_restante = m_datos_restantes - m_datos_aux.size();
				int tam_trama_recibida = p_end - iterador_trama;

				if (tam_length_restante > 0)
				{
					if ((tam_length_restante - tam_trama_recibida) >= 0)
					{
						m_datos_aux.insert(m_datos_aux.end(), iterador_trama, p_end);
						iterador_trama = p_end;
					}
					else
					{
						m_datos_aux.insert(m_datos_aux.end(), iterador_trama, iterador_trama + tam_length_restante);
						iterador_trama += tam_length_restante;
					}
					tam_length_restante = m_datos_restantes - m_datos_aux.size();
				}
				
				if (tam_length_restante == 0)
				{
					switch (m_estado_procesamiento_trama)
					{
					case Estado_Proceso_Trama::ESPERANDO_CABECERA:
						{
							//Proceso cabecera
							//Compruebo letras BEG
							if (m_datos_aux[0] != 'B' || m_datos_aux[1] != 'E' || m_datos_aux[2] != 'G')
							{
								throw (std::runtime_error("Trama incorrecta"));
							}
							
							//Leo si espera respuesta
							if (m_datos_aux[3] == 1) //(1 = escritura, 2 = lectura_escritura)
							{
								m_cliente_espera_respuesta = false;
							}
							else if (m_datos_aux[3] == 2)
							{
								m_cliente_espera_respuesta = true;
							}
							else
							{
								throw (std::runtime_error("Trama incorrecta"));
							}
							
							auto iterador_aux = m_datos_aux.begin() + 4;
							auto fin_trama = m_datos_aux.end();
							
							//Leo el timestamp
							m_timestamp = agv::deserializar_entero<decltype(m_timestamp)>(iterador_aux, fin_trama);
							
							//Leo el numero de datos finales
							m_tam_datos = agv::deserializar_entero<int16_t>(iterador_aux, fin_trama);
							
							m_datos_restantes = m_tam_datos;
							m_estado_procesamiento_trama = Estado_Proceso_Trama::ESPERANDO_DATOS;
							m_datos_aux.clear();
						}
						break;
					case Estado_Proceso_Trama::ESPERANDO_DATOS:
						{
							//Copio los datos
							m_datos = m_datos_aux;
							m_datos_aux.clear();
							m_estado_procesamiento_trama = agv::comtcp::TramaGenerica::ProcesadoDeTrama::Estado_Proceso_Trama::ESPERANDO_FIN;
							m_datos_restantes = c_tam_fin;
						}
						break;
					case agv::comtcp::TramaGenerica::ProcesadoDeTrama::Estado_Proceso_Trama::ESPERANDO_FIN:
						{
							//Compruebo letras FIN
							if (m_datos_aux[0] != 'F' || m_datos_aux[1] != 'I' || m_datos_aux[2] != 'N')
							{
								throw (std::runtime_error("Trama incorrecta"));
							}
							m_hay_datos = true;
							reiniciar_trama_aux();
						}
					}
				}
			}
		}

		inline bool TramaGenerica::ProcesadoDeTrama::datos_disponibles() const
		{
			return m_hay_datos;
		}

		inline typename TramaGenerica::PaqueteComunicacion TramaGenerica::ProcesadoDeTrama::get_datos() const
		{
			PaqueteComunicacion paquete_com;
			paquete_com.datos = m_datos;
			paquete_com.espera_respuesta = m_cliente_espera_respuesta;
			paquete_com.timestamp = m_timestamp;

			return paquete_com;
		}
		
		inline void TramaGenerica::ProcesadoDeTrama::reiniciar()
		{
			m_datos.clear();
			m_hay_datos = false;
			m_cliente_espera_respuesta = false;
			reiniciar_trama_aux();
		}

		inline void TramaGenerica::ProcesadoDeTrama::reiniciar_trama_aux()
		{
			m_datos_aux.clear();
			m_datos_restantes = c_tam_cabecera;
			m_tam_datos = 0;
			m_estado_procesamiento_trama = Estado_Proceso_Trama::ESPERANDO_CABECERA;
		}
	}
}