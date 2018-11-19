// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: tipos_dato.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2015/11/13

#pragma once

#ifndef TIPOS_DATO_H
#define TIPOS_DATO_H

#include "../Librerias.h"
//STL
#include <atomic>
#ifndef _MANAGED //Para compilar con soporte C++/CLI
#include <thread>
#endif //_MANAGED
//#include <ctime>
#include <cassert>
#include <chrono>
#include <type_traits>
#include <queue>
#ifdef SOPORTE_OPENCV
#include <opencv2/core.hpp>
#endif //SOPORTE_OPENCV

namespace agv
{
	/*(Thread safe)
	* Satisface el concepto C++ std::Lockable (http://en.cppreference.com/w/cpp/concept/Lockable)
	*/
	class SpinLock {
		std::atomic_flag m_locked = ATOMIC_FLAG_INIT;
	public:
		SpinLock() = default;
		SpinLock(const SpinLock&) = delete;

		void lock()
		{
			while (m_locked.test_and_set(std::memory_order_acquire))
			{
#ifdef _THREAD_
				std::this_thread::yield();
#else //_THREAD_
				;
#endif //_THREAD_
			}
		}

		bool try_lock()
		{
			return !m_locked.test_and_set(std::memory_order_acquire);
		}

		void unlock()
		{
			m_locked.clear(std::memory_order_release);
		}
	};

	struct GlobalTimestamp
	{
		static const std::chrono::time_point<std::chrono::steady_clock> global_timestamp_ini;

		static long long now_nanoseconds()
		{
			return (std::chrono::steady_clock::now() - global_timestamp_ini).count();
		}

		static long now()
		{
			return (long)now_double();
		}

		static double now_double()
		{
			return now_nanoseconds() / 1000000.0;
		}

		static std::chrono::time_point<std::chrono::steady_clock> now_timepoint()
		{
			return std::chrono::time_point<std::chrono::steady_clock>(std::chrono::nanoseconds(now_nanoseconds()));
		}

		static long diff_to(long p_timestamp_ms)
		{
			return now() - p_timestamp_ms;
		}

		static double diff_to_double(double p_timestamp_ms)
		{
			return now_double() - p_timestamp_ms;
		}
	};

	class Temporizador {

		inline virtual std::chrono::time_point<std::chrono::steady_clock> tiempo_ahora() const { return std::chrono::steady_clock::now(); }

	public:
		Temporizador(long p_timeout_ms = 100)
			: m_t_ini(tiempo_ahora())
			, m_timeout_s(p_timeout_ms / 1000.0)
			, m_terminado(false)
			, m_offset_s(0)
		{
		}

		virtual ~Temporizador() = default;

		void iniciar()
		{
			m_terminado = false;
			m_t_ini = tiempo_ahora();
			m_offset_s = 0;
		}

		void iniciar(double p_timeout_ms)
		{
			set_timeout(p_timeout_ms);
			iniciar();
		}

		void iniciar_con_offset_ms(double p_offset_ms)
		{
			m_terminado = false;
			m_t_ini = tiempo_ahora();
			m_offset_s = p_offset_ms / 1000.0;
		}

		bool terminado() const
		{
			if (m_terminado) return true;

			std::chrono::duration<double> tiempo_transcurrido = tiempo_ahora() - m_t_ini;
			m_terminado = (tiempo_transcurrido.count() + m_offset_s) > m_timeout_s;

			return m_terminado;
		}

		void forzar_terminado()
		{
			m_terminado = true;
		}

		long transcurrido_ms() const
		{
			std::chrono::duration<double> tiempo_transcurrido = tiempo_ahora() - m_t_ini;
			return (long)((tiempo_transcurrido.count() + m_offset_s) * 1000.0);
		}

		double transcurrido_ms_double() const
		{
			std::chrono::duration<double> tiempo_transcurrido = tiempo_ahora() - m_t_ini;
			return (tiempo_transcurrido.count() + m_offset_s) * 1000.0;
		}

		long restante_ms() const
		{
			return static_cast<long>((m_timeout_s * 1000) - transcurrido_ms());
		}

