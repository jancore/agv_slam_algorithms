#pragma once

#include "../Librerias.h"
#include <iostream>
#include <chrono>

namespace agv
{
	namespace log
	{
		// Workaround GCC 4.7.2 not recognizing noinline attribute
#ifndef NOINLINE_ATTRIBUTE
#ifdef __ICC
#define NOINLINE_ATTRIBUTE __attribute__(( noinline ))
#else
#define NOINLINE_ATTRIBUTE
#endif // __ICC
#endif // NOINLINE_ATTRIBUTE

		struct None {};

		template<typename List>
			struct LogData {
				List list;
			};

		template<typename Begin, typename Value>
			constexpr LogData<std::pair<Begin&&, Value&&>> operator<<(LogData<Begin>&& begin, Value&& value) noexcept
			{
				return { { std::forward<Begin>(begin.list), std::forward<Value>(value) } };
			}

		template<typename Begin, std::size_t n>
			constexpr LogData<std::pair<Begin&&, const char*>> operator<<(LogData<Begin>&& begin, const char(&value)[n]) noexcept
			{
				return { { std::forward<Begin>(begin.list), value } };
			}

		typedef std::ostream& (*PfnManipulator)(std::ostream&);

		template<typename Begin>
			constexpr LogData<std::pair<Begin&&, PfnManipulator>> operator<<(LogData<Begin>&& begin, PfnManipulator value) noexcept
			{
				return { { std::forward<Begin>(begin.list), value } };
			}

		inline void log_output(std::ostream& os, None)
		{}

		template <typename Begin, typename Last>
			void log_output(std::ostream& os, std::pair<Begin, Last>&& data)
			{
				log_output(os, std::move(data.first));
				os << data.second;
			}

		template<typename List>
			void Log_line(const char* tipo_log, const char* file, int line, LogData<List>&& data) NOINLINE_ATTRIBUTE
			{
				std::cout << tipo_log << ":" << file << ":" << line << "[";
				log_output(std::cout, std::move(data.list));
				std::cout << ']' << std::endl;
			}

		template<typename List>
			void Log(const char* tipo_log, LogData<List>&& data) NOINLINE_ATTRIBUTE
			{
				std::cout << tipo_log << "[";
				log_output(std::cout, std::move(data.list));
				std::cout << ']' << std::endl;
			}
		
			/*
			//Log general
			#ifdef LOG_NOLOG
				#define LOG(tipo, msg)
				#define LOG_LINE(tipo, msg)
		#else
			#define LOG(tipo, msg) (agv::log::Log(tipo, agv::log::LogData<agv::log::None>() << msg))
			#define LOG_LINE(tipo, msg) (agv::log::Log_line(tipo, __FILE__, __LINE__, agv::log::LogData<agv::log::None>() << msg))
		#endif //LOG_NOLOG

		//Mensajes info
		#if defined(LOG_NOLOG) || defined(LOG_NOINFO)
			#define LOG_INFO(msg) 
		#else
			#define LOG_INFO(msg) (agv::log::Log("INFO", agv::log::LogData<agv::log::None>() << msg))
		#endif //defined(LOG_NOLOG) || defined(LOG_NOINFO)

		//Mensajes alarma
		#if defined(LOG_NOLOG) || defined(LOG_NOALARM)
			#define LOG_ALARM(msg)
		#else
			#define LOG_ALARM(msg) (agv::log::Log("ALARM", agv::log::LogData<agv::log::None>() << msg))
		#endif //defined(LOG_NOLOG) || defined(LOG_NOALARM)

		//Mensajes error
		#if defined(LOG_NOLOG) || defined(LOG_NOERROR)
			#define LOG_ERROR(msg)
		#else
			#define LOG_ERROR(msg) (agv::log::Log("ERROR", agv::log::LogData<agv::log::None>() << msg))
		#endif //defined(LOG_NOLOG) || defined(LOG_NOERROR)

		//Mensajes fatal
		#if defined(LOG_NOFATAL) || defined(LOG_NOFATAL)
			#define LOG_FATAL(msg)
		#else
			#define LOG_FATAL(msg) (agv::log::Log("FATAL", agv::log::LogData<agv::log::None>() << msg))
		#endif //defined(LOG_NOFATAL) || defined(LOG_NOFATAL)
		
		//Mensajes debug
		#if defined(LOG_NODEBUG) || defined(LOG_NODEBUG)
			#define LOG_DEBUG(msg)
		#else
			#define LOG_DEBUG(msg) (agv::log::Log("DEBUG", agv::log::LogData<agv::log::None>() << msg))
		#endif //defined(LOG_NODEBUG) || defined(LOG_NODEBUG)
		*/

//Log general a stream
#ifdef LOG_NOLOG
#define LOG_TO(tipo, msg)
#define LOG_LINE_TO(tipo, msg)
#else
#define LOG_TO(stream, tipo, msg) (stream << '{' << std::chrono::system_clock::to_time_t(std::chrono::system_clock::now()) << '}' << tipo << '[' << msg << ']' << std::endl)
//#define LOG_LINE_TO(tipo, msg) (agv::log::Log_line(tipo, __FILE__, __LINE__, agv::log::LogData<agv::log::None>() << msg))
#endif //LOG_NOLOG

//Log general con cout
#ifdef LOG_NOLOG
#define LOG(tipo, msg)
#define LOG_LINE(tipo, msg)
#else
#define LOG(tipo, msg) (std::cout << '{' << std::chrono::system_clock::to_time_t(std::chrono::system_clock::now()) << '}' << tipo << '[' << msg << ']' << std::endl)
//#define LOG_LINE(tipo, msg) (agv::log::Log_line(tipo, __FILE__, __LINE__, agv::log::LogData<agv::log::None>() << msg))
#endif //LOG_NOLOG

//Mensajes info
#if defined(LOG_NOLOG) || defined(LOG_NOINFO)
#define LOG_INFO(msg) 
#else
#define LOG_INFO(msg) (LOG("INFO", msg))
#endif //defined(LOG_NOLOG) || defined(LOG_NOINFO)

//Mensajes alarma
#if defined(LOG_NOLOG) || defined(LOG_NOALARM)
#define LOG_ALARM(msg)
#else
#define LOG_ALARM(msg) (LOG("ALARM", msg))
#endif //defined(LOG_NOLOG) || defined(LOG_NOALARM)

//Mensajes error
#if defined(LOG_NOLOG) || defined(LOG_NOERROR)
#define LOG_ERROR(msg)
#else
#define LOG_ERROR(msg) (LOG("ERROR", msg))
#endif //defined(LOG_NOLOG) || defined(LOG_NOERROR)

//Mensajes fatal
#if defined(LOG_NOLOG) || defined(LOG_NOFATAL)
#define LOG_FATAL(msg)
#else
#define LOG_FATAL(msg) (LOG("FATAL", msg))
#endif //defined(LOG_NOFATAL) || defined(LOG_NOFATAL)

//Mensajes debug
#if defined(LOG_NOLOG) || defined(LOG_NODEBUG)
#define LOG_DEBUG(msg)
#else
#define LOG_DEBUG(msg) (LOG("DEBUG", msg))
#endif //defined(LOG_NODEBUG) || defined(LOG_NODEBUG)
	}
}
