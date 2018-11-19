#pragma once

#include "../../../../generales/utils.h"
#include "../cliente_tcp.h"
#include <vector>
#include <string>
#include <iostream>

namespace agv
{
	namespace comtcp
	{
		/**
		*	Wrapper de comunicaciones mediante process interface
		*	Process interface version V3: <Ticket><Length>CR+LF<Ticket><Content>CR+LF
		*
		*	<Ticket> Ticket del paquete
		*	[0]		49 '1'	
		*	[1]		48 '0'	
		*	[2]		48 '0'	
		*	[3]		48 '0'	
		*
		*	<Length> Longitud, comienza con una L mayuscula y continua con el tamaño del segundo paquete en 9 caracteres ASCII (El segundo paquete comienza en el byte 16)
		*	[4]		76 'L'	
		*	[5]		48 '0'	
		*	[6]		48 '0'	
		*	[7]		48 '0'	
		*	[8]		48 '0'	
		*	[9]		48 '0'	
		*	[10]	48 '0'	
		*	[11]	48 '0'	
		*	[12]	48 '0'	
		*	[13]	57 '9'	
		*
		*	<CR+LF> Fin del primer paquete con retorno de carro y fin de linea
		*	[14]	13 '\r'	
		*	[15]	10 '\n'	
		*
		*	<Ticket> Ticket del paquete (igual que el de arriba)
		*	[16]	49 '1'	
		*	[17]	48 '0'	
		*	[18]	48 '0'	
		*	[19]	48 '0'	
		*
		*	<Content> Comando de envio (en este caso cambio de programa al numero 2)
		*	[20]	97 'a'	
		*	[21]	48 '0'	
		*	[22]	50 '2'	
		*
		*	<CR+LF> Fin del segundo paquete con retorno de carro y fin de linea
		*	[23]	13 '\r'	
		*	[24]	10 '\n'	
		*
		*/
		class TramaProcessInterfaceV3
		{
		public:
			//Estatico
			static void enviar_datos(std::vector<unsigned char> p_vector_datos, ClienteTcp& p_cliente, int p_ticket = 1000, long p_timeout_ms = 0);
			template<typename Iterator>
			static void enviar_datos(Iterator p_begin, Iterator p_end, ClienteTcp& p_cliente, int p_ticket = 1000, long p_timeout_ms = 0);
			template<typename Iterator>
			static std::vector<unsigned char> generar_trama(Iterator p_begin, Iterator p_end, int p_ticket = 1000);
			static std::vector<unsigned char> generar_trama(const std::vector<unsigned char>& p_vector, int p_ticket = 1000);
			template<typename Iterator>
			static std::vector<unsigned char> pocesar_trama(Iterator p_begin, Iterator p_end, int p_ticket = 0);
			static std::vector<unsigned char> pocesar_trama(const std::vector<unsigned char>& p_vector, int p_ticket = 0);

			static std::vector<unsigned char> recibir_datos(ClienteTcp& p_cliente, int p_ticket = 0, long p_timeout_ms = 0)
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
				
					std::vector<unsigned char> vector_recibido;
					//Leer buffer TCP
					try
					{
						vector_recibido = p_cliente.lee_buffer_actual(temporizador_timeout.restante_ms(), procesado_trama.get_num_datos_necesarios());
					}
					catch (...)
					{
						if (temporizador_timeout.terminado())
						{
							throw;
						}
						else
						{
							continue;
						}
					}
				
					//Procesamos la trama recibida
					procesado_trama.pocesar_datos(vector_recibido.begin(), vector_recibido.end(), p_ticket);

					trama_recibida = procesado_trama.datos_disponibles();
				}

				return procesado_trama.obten_datos();
			}