		long restante_ms_double() const
		{
			return static_cast<long>((m_timeout_s * 1000) - transcurrido_ms_double());
		}

		void set_timeout(double p_timeout_ms)
		{
			m_terminado = false;
			m_timeout_s = p_timeout_ms / 1000.0;
		}

		long get_timeout_ms() const { return (long)m_timeout_s * 1000; }
		double get_timeout_s() const { return m_timeout_s; }

	private:
		std::chrono::time_point<std::chrono::steady_clock> m_t_ini;
		double m_timeout_s;
		mutable bool m_terminado;
		double m_offset_s;
	};

	class SyncTimestamp
	{
	public:
		SyncTimestamp() : m_diferencia_timestamps(0) {}
		
		void sincronizar(long p_timestamp_remoto)
		{
			m_diferencia_timestamps = GlobalTimestamp::now() - p_timestamp_remoto;
		}
		
		long to_local(long p_timestamp_remoto)
		{
			return p_timestamp_remoto + m_diferencia_timestamps;
		}
		
		long to_remote(long p_timestamp_local = GlobalTimestamp::now())
		{
			return p_timestamp_local - m_diferencia_timestamps;
		}
		
		long diff_local(long p_timestamp_remoto)
		{
			return GlobalTimestamp::now() - to_local(p_timestamp_remoto);
		}
		
	private:
		long m_diferencia_timestamps;
	};
	
	/*(Thread safe)
	* T_Lockable debe satisfacer el concepto std::BasicLockable de c++ (http://en.cppreference.com/w/cpp/concept/BasicLockable)
	*/
	template<typename T_Lockable = agv::SpinLock>
	class ThreadWatchdog
	{
	public:
		ThreadWatchdog(int p_timeout_ms) :
			sm_temporizador_timeout(p_timeout_ms)
		{}

		bool is_over()
		{
			sm_thread_lock.lock();
			bool over = sm_temporizador_timeout.terminado();
			sm_thread_lock.unlock();
			return over;
		}

		void reset()
		{
			sm_thread_lock.lock();
			sm_temporizador_timeout.iniciar();
			sm_thread_lock.unlock();
		}

		void set_timeout(int p_timeout_ms)
		{
			sm_thread_lock.lock();
			sm_temporizador_timeout.set_timeout(p_timeout_ms);
			sm_thread_lock.unlock();
		}

	private:
		T_Lockable sm_thread_lock;
		Temporizador sm_temporizador_timeout;
	};

	/*(Thread safe)
	* T_Lockable debe satisfacer el concepto std::BasicLockable de c++ (http://en.cppreference.com/w/cpp/concept/BasicLockable)
	*/
	template<typename Tp, typename Sequence = std::deque<Tp>, typename T_Lockable = agv::SpinLock>
	class SharedQueue
	{
	public:
		bool empty()
		{
			sm_thread_lock.lock();
			bool resultado = m_cola.empty();
			sm_thread_lock.unlock();
			return resultado;
		}

		std::size_t size()
		{
			sm_thread_lock.lock();
			std::size_t resultado = m_cola.size();
			sm_thread_lock.unlock();
			return resultado;
		}

		Tp& front()
		{
			sm_thread_lock.lock();
			Tp& resultado = m_cola.front();
			sm_thread_lock.unlock();
			return resultado;
		}

		Tp& back()
		{
			sm_thread_lock.lock();
			Tp& resultado = m_cola.back();
			sm_thread_lock.unlock();
			return resultado;
		}

		void push(const Tp& p_valor)
		{
			sm_thread_lock.lock();
			m_cola.push(p_valor);
			sm_thread_lock.unlock();
		}

		void push(Tp&& p_valor)
		{
			sm_thread_lock.lock();
			m_cola.push(std::move(p_valor));
			sm_thread_lock.unlock();
		}

		template<class... Args>
		void emplace(Args&&... args)
		{
			sm_thread_lock.lock();
			m_cola.emplace(std::forward<Args>(args)...);
			sm_thread_lock.unlock();
		}

