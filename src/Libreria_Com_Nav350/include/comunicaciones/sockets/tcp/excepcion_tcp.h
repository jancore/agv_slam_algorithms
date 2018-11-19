// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: excepcion_tcp.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2016/01/15

#pragma once

#include "../../../Librerias.h"
//Librerias STL
#include <stdexcept>
#include <string>

#ifdef _WIN32
#include <winsock2.h>
#else
#include <cerrno>
#include <cstring>
#endif

namespace agv
{
	namespace comtcp
	{
		inline std::string string_error_com()
		{
#ifdef _WIN32
			return std::string("Error de comunicacion ") + std::to_string(WSAGetLastError());
#else //_WIN32
			return strerror(errno);
#endif //_WIN32
		}

		inline int get_error_com()
		{
#ifdef _WIN32
			return WSAGetLastError();
#else //_WIN32
			return errno;
#endif //_WIN32
		}

		class ExcepcionTcp : public std::runtime_error 
		{
		public:
			
#ifdef _WIN32
			explicit ExcepcionTcp()
				: std::runtime_error(string_error_com())
			{	// construct from message string
			}
#else //_WIN32
			explicit ExcepcionTcp()
				: std::runtime_error(strerror(errno))
			{	// construct from message string
			}
#endif //_WIN32

			explicit ExcepcionTcp(const std::string& p_message)
				: std::runtime_error(p_message.c_str())
			{	// construct from message string
			}

			explicit ExcepcionTcp(const char *p_message)
				: std::runtime_error(p_message)
			{	// construct from message string
			}
		};
		
		
		class TcpTimeoutExcept : public ExcepcionTcp { using ExcepcionTcp::ExcepcionTcp; };
		class TcpClosedExcept : public ExcepcionTcp { using ExcepcionTcp::ExcepcionTcp; };
		class TcpNewSocketExcept : public ExcepcionTcp { using ExcepcionTcp::ExcepcionTcp; };
		class TcpBindExcept : public ExcepcionTcp { using ExcepcionTcp::ExcepcionTcp; };
		class TcpConnectExcept : public ExcepcionTcp { using ExcepcionTcp::ExcepcionTcp; };
	}
}
