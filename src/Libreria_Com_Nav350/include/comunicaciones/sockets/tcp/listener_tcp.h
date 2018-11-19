/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 /*
  * File:   com_io_tcp.hpp
  * Author: jesus
  *
  * Created on 15 de enero de 2016, 13:01
  */

#pragma once

#include "../../../Librerias.h"
#include "../../../generales/delegate.h"
#include "cliente_tcp.h"
//Librerias STL
#include <string>
#include <stdexcept>

namespace agv
{
	namespace comtcp
	{
		class ListenerTcp
		{
		public:
			ListenerTcp(int p_pueto_conexion = 0);
			bool running() const;
			void start(int p_puerto_conexion = 0);
			void stop();
			bool hay_cliente_disponible(long p_timeout_ms = 0);
			ClienteTcp aceptar_cliente(long p_timeout_ms = 0);
			void set_timeout(long p_timeout_ms);

			//Comprueba si el socket esta listo para recibir datos, puede tirar ExceptionTcp
			std::pair<std::vector<ClienteTcp*>, bool> comprueba_clientes(std::vector<ClienteTcp*> p_clientes, long p_timeout_ms = 0);

			template<typename T_Cliente>
			std::pair<std::vector<std::shared_ptr<T_Cliente>>, bool> comprueba_clientes(const std::vector<std::shared_ptr<T_Cliente>>& p_clientes, long p_timeout_ms = 0)
			{
				if (!m_socket_iniciado)
					throw(TcpClosedExcept("No se ha configurado el servidor"));

				long timeout_select = (p_timeout_ms != 0) ? p_timeout_ms : 1;

				timeval timeout = { 0, timeout_select * 1000 }; // timeout simbolico de 1ms para comprobar si hay datos

				fd_set flag_lectura; // flags de lectura
				FD_ZERO(&flag_lectura);

				int mayor_socket = m_socket_conexion;
				FD_SET(m_socket_conexion, &flag_lectura);

				for (auto cliente_i : p_clientes)
				{
					if (cliente_i->m_esta_conectado)
					{
						if (mayor_socket < cliente_i->m_socket)
							mayor_socket = cliente_i->m_socket;

						FD_SET(cliente_i->m_socket, &flag_lectura);
					}
				}

				int error = select(mayor_socket + 1, &flag_lectura, (fd_set*)NULL, (fd_set*)NULL, &timeout);

				//Si se produce error
				if (error < 0)
				{
					throw(TcpClosedExcept());
				}

				std::vector<std::shared_ptr<T_Cliente>> vector_retorno;

				//Socket listo para enviar
				for (auto cliente_i : p_clientes)
				{
					if (FD_ISSET(cliente_i->m_socket, &flag_lectura))
					{
						vector_retorno.emplace_back(cliente_i);
					}
				}

				return { vector_retorno, FD_ISSET(m_socket_conexion, &flag_lectura) };
			}

			//ClienteTcp get_socket_conexiones();
			int get_raw_socket() { return m_socket_conexion; }

		private:
			int m_puerto_conexion;
			int m_socket_conexion;
			bool m_socket_iniciado;
			long m_timeout_ms;
		};

		namespace intern
		{
			struct FcnDefaultTrue
			{
				bool operator()(const agv::comtcp::ClienteTcp&) { return true; }
			};
		}

		struct ClienteServidorGenerico
		{
			virtual ~ClienteServidorGenerico() = default;
			virtual void comunicar() = 0;
			virtual bool envia_mensaje(const std::vector<unsigned char>& p_mensaje) = 0;
			virtual void set_socket(ClienteTcp&& p_cliente) = 0;
			virtual void desconectar() = 0;
		};
		
		template <typename T_Cliente>
		class ServidorGenerico
		{
		public:
			ServidorGenerico(long p_timeout_ms = 100) :
				m_server_iniciado(false),
				m_timeout_ms(p_timeout_ms)
			{
			}

			virtual ~ServidorGenerico()
			{
				try
				{
					if (m_server_iniciado)
						stop();
				}
				catch (...) {}
			}

			void start(int p_puerto)
			{
				m_server_tcp.start(p_puerto);
				m_server_iniciado = true;
			}

			void stop()
			{
				m_server_tcp.stop();
				m_server_iniciado = false;

				//Cerrar todas las conexiones
				for (auto& cliente_i : m_clientes_conectados)
				{
					try
					{
						cliente_i.desconectar();
					}
					catch (...)
					{
					}
				}

				m_clientes_conectados.clear();
			}

			void set_timeout(long p_timeout_ms)
			{
				m_timeout_ms = p_timeout_ms;
			}

			template<class ...Args>
			void aceptar_nuevos_clientes(Args&&... args)
			{
				if (!m_server_iniciado)
					throw(std::runtime_error("El servidor no esta configurado"));
								
				//Comprobamos si hay nuevos clientes
				while (m_server_tcp.hay_cliente_disponible())
				{
					//Nuevo cliente
					try
					{
						T_Cliente nuevo_cliente(std::forward<Args>(args)...);
						nuevo_cliente.set_socket(m_server_tcp.aceptar_cliente());
						m_clientes_conectados.push_back(nuevo_cliente);
					}
					catch (...)
					{
					}
				}
			}