		void pop()
		{
			sm_thread_lock.lock();
			m_cola.pop();
			sm_thread_lock.unlock();
		}

		void swap(std::queue<Tp, Sequence>& p_queue)
		{
			sm_thread_lock.lock();
			m_cola.swap(p_queue);
			sm_thread_lock.unlock();
		}

	private:
		T_Lockable sm_thread_lock;
		std::queue<Tp, Sequence> m_cola;
	};

	template<typename T_enum>
	class EnumFlags
	{
	public:
		typedef typename std::underlying_type<T_enum>::type flags_t;
		typedef T_enum enum_t;

		EnumFlags()
		{
			m_flags = 0;
		}
		EnumFlags(T_enum p_flags)
		{
			m_flags = static_cast<flags_t>(p_flags);
		}
		EnumFlags(flags_t p_flags)
		{
			m_flags = p_flags;
		}
		EnumFlags(const EnumFlags& p_enum_flags)
		{
			this->reset_flags(p_enum_flags.get_flags());
		}
		
		void put_flag(T_enum p_flag_hex, bool p_estado)
		{
			p_estado ? set_flag(p_flag_hex) : clear_flag(p_flag_hex);
		}
		void set_flag(T_enum p_flag_hex)
		{
			m_flags = m_flags | static_cast<flags_t>(p_flag_hex);
		}
		void clear_flag(T_enum p_flag_hex)
		{
			m_flags = m_flags & ~static_cast<flags_t>(p_flag_hex);
		}
		bool check_flag(T_enum p_flag_hex) const
		{
			return static_cast<flags_t>(p_flag_hex) & m_flags;
		}
		void reset_flags(flags_t p_flags = 0)
		{
			m_flags = p_flags;
		}
		flags_t get_flags() const
		{
			return m_flags;
		}
		void combine_flags(flags_t p_flags)
		{
			m_flags = m_flags | p_flags;
		}

		flags_t operator=(flags_t p_entrada)
		{
			this->m_flags = p_entrada;
			return this->m_flags;
		}

	private:
		flags_t m_flags;
	};
	
	template<typename T_Lockable = agv::SpinLock>
	class AtomicString
	{
	public:
		AtomicString() = default;
		virtual ~AtomicString() = default;
		AtomicString(const std::string& p_string) : m_string(p_string) {};
		AtomicString(const AtomicString&) = delete;

		void set(const std::string& p_string)
		{
			m_lock.lock();
			m_string = p_string;
			m_lock.unlock();
		}

		std::string get() const
		{
			m_lock.lock();
			std::string string_ret = m_string;
			m_lock.unlock();

			return string_ret;
		}

	private:
		mutable T_Lockable m_lock;
		std::string m_string;
	};

	template<typename T>
	class BufferTrace
	{
	public:
		BufferTrace(long p_tiempo_muestreo_ms, std::size_t p_numero_muestras)
			: m_numero_muestras(p_numero_muestras)
			, m_temp_muestreo(p_tiempo_muestreo_ms)
		{
		}

		void trace(T&& p_dato)
		{
			if (m_temp_muestreo.terminado())
			{
				m_temp_muestreo.iniciar();
				m_buffer.emplace_back(std::forward<T>(p_dato));

				if (m_buffer.size() > m_numero_muestras)
				{
					m_buffer.pop_front();
				}
			}
		}

		void trace(const T& p_dato)
		{
			if (m_temp_muestreo.terminado())
			{
				m_temp_muestreo.iniciar();
				m_buffer.push_back(p_dato);

				if (m_buffer.size() > m_numero_muestras)
				{
					m_buffer.pop_front();
				}
			}
		}

		typename std::deque<T>::const_iterator begin() const
		{
			return m_buffer.begin();
		}

		typename std::deque<T>::const_iterator end() const
		{
			return m_buffer.end();
		}

	private:
		std::size_t m_numero_muestras;
		agv::Temporizador m_temp_muestreo;
		std::deque<T> m_buffer;
	};
}
#endif /* TIPOS_DATO_H */
