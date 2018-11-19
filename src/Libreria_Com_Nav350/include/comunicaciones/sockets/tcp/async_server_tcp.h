/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 /*
  * File:   server_tcp.h
  * Author: Jesus Rueda
  *
  * Created on 27/07/2017
  */

#pragma once

#include "../../../Librerias.h"
#include "../../../generales/delegate.h"
#include "../../../generales/logger.h"
#include "listener_tcp.h"
//Librerias STL
#include <string>
#include <stdexcept>
#include <thread>
#include <future>
#include <algorithm>

namespace agv
{
	namespace comtcp
	{
		class ClienteServidorTcpBase : protected ClienteTcp
		{
		public:
			ClienteServidorTcpBase() = default;
			ClienteServidorTcpBase(ClienteTcp&& p_cliente) : ClienteTcp(p_cliente) {}
			ClienteServidorTcpBase(const std::string& p_ip, int p_puerto) : ClienteTcp(p_ip, p_puerto) {}
			virtual ~ClienteServidorTcpBase() = default;

			using ClienteTcp::esta_conectado;
			using ClienteTcp::get_ip_server;
			virtual void limpia_buffers_protocolo() {};

		protected:
			virtual int get_raw_socket() { return m_socket; };
		};

		/*
		* T_BasicLockable debe satisfacer el concepto std::BasicLockable de c++ (http://en.cppreference.com/w/cpp/concept/BasicLockable)
		*/
		template<typename T_BasicLockable, typename T_NetProtocol>
		class ServidorTcp
		{
		public:
			class Cliente : public T_NetProtocol::Cliente
			{
				friend class ServidorTcp<T_BasicLockable, T_NetProtocol>;
				static_assert(std::is_base_of<ClienteServidorTcpBase, typename T_NetProtocol::Cliente>::value, "El protocolo debe heredar el cliente desde ClienteServidorTcpBase");
			public:
				Cliente() = default;
				Cliente(ClienteTcp&& p_cliente);
				virtual ~Cliente() = default;

				using T_NetProtocol::Cliente::Cliente;

				//Thread safe
				bool ocupado() const { return m_ocupado; }
				//Thread safe
				void envia_paquete(const typename T_NetProtocol::Paquete& p_paquete);
				//Thread safe
				void envia_paquete(typename T_NetProtocol::Paquete&& p_paquete);
				//Thread safe
				void envia_paquete(const std::vector<typename T_NetProtocol::Paquete>& p_paquetes);
				//Thread safe
				void envia_paquete(std::vector<typename T_NetProtocol::Paquete>&& p_paquetes);
				//Thread safe
				void borra_buffer_envio(const std::string& p_razon = std::string());
				//Thread safe
				std::vector<typename T_NetProtocol::Paquete> get_paquetes_recibidos();
				//Thread safe
				template<class UnaryPredicate>
				std::vector<typename T_NetProtocol::Paquete> get_paquetes_recibidos(UnaryPredicate p);

				std::size_t num_paquetes_envio() const { return m_buffer_envio.size(); }
				std::size_t num_paquetes_recibidos() const { return m_buffer_envio.size(); }

				void set_satic_client(bool p_static) { m_static_client = p_static; }
				bool is_static() const { return m_static_client; }

				void limpia_buffers();

				//Thread safe
				void marca_para_conectar() { m_requiere_conexion = true; }
				//Thread safe
				void marca_para_desconectar() { m_desconecta_cliente = true; }
				//Thread safe
				void marca_para_conectar(const std::string& p_ip, int p_puerto);

				void espera_fin_async_com();
				
			protected:
				//Thread safe
				void comunica();
				//Thread safe
				void async_com();

				void set_hay_datos_socket(bool p_hay_datos_socket) { m_hay_datos_socket = p_hay_datos_socket; }
				bool get_hay_datos_socket() const { return m_hay_datos_socket; }

				bool get_requiere_comunicacion() const
				{
					if (m_ocupado || (!this->esta_conectado() && !m_requiere_conexion))
						return false;

					if (m_hay_datos_socket)
						return true;

					m_lockable.lock();
					bool paquetes_para_enviar = !m_buffer_envio.empty();
					m_lockable.unlock();

					return paquetes_para_enviar;
				}
				
			private:
				bool m_static_client = false;
				std::atomic_bool m_ocupado = { false };
				std::atomic_bool m_hay_datos_socket = { false };
				mutable T_BasicLockable m_lockable;
				std::vector<typename T_NetProtocol::Paquete> m_buffer_envio;
				std::vector<typename T_NetProtocol::Paquete> m_buffer_recepcion;
				std::future<void> m_futuro_async;
				std::atomic_bool m_requiere_conexion = { false };
				std::atomic_bool m_desconecta_cliente = { false };
				bool m_nuevos_datos_conexion = false;
				std::string m_ip_para_conectar;
				int m_puerto_para_conectar = 0;
			};
			
