// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: cliente_tcp.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2016/01/15

#pragma once

#include "../../../Librerias.h"
#include "../../../generales/tipos_dato.h"
#include "excepcion_tcp.h"
//Librerias STL
#include <atomic>
#include <string>
#include <vector>
#include <type_traits>
#include <iterator>
#include <stdexcept>
//Comunicacion TCP
#ifdef _WIN32
#include <winsock2.h>
#pragma comment(lib, "WS2_32")
#define MSG_NOSIGNAL 0
#define SHUT_RDWR SD_BOTH
#else //_WIN32
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/select.h>
#include <netinet/in.h>
#include <netdb.h>
#include <fcntl.h>
#endif //_WIN32

namespace agv
{
	namespace comtcp
	{
		class ListenerTcp;
		
#ifdef _WIN32
		struct IniciarWinsock
		{
			IniciarWinsock()
			{
				if(!winsock_iniciado)
					iniciar_winsock();
				winsock_iniciado = true;
			}

			~IniciarWinsock()
			{
				if(!winsock_terminado)
					terminar_winsock();
				winsock_terminado = true;
			}

			static int iniciar_winsock()
			{
				WSADATA wsaData;
				return WSAStartup(MAKEWORD(2, 2), &wsaData);
			}

			static int terminar_winsock()
			{
				return WSACleanup();
			}

			static bool winsock_iniciado;
			static bool winsock_terminado;
		};

#ifndef NO_AUTOINICIA_WINSOCK
		namespace
		{
			static IniciarWinsock gc_autoinicio_winsock;
		}
#endif //NO_AUTOINICIA_WINSOCK

#endif //_WIN32

		class ClienteTcp {
			friend class ListenerTcp;
		public:
			ClienteTcp();
			//Constructor de conexion directa a servidor, puede tirar ExceptionTcp
			ClienteTcp(const std::string& p_ip_server, int p_puerto);
			virtual ~ClienteTcp() = default;

			ClienteTcp(const ClienteTcp& p_cliente) = default;
			ClienteTcp& operator=(const ClienteTcp& p_cliente) = default;
			ClienteTcp(ClienteTcp&& p_cliente) = default;
			ClienteTcp& operator=(ClienteTcp&& p_cliente) = default;

			//Intenta conectar al servidor, puede tirar ExceptionTcp
			void conectar(long p_timeout_ms = 0, const std::string& p_ip_server = std::string(), int p_puerto = -1);
			//Desconecta del servidor, puede tirar ExceptionTcp
			void desconectar();
			//Devuelve el filedescriptor de archivo
			int release_socket();

			//Comprueba si el socket esta listo para recibir datos, puede tirar ExceptionTcp
			bool listo_para_recibir(long p_timeout_ms = 0);
			//Comprueba si el socket esta listo para enviar datos, puede tirar ExceptionTcp
			bool listo_para_enviar(long p_timeout_ms = 0);
			//Obtiene el numero de datos esperando para ser leidos en el socket
			long num_datos_disponibles_buffer();

			//Comprueba si el socket esta listo para recibir datos, puede tirar ExceptionTcp
			static std::vector<ClienteTcp*> listo_para_recibir(std::vector<ClienteTcp*> p_clientes, long p_timeout_ms = 0);
			//Comprueba si el socket esta listo para enviar datos, puede tirar ExceptionTcp
			static std::vector<ClienteTcp*> listo_para_enviar(std::vector<ClienteTcp*> p_clientes, long p_timeout_ms = 0);

			//Envio de bytes por vector, puede tirar ExceptionTcp
			void envia_vector_bytes(const std::vector<unsigned char>& p_datos, long p_timeout_ms = 0);
			//Envio de bytes por vector, puede tirar ExceptionTcp
			template<typename Iterator>
			void envia_vector_bytes(Iterator p_begin, Iterator p_end, long p_timeout_ms = 0)
			{
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<Iterator>::value_type>::value, "La clase de envio ClienteTcp solo acepta iteradores a tipo unsigned char");

				if (p_end < p_begin)
					throw(std::invalid_argument("Vector de envio invalido"));

				envia_vector_bytes({ p_begin, p_end }, p_timeout_ms);
			}
			//Recepcion de p_tam bytes por vector, puede tirar ExceptionTcp
			std::vector<unsigned char> recibe_vector_nbytes(int p_tam, long p_timeout_ms = 0);
			//Recepcion de buffer por vector, puede tirar ExceptionTcp
			std::vector<unsigned char> lee_buffer_actual(long p_timeout_ms = 0, int p_data_max = 0);
			
			//Envia trama ascii especificando caracteres de inicio y fin de trama, puede tirar ExceptionTcp
			void envia_ascii_tcp(std::string p_trama_envio, char p_inicio_trama, char p_fin_trama, long p_timeout_ms = 0);
			//Recibe trama ascii especificando caracteres de inicio y fin de trama, puede tirar ExceptionTcp
			std::string recibe_ascii_tcp(char p_inicio_trama, char p_fin_trama, long p_timeout_ms = 0);
			//Envia trama ascii con caracteres de inicio y fin de trama preconfigurados, puede tirar ExceptionTcp
			void envia_ascii_tcp(const std::string& p_trama_envio, long p_timeout_ms = 0);
			//Recibe trama ascii con caracteres de inicio y fin de trama preconfigurados, puede tirar ExceptionTcp
			std::string recibe_ascii_tcp(long p_timeout_ms = 0);
			
			std::vector<unsigned char> lee_hasta_caracter_peeking(unsigned char p_caracter, long p_timeout_ms = 0);
			std::vector<unsigned char> lee_hasta_caracter(unsigned char p_caracter, long p_timeout_ms = 0);

			std::vector<unsigned char> peek_nbytes(int p_tam, long p_timeout_ms = 0);

			void set_delimitadores_trama_ascii(char p_inicio_trama_ascii, char p_fin_trama_ascii);
			void set_timeout_ms(long p_timeout_ms);
			//Funcion experimental
			int set_prioridad_socket(int p_prioridad);

			long get_timeout_ms() const;
			std::string get_ip_server() const;
			int get_puerto() const;
			bool esta_conectado() const;

		protected:
			bool listo_para_enviar_no_connect_check(long p_timeout_ms = 0);
			void reset_direccion(const std::string& p_ip_server, int p_puerto);
			int m_socket;
			std::string m_ip_server;
			int m_puerto;
			long m_timeout_ms;
			char m_inicio_trama_ascii;
			char m_fin_trama_ascii;
			bool m_esta_conectado;
			sockaddr_in m_direccion_server;
			bool m_generado_por_servidor;
		};
	}
}