			void comunica_clientes()
			{
				if (!m_server_iniciado)
					throw(std::runtime_error("El servidor no esta configurado"));

				//Recorremos el vector de clientes
				for (auto cliente_i = m_clientes_conectados.begin(); cliente_i != m_clientes_conectados.end(); )
				{
					try
					{
						cliente_i->comunicar();
						++cliente_i;
					}
					catch (...)
					{
						cliente_i->desconectar();
						cliente_i = m_clientes_conectados.erase(cliente_i);
					}
				}
			}

			//TODO: Habilitar los siguientes metodos en funcion de si el cliente tiene las clases envia_manesaje mediante SFINAE
			bool envia_mensaje_cliente(delegate<bool(const T_Cliente&)> p_comp, const std::vector<unsigned char>& p_mensaje)
			{
				for (auto cliente_i = m_clientes_conectados.begin(); cliente_i != m_clientes_conectados.end(); ++cliente_i)
				{
					if (p_comp(*cliente_i))
					{
						try
						{
							return cliente_i->envia_mensaje(p_mensaje);
						}
						catch (...)
						{
							cliente_i->desconectar();
							m_clientes_conectados.erase(cliente_i);
						}
						break;
					}
				}

				return false;
			}

			void envia_mensaje_multicliente(delegate<bool(const T_Cliente&)> p_comp, const std::vector<unsigned char>& p_mensaje)
			{
				for (auto cliente_i = m_clientes_conectados.begin(); cliente_i != m_clientes_conectados.end();)
				{
					if (p_comp(*cliente_i))
					{
						try
						{
							cliente_i->envia_mensaje(p_mensaje);
						}
						catch (...)
						{
							cliente_i->desconectar();
							cliente_i = m_clientes_conectados.erase(cliente_i);
							continue; //No incrementamos el cliente
						}
					}

					++cliente_i;
				}
			}
			
			void ejecuta_en_clientes(delegate<bool(T_Cliente&)> p_delegado)
			{
				for (auto cliente_i = m_clientes_conectados.begin(); cliente_i != m_clientes_conectados.end(); ++cliente_i)
				{
					p_delegado(cliente_i);
				}
			}

		protected:
			ListenerTcp m_server_tcp;
			std::vector<T_Cliente> m_clientes_conectados;
			bool m_server_iniciado;
			long m_timeout_ms;
		};
		
		/*
		template < typename T_FcnComm, typename T_FcnConect = intern::FcnDefaultTrue >
		class ServidorGenerico
		{
		public:
			ServidorGenerico(long p_timeout_ms = 100) :
				m_server_iniciado(false),
				m_timeout_ms(p_timeout_ms)
			{
			}

			virtual ~ServidorGenerico()
			{
				try
				{
					if (m_server_iniciado)
						stop();
				}
				catch(...) {}
			}

			void start(int p_puerto)
			{
				m_server_tcp.start(p_puerto);
				m_server_iniciado = true;
			}

			void stop()
			{
				m_server_tcp.stop();
				m_server_iniciado = false;

				//Cerrar todas las conexiones
				for (auto& cliente_i : m_clientes_conectados)
				{
					try
					{
						cliente_i.desconectar();
					}
					catch (...)
					{
					}
				}

				m_clientes_conectados.clear();
			}

			void set_timeout(long p_timeout_ms)
			{
				m_timeout_ms = p_timeout_ms;
			}

			template<class ...Args>
			void aceptar_nuevos_clientes(Args&&... args)
			{
				if (!m_server_iniciado)
					throw(std::runtime_error("El servidor no esta configurado"));

				//Comprobamos si hay nuevos clientes
				while (m_server_tcp.hay_cliente_disponible())
				{
					agv::comtcp::ClienteTcp nuevo_cliente = m_server_tcp.aceptar_cliente();
					nuevo_cliente.set_timeout_ms(m_timeout_ms);
					try
					{
						if (T_FcnConect()(nuevo_cliente, std::forward<Args>(args)...));
						{
							m_clientes_conectados.push_back(nuevo_cliente);
						}
					}
					catch (const std::exception& e)
					{
						nuevo_cliente.desconectar();
					}
				}
			}

			template<class ...Args>
			void comunica_clientes(Args&&... args)
			{
				if (!m_server_iniciado)
					throw(std::runtime_error("El servidor no esta configurado"));

				//Recorremos el vector de clientes
				for (auto cliente_i = m_clientes_conectados.begin(); cliente_i != m_clientes_conectados.end(); ++cliente_i)
				{
					try
					{
						T_FcnComm()(*cliente_i, std::forward<Args>(args)...);
					}
					catch (const std::exception& e)
					{
						cliente_i->desconectar();
						--cliente_i;
						m_clientes_conectados.erase(cliente_i + 1);
					}
				}
			}

		protected:
			ListenerTcp m_server_tcp;
			std::vector<agv::comtcp::ClienteTcp> m_clientes_conectados;
			bool m_server_iniciado;
			long m_timeout_ms;
		};
		*/
	}
}