			virtual ~ServidorTcp();

			void start(int p_puerto);
			void stop();
			bool running() const { return m_listener_tcp.running(); }
			void comunica_clientes(long p_timeout_ms = 0);
			std::vector<std::shared_ptr<Cliente>> get_clientes() { return m_clientes; }

			template<typename... Args>
			void add_client(Args&&... p_args)
			{
				m_clientes.emplace_back(std::make_shared(std::forward<Args>(p_args)...));
			}
			void add_client(std::shared_ptr<Cliente> p_cliente)
			{
				m_clientes.push_back(p_cliente);
			}

		protected:
			bool comprueba_y_marca_clientes(std::vector<std::shared_ptr<Cliente>>& p_clientes, long p_timeout_ms = 0);

		private:
			std::vector<std::shared_ptr<Cliente>> m_clientes;
			std::string m_nombre_servidor;
			ListenerTcp m_listener_tcp;
			int m_puerto_servidor;
		};

		template<typename T_BasicLockable, typename T_NetProtocol>
		ServidorTcp<T_BasicLockable, T_NetProtocol>::~ServidorTcp()
		{
			try
			{
				stop();
			}
			catch (...)
			{
			}
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::start(int p_puerto)
		{
			m_listener_tcp.start(p_puerto);
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::stop()
		{
			m_listener_tcp.stop();

			for (auto& cliente_i : m_clientes)
			{
				cliente_i->espera_fin_async_com();
				T_NetProtocol::desconectar(*cliente_i);
			}

			m_clientes.clear();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::comunica_clientes(long p_timeout_ms)
		{
			if (!m_listener_tcp.running())
				throw(TcpClosedExcept("No se ha configurado el servidor"));

			bool hay_nuevo_cliente = comprueba_y_marca_clientes(m_clientes, p_timeout_ms);

			if (hay_nuevo_cliente)
			{
				m_clientes.emplace_back(std::make_shared<Cliente>(m_listener_tcp.aceptar_cliente()));
				LOG_DEBUG("Nuevo cliente conectado desde " << m_clientes.back()->get_ip_server() << " total: " << m_clientes.size());
			}

			for (std::shared_ptr<Cliente>& cliente_i : m_clientes)
			{
				//Limpiamos los buffers del cliente
				cliente_i->limpia_buffers();

				if (cliente_i->get_requiere_comunicacion())
				{
					cliente_i->async_com();
				}
			}

			bool cliente_desconectado = false;
			m_clientes.erase(std::remove_if(m_clientes.begin(), m_clientes.end(), 
				[&](const std::shared_ptr<Cliente>& cliente_i) 
				{ 
					bool eliminar = !cliente_i->ocupado() && !cliente_i->esta_conectado() && !cliente_i->is_static();
					if (eliminar)
					{
						cliente_i->borra_buffer_envio("Client unreachable");
						cliente_desconectado = true;
						LOG_DEBUG("Desconectado el cliente " << cliente_i->get_ip_server());
					}
					return eliminar;
				})
				, m_clientes.end());

			if (cliente_desconectado)
				LOG_DEBUG("Clientes conectados: " << m_clientes.size());
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		bool ServidorTcp<T_BasicLockable, T_NetProtocol>::comprueba_y_marca_clientes(std::vector<std::shared_ptr<Cliente>>& p_clientes, long p_timeout_ms)
		{
			if (!m_listener_tcp.running())
				throw(TcpClosedExcept("No se ha configurado el servidor"));

			long timeout_select = (p_timeout_ms != 0) ? p_timeout_ms : 1;

			timeval timeout = { 0, timeout_select * 1000 }; // timeout simbolico de 1ms para comprobar si hay datos

			fd_set flag_lectura; // flags de lectura
			FD_ZERO(&flag_lectura);

			int mayor_socket = m_listener_tcp.get_raw_socket();
			FD_SET(mayor_socket, &flag_lectura);

			for (std::shared_ptr<Cliente>& cliente_i : p_clientes)
			{
				cliente_i->set_hay_datos_socket(false);

				//Si no esta ocupado lo incluimos en la lista de sockets a comprobar
				if (!cliente_i->ocupado() && cliente_i->esta_conectado())
				{
					if (cliente_i->m_desconecta_cliente)
					{
						T_NetProtocol::desconectar(*cliente_i);
						cliente_i->m_desconecta_cliente = false;
					}
					else
					{
						if (mayor_socket < cliente_i->get_raw_socket())
							mayor_socket = cliente_i->get_raw_socket();

						FD_SET(cliente_i->get_raw_socket(), &flag_lectura);
					}
				}
			}

			int error = select(mayor_socket + 1, &flag_lectura, (fd_set*)NULL, (fd_set*)NULL, &timeout);

			//Si se produce error
			if (error < 0)
			{
				throw(TcpClosedExcept());
			}

			//Socket listo para enviar
			for (std::shared_ptr<Cliente>& cliente_i : p_clientes)
			{
				if (!cliente_i->ocupado() && cliente_i->esta_conectado() && FD_ISSET(cliente_i->get_raw_socket(), &flag_lectura))
				{
					cliente_i->set_hay_datos_socket(true);
				}
			}

			return FD_ISSET(m_listener_tcp.get_raw_socket(), &flag_lectura);
		}
		
		template<typename T_BasicLockable, typename T_NetProtocol>
		ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::Cliente(ClienteTcp && p_cliente)
			: T_NetProtocol::Cliente(std::move(p_cliente))
		{
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::envia_paquete(const typename T_NetProtocol::Paquete& p_paquete)
		{
			m_lockable.lock();
			m_buffer_envio.push_back(p_paquete);
			m_lockable.unlock();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::envia_paquete(typename T_NetProtocol::Paquete&& p_paquete)
		{
			m_lockable.lock();
			m_buffer_envio.emplace_back(std::move(p_paquete));
			m_lockable.unlock();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		inline void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::envia_paquete(const std::vector<typename T_NetProtocol::Paquete>& p_paquetes)
		{
			m_lockable.lock();
			m_buffer_envio.insert(m_buffer_envio.end(), p_paquetes.begin(), p_paquetes.end());
			m_lockable.unlock();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		inline void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::envia_paquete(std::vector<typename T_NetProtocol::Paquete>&& p_paquetes)
		{
			m_lockable.lock();
			std::move(p_paquetes.begin(), p_paquetes.end(), std::back_inserter(m_buffer_envio));
			m_lockable.unlock();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::borra_buffer_envio(const std::string& p_razon)
		{
			std::vector<typename T_NetProtocol::Paquete> buffer_envio_aux;
			m_lockable.lock();
			m_buffer_envio.swap(buffer_envio_aux);
			m_lockable.unlock();

			T_NetProtocol::cancela_paquetes(buffer_envio_aux, p_razon);
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		std::vector<typename T_NetProtocol::Paquete> ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::get_paquetes_recibidos()
		{
			std::vector<typename T_NetProtocol::Paquete> paquetes_recibidos;

			m_lockable.lock();
			if (!m_buffer_recepcion.empty())
			{
				//paquetes_recibidos = m_buffer_recepcion;
				//m_buffer_recepcion.clear();
				paquetes_recibidos.swap(m_buffer_recepcion);
			}
			m_lockable.unlock();

			return paquetes_recibidos;
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		template<class UnaryPredicate>
		inline std::vector<typename T_NetProtocol::Paquete> ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::get_paquetes_recibidos(UnaryPredicate p)
		{
			std::vector<typename T_NetProtocol::Paquete> paquetes_recibidos;

			m_lockable.lock();
			if (!m_buffer_recepcion.empty())
			{
				//Aqui la sintaxis puede confundir, la funcion remove_if lo que esta haciendo es ordenar los elementos del vector para que todos los paquetes
				//que coincidan con el predicado p queden al final del vector, y devuelve el iterador a donde empiezan los paquetes que cumplen.
				//Teniendo ese iterador, movemos los paquetes al buffer temporal que vamos a devolver y borramos hasta el final.
				auto iterator = std::remove_if(m_buffer_recepcion.begin(), m_buffer_recepcion.end(), p);
				paquetes_recibidos = { std::make_move_iterator(iterator), std::make_move_iterator(m_buffer_recepcion.end()) };
				m_buffer_recepcion.erase(iterator, m_buffer_recepcion.end());
			}
			m_lockable.unlock();

			return paquetes_recibidos;
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::limpia_buffers()
		{
			//Limpiamos los buffers del cliente
			this->limpia_buffers_protocolo();

			std::vector<typename T_NetProtocol::Paquete> buffer_recibidos_aux;
			std::vector<typename T_NetProtocol::Paquete> buffer_enviados_aux;
			m_lockable.lock();
			buffer_recibidos_aux.swap(m_buffer_recepcion);
			buffer_enviados_aux.swap(m_buffer_envio);
			m_lockable.unlock();

			T_NetProtocol::limpia_buffer(buffer_recibidos_aux);
			T_NetProtocol::limpia_buffer(buffer_enviados_aux);

			m_lockable.lock();
			//Antes haciamos un swap de vectores, esto no es correcto porque si en el tiempo de limpiar buffers se meten nuevos paquetes a los buffers compartidos los estamos eliminando.
			//buffer_recibidos_aux.swap(m_buffer_recepcion);
			//buffer_enviados_aux.swap(m_buffer_envio);

			//Ahora insertamos los buffers limpios al final de los bufferes compartidos
			m_buffer_recepcion.insert(m_buffer_recepcion.end(), std::make_move_iterator(buffer_recibidos_aux.begin()), std::make_move_iterator(buffer_recibidos_aux.end()));
			m_buffer_envio.insert(m_buffer_envio.end(), std::make_move_iterator(buffer_enviados_aux.begin()), std::make_move_iterator(buffer_enviados_aux.end()));
			m_lockable.unlock();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::marca_para_conectar(const std::string& p_ip, int p_puerto)
		{
			m_lockable.lock();
			m_requiere_conexion = true;
			m_nuevos_datos_conexion = true;
			m_ip_para_conectar = p_ip;
			m_puerto_para_conectar = p_puerto;
			m_lockable.unlock();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::espera_fin_async_com()
		{
			if (m_futuro_async.valid())
				m_futuro_async.wait();
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::comunica()
		{
			std::vector<typename T_NetProtocol::Paquete> buffer_envio_aux;
			std::vector<typename T_NetProtocol::Paquete> buffer_recepcion_aux;
			bool estaba_conectado = this->esta_conectado(); //Solo mostramos el error de desconexion si estaba previamente conectado
			try
			{
				//Si el cliente requiere conexion me conecto
				if (m_requiere_conexion)
				{
					m_requiere_conexion = false;
					if (m_nuevos_datos_conexion)
					{
						m_lockable.lock();
						m_nuevos_datos_conexion = false;
						std::string ip_conexion = m_ip_para_conectar;
						int puerto = m_puerto_para_conectar;
						m_lockable.unlock();

						T_NetProtocol::establece_conexion(*this, ip_conexion, puerto);
					}
					else
					{
						T_NetProtocol::establece_conexion(*this);
					}
					//Reposicionamos el flag de desconexion del cliente
					m_desconecta_cliente = false;
				}

				//Ahora leo los paquetes del socket
				if (m_hay_datos_socket)
				{
					T_NetProtocol::recibir_datos(*this, buffer_recepcion_aux);
				}

				//Ahora compruebo si hay paquetes para enviar
				m_lockable.lock();
				if (!m_buffer_envio.empty())
				{
					buffer_envio_aux = m_buffer_envio;
					m_buffer_envio.clear();
				}
				m_lockable.unlock();

				if (!buffer_envio_aux.empty())
				{
					T_NetProtocol::enviar_datos(*this, buffer_envio_aux);
				}
			}
			catch (const std::exception& e)
			{
				//Como ha sido un error de conexion, desconecto el socket
				if (this->esta_conectado())
				{
					this->desconectar();
				}

				if(estaba_conectado)
					LOG_DEBUG("Cliente " << this->get_ip_server() << " desconectado: " << e.what());
			}

			//Si he terminado a mitad de un envio de paquetes al cliente guardo los que no se han podido enviar en el buffer
			if (!buffer_envio_aux.empty())
			{
				m_lockable.lock();
				m_buffer_envio.insert(m_buffer_envio.end(), std::make_move_iterator(buffer_envio_aux.begin()), std::make_move_iterator(buffer_envio_aux.end()));
				m_lockable.unlock();
			}
			if (!buffer_recepcion_aux.empty())
			{
				m_lockable.lock();
				m_buffer_recepcion.insert(m_buffer_recepcion.end(), std::make_move_iterator(buffer_recepcion_aux.begin()), std::make_move_iterator(buffer_recepcion_aux.end()));
				m_lockable.unlock();
			}

			m_ocupado = false;
		}

		template<typename T_BasicLockable, typename T_NetProtocol>
		void ServidorTcp<T_BasicLockable, T_NetProtocol>::Cliente::async_com()
		{
			m_ocupado = true;
			
			if (m_futuro_async.valid())
				m_futuro_async.wait();

			m_futuro_async = std::async(std::launch::async, &Cliente::comunica, this);
		}
	}
}