		private:
			struct ProcesadoDeTrama
			{
				ProcesadoDeTrama() 
					: m_estado_procesamiento_trama(Estado_Proceso_Trama::ESPERANDO_LENGTH)
					, m_hay_datos(false) 
				{};
				template<typename Iterator>
				void pocesar_datos(Iterator p_begin, Iterator p_end, int p_ticket = 1000);
				bool datos_disponibles();
				std::vector<unsigned char> obten_datos();
				void reiniciar();
				void reiniciar_trama_aux();
				bool cliente_espera_respuesta();
				std::size_t get_num_datos_necesarios();

				enum class Estado_Proceso_Trama
				{
					ESPERANDO_LENGTH = 1,
					ESPERANDO_DATOS = 2,
				} m_estado_procesamiento_trama;

				std::vector<unsigned char> m_datos_aux;
				std::vector<unsigned char> m_datos;
				std::size_t m_tam_datos;
				bool m_hay_datos;
			};
		};

		inline void TramaProcessInterfaceV3::enviar_datos(std::vector<unsigned char> p_vector_datos, ClienteTcp& p_cliente, int p_ticket, long p_timeout_ms)
		{
			p_cliente.envia_vector_bytes(generar_trama(p_vector_datos.begin(), p_vector_datos.end(), p_ticket), p_timeout_ms);
		}

		template<typename Iterator>
		void TramaProcessInterfaceV3::enviar_datos(Iterator p_begin, Iterator p_end, ClienteTcp& p_cliente, int p_ticket, long p_timeout_ms)
		{
			p_cliente.envia_vector_bytes(generar_trama(std::forward<Iterator>(p_begin), std::forward<Iterator>(p_end), p_ticket), p_timeout_ms);
		}

		inline std::vector<unsigned char> TramaProcessInterfaceV3::generar_trama(const std::vector<unsigned char>& p_vector, int p_ticket)
		{
			return generar_trama(p_vector.begin(), p_vector.end(), p_ticket);
		}

		inline std::vector<unsigned char> TramaProcessInterfaceV3::pocesar_trama(const std::vector<unsigned char>& p_vector, int p_ticket)
		{
			return pocesar_trama(p_vector.begin(), p_vector.end(), p_ticket);
		}

		/**
		* Genera una trama de process interface a partir de iteradores de contenedor STL
		* 
		*/
		template<typename Iterator>
		std::vector<unsigned char> TramaProcessInterfaceV3::generar_trama(Iterator p_begin, Iterator p_end, int p_ticket)
		{
			uint16_t tam_trama = (p_end - p_begin);

			if (p_ticket < 1000 || p_ticket > 9999)
			{
				throw(std::invalid_argument("El ticket debe estar comprendido entre 1000 y 9999"));
			}

			//En el bit 4 se envia el tipo de trama: 1 = escritura, 2 = lectura_escritura
			std::string ticket = std::to_string(p_ticket);
			std::vector<unsigned char> trama{ ticket.begin(), ticket.end() };

			trama.reserve(tam_trama + 18);

			trama.push_back('L');

			std::string str_tam = std::to_string(tam_trama + 6);
			std::size_t tam_string = str_tam.size();

			if (tam_string < 9)
			{
				str_tam = std::string(9 - tam_string, '0') + str_tam;
			}

			//Longitud
			trama.insert(trama.end(), str_tam.begin(), str_tam.end());
			trama.push_back(13); //CR
			trama.push_back(10); //LF

			//Datos
			trama.insert(trama.end(), ticket.begin(), ticket.end());
			trama.insert(trama.end(), p_begin, p_end);
			trama.push_back(13); //CR
			trama.push_back(10); //LF

			return trama;
		}

		template<typename Iterator>
		inline std::vector<unsigned char> TramaProcessInterfaceV3::pocesar_trama(Iterator p_begin, Iterator p_end, int p_ticket)
		{
			ProcesadoDeTrama procesado_trama;
			procesado_trama.pocesar_datos(std::forward<Iterator>(p_begin), std::forward<Iterator>(p_end), p_ticket); //TODO: Perfect forwarding
			return procesado_trama.obten_datos();
		}

		template<typename Iterator>
		void TramaProcessInterfaceV3::ProcesadoDeTrama::pocesar_datos(Iterator p_begin, Iterator p_end, int p_ticket)
		{
			for (auto iterador_trama = p_begin; iterador_trama != p_end;)
			{
				switch (m_estado_procesamiento_trama)
				{
				case Estado_Proceso_Trama::ESPERANDO_LENGTH:
				{
					int tam_length_restante = 16 - m_datos_aux.size();
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
						tam_length_restante = 16 - m_datos_aux.size();
					}

					if (tam_length_restante == 0)
					{
						//Obtengo el ticket
						int ticket = std::stod(std::string(m_datos_aux.begin(), m_datos_aux.begin() + 4));
						if (p_ticket != 0 && ticket != p_ticket)
						{
							throw(std::runtime_error("Los tickets no coinciden"));
						}
						//Obtenemos el numero de datos
						if (m_datos_aux[4] != 'L')
						{
							throw(std::runtime_error("Trama incorrecta"));
						}
						std::string test(m_datos_aux.begin() + 5, m_datos_aux.begin() + 14);
						m_tam_datos = std::stod(test);
						//Esperamos CR LF
						if (m_datos_aux[14] != 13 || m_datos_aux[15] != 10)
						{
							throw(std::runtime_error("Trama incorrecta"));
						}
						m_estado_procesamiento_trama = Estado_Proceso_Trama::ESPERANDO_DATOS;
						m_datos_aux.clear();
					}
				}
					break;
				case Estado_Proceso_Trama::ESPERANDO_DATOS:
				{
					int tam_length_restante = m_tam_datos - m_datos_aux.size();
					int tam_trama_recibida = p_end - iterador_trama;
					
					if(tam_length_restante > 0)
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
						tam_length_restante = m_tam_datos - m_datos_aux.size();
					}

					if (tam_length_restante <= 0)
					{
						//Obtengo el ticket
						int ticket = std::stod(std::string(m_datos_aux.begin(), m_datos_aux.begin() + 4));
						if (p_ticket != 0 && ticket != p_ticket)
						{
							throw(std::runtime_error("Los tickets no coinciden"));
						}
						//Obtenemos los datos
						m_datos = { m_datos_aux.begin() + 4, m_datos_aux.end() - 2 };
						//Esperamos CR LF
						if (*(m_datos_aux.end() - 2) != 13 || *(m_datos_aux.end() - 1) != 10)
						{
							throw(std::runtime_error("Trama incorrecta"));
						}
						m_estado_procesamiento_trama = Estado_Proceso_Trama::ESPERANDO_LENGTH;
						m_datos_aux.clear();
						m_hay_datos = true;
					}
				}
					break;
				}
			}
		}

		inline bool TramaProcessInterfaceV3::ProcesadoDeTrama::datos_disponibles()
		{
			return m_hay_datos;
		}

		inline std::vector<unsigned char> TramaProcessInterfaceV3::ProcesadoDeTrama::obten_datos()
		{
			return m_datos;
		}

		inline void TramaProcessInterfaceV3::ProcesadoDeTrama::reiniciar()
		{
			m_datos.clear();
			m_hay_datos = false;
			reiniciar_trama_aux();
		}

		inline void TramaProcessInterfaceV3::ProcesadoDeTrama::reiniciar_trama_aux()
		{
			m_datos_aux.clear();
			m_tam_datos = 0;
			m_estado_procesamiento_trama = Estado_Proceso_Trama::ESPERANDO_LENGTH;
		}
		
		inline std::size_t agv::comtcp::TramaProcessInterfaceV3::ProcesadoDeTrama::get_num_datos_necesarios()
		{
			if (m_estado_procesamiento_trama == Estado_Proceso_Trama::ESPERANDO_LENGTH)
			{
				return 16 - m_datos_aux.size();
			}
			else
			{
				return m_tam_datos - m_datos_aux.size();
			}
		}
	}
}

