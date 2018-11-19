// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: utils.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2017/6/16

#pragma once

#ifndef SMART_AGV_UTILS
#define SMART_AGV_UTILS

#include "../Librerias.h"
#include <algorithm>
#include <chrono>
#include <cmath>
#include <ios>
#include <sstream>
#include <stdexcept>
#include <string>
#include <thread>
#include <type_traits>
#include <vector>

namespace agv
{
	inline void sleep(long p_segundos)
	{
		std::this_thread::sleep_for(std::chrono::seconds(p_segundos));
	}
	
	inline void usleep(long p_microsegundos)
	{
		std::this_thread::sleep_for(std::chrono::microseconds(p_microsegundos));
	}

	template<typename T>
	std::string to_string_base(T p_valor, std::ios_base& (*p_base)(std::ios_base&))
	{
		std::ostringstream sstream;
		sstream << p_base << p_valor;
		return sstream.str();
	}

	constexpr char gc_caracteres_base36[] = "0123456789abcdefhhijklmnopqrstuvwxyz";
	constexpr char gc_caracteres_base36_mayus[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	template<typename T, typename std::enable_if<std::is_signed<T>::value, int>::type = 0>
	std::string sm_to_string(T p_num_in, char p_base, const char* p_caracteres = gc_caracteres_base36)
	{
		static_assert(std::is_integral<T>::value, "Solo se permiten valores enteros");

		if (p_base > 36)
			throw(std::invalid_argument("Base conversion not available"));

		bool negativo = false;

		if (p_num_in < 0)
		{
			negativo = true;
			p_num_in = -p_num_in;
		}

		std::string string_ret;
		do
		{
			string_ret.append(1, p_caracteres[p_num_in % p_base]);
			p_num_in /= p_base;
		} while (p_num_in != 0);

		if (negativo)
			string_ret.append(1, '-');

		std::reverse(string_ret.begin(), string_ret.end());

		return string_ret;
	}

	template<typename T, typename std::enable_if<std::is_unsigned<T>::value, int>::type = 0>
	std::string sm_to_string(T p_num_in, char p_base, const char* p_caracteres = gc_caracteres_base36)
	{
		static_assert(std::is_integral<T>::value, "Solo se permiten valores enteros");

		if (p_base > 36)
			throw(std::invalid_argument("Base conversion not available"));

		std::string string_ret;
		do
		{
			string_ret.append(1, p_caracteres[p_num_in % p_base]);
			p_num_in /= p_base;
		} while (p_num_in != 0);

		std::reverse(string_ret.begin(), string_ret.end());

		return string_ret;
	}
	
	namespace detail
	{
		template<typename T, typename Iterator>
		struct DeserializarEntero
		{
			static T impl(Iterator&& p_begin, const Iterator&& p_max)
			{
				typedef typename std::remove_reference<T>::type T_Unref;

				static_assert(std::is_integral<T_Unref>::value, "El valor proporcionado a las funciones de serializacion debe ser entero");
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				if ((std::size_t)(p_max - p_begin) < sizeof(T))
					throw(std::runtime_error("Deserializacion fuera de limites"));

				typedef typename std::make_unsigned<T_Unref>::type UT;

				UT valor_ret = 0;

				for (std::size_t i = 0; i < sizeof(T); ++i)
					valor_ret += *(p_begin++) * std::pow((UT)0x100, i);

				return valor_ret;
			}
		};

		template<typename Iterator>
		struct DeserializarEntero<char, Iterator>
		{
			static char impl(Iterator&& p_begin, const Iterator&& p_max)
			{
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				if ((p_max == p_begin))
					throw(std::runtime_error("Deserializacion fuera de limites"));

				return (char)*(p_begin++);
			}
		};

		template<typename Iterator>
		struct DeserializarEntero<unsigned char, Iterator>
		{
			static unsigned char impl(Iterator&& p_begin, const Iterator&& p_max)
			{
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				if ((p_max == p_begin))
					throw(std::runtime_error("Deserializacion fuera de limites"));

				return *(p_begin++);
			}
		};
	}

	template<typename T, typename Iterator>
	inline T deserializar_entero(Iterator&& p_begin, Iterator&& p_max)
	{
		return detail::DeserializarEntero<T, Iterator>::impl(std::forward<Iterator>(p_begin), std::forward<Iterator>(p_max));
	}

	namespace detail
	{
		template<typename T, typename Iterator>
		struct SerializarEntero
		{
			static void impl(T p_valor, Iterator&& p_begin, const Iterator&& p_max)
			{
				typedef typename std::remove_reference<T>::type T_Unref;

				static_assert(std::is_integral<T_Unref>::value, "El valor proporcionado a las funciones de serializacion debe ser entero");
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				if ((std::size_t)(p_max - p_begin) < sizeof(T))
					throw(std::runtime_error("Serializacion fuera de limites"));

				typedef typename std::make_unsigned<T_Unref>::type UT;

				UT valor_unsigned = (UT) p_valor;

				for (std::size_t i = 0; i < sizeof(T); ++i)
					*(p_begin++) = (valor_unsigned / (UT)std::pow(0x100, i)) % 0x100;
			}

			static void impl(T p_valor, Iterator&& p_begin)
			{
				typedef typename std::remove_reference<T>::type T_Unref;

				static_assert(std::is_integral<T_Unref>::value, "El valor proporcionado a las funciones de serializacion debe ser entero");
				static_assert(std::is_same<unsigned char, typename std::remove_reference<Iterator>::type::container_type::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				typedef typename std::make_unsigned<T_Unref>::type UT;

				UT valor_unsigned = (UT)p_valor;

				for (std::size_t i = 0; i < sizeof(T); ++i)
					*(p_begin++) = (valor_unsigned / (UT)std::pow(0x100, i)) % 0x100;
			}
		};
		
		template<typename Iterator>
		struct SerializarEntero<char, Iterator>
		{
			static void impl(char p_valor, Iterator&& p_begin, const Iterator&& p_max)
			{
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");
		
				if ((p_max == p_begin))
					throw(std::runtime_error("Serializacion fuera de limites"));

				*(p_begin++) = (unsigned char)p_valor;
			}

			static void impl(char p_valor, Iterator&& p_begin)
			{
				static_assert(std::is_same<unsigned char, typename std::remove_reference<Iterator>::type::container_type::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				*(p_begin++) = (unsigned char)p_valor;
			}
		};

		template<typename Iterator>
		struct SerializarEntero<unsigned char, Iterator>
		{
			static void impl(unsigned char p_valor, Iterator&& p_begin, const Iterator&& p_max)
			{
				static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");
		
				if ((p_max == p_begin))
					throw(std::runtime_error("Serializacion fuera de limites"));

				*(p_begin++) = p_valor;
			}

			static void impl(unsigned char p_valor, Iterator&& p_begin)
			{
				static_assert(std::is_same<unsigned char, typename std::remove_reference<Iterator>::type::container_type::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

				*(p_begin++) = p_valor;
			}
		};
	}

	template<typename T, typename Iterator>
	inline void serializar_entero(T&& p_valor, Iterator&& p_begin, Iterator&& p_max)
	{
		detail::SerializarEntero<T, Iterator>::impl(std::forward<T>(p_valor), std::forward<Iterator>(p_begin), std::forward<Iterator>(p_max));
	}

	template<typename T, typename Iterator>
	inline void serializar_entero(T&& p_valor, Iterator&& p_back_inserter)
	{
		detail::SerializarEntero<T, Iterator>::impl(std::forward<T>(p_valor), std::forward<Iterator>(p_back_inserter));
	}

	template<typename T>
	void serializar_entero(T p_valor, std::vector<unsigned char>& p_vector)
	{
		typedef typename std::remove_reference<T>::type T_Unref;
		static_assert(std::is_integral<T_Unref>::value, "El valor proporcionado a las funciones de serializacion debe ser entero");
		
		typedef typename std::make_unsigned<T_Unref>::type UT;

		UT valor_unsigned = (UT) p_valor;

		for (std::size_t i = 0; i < sizeof(T); ++i)
			p_vector.push_back((valor_unsigned / (UT)std::pow(0x100, i)) % 0x100);
	}

	inline void serializar_entero(char p_valor, std::vector<unsigned char>& p_vector)
	{
		p_vector.push_back((unsigned char)p_valor);
	}

	inline void serializar_entero(unsigned char p_valor, std::vector<unsigned char>& p_vector)
	{
		p_vector.push_back(p_valor);
	}

	template<typename Iterator>
	std::string deserializar_string(Iterator&& p_begin, Iterator&& p_max, char p_ini_trama = 2, char p_fin_trama = 3)
	{
		static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

		std::string string_retorno;

		//Buscamos el inicio de trama
		bool inicio_encontrado = false;
		bool final_encontrado = false;

		for (; p_begin != p_max && !final_encontrado; ++p_begin)
		{
			if (!inicio_encontrado)
			{
				if (*p_begin == p_ini_trama)
					inicio_encontrado = true;
			}
			else
			{
				if (*p_begin == p_fin_trama)
				{
					final_encontrado = true;
				}
				else
				{
					string_retorno.append(1, *p_begin);
				}
			}
		}

		if (!final_encontrado)
			throw(std::runtime_error("Deserializacion fuera de limites"));

		return string_retorno;
	}

	template<typename Iterator>
	void serializar_string(const std::string& p_string, Iterator&& p_begin, Iterator&& p_max, char p_ini_trama = 2, char p_fin_trama = 3)
	{
		static_assert(std::is_same<unsigned char, typename std::iterator_traits<typename std::remove_reference<Iterator>::type>::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

		if ((p_max - p_begin) < (int)(p_string.size() + 2))
			throw(std::runtime_error("Serializacion fuera de limites"));

		*(p_begin++) = p_ini_trama;

		p_begin = std::copy(p_string.begin(), p_string.end(), p_begin);
		*p_begin = p_fin_trama;

		++p_begin;
	}

	template<typename Iterator>
	void serializar_string(const std::string& p_string, Iterator&& p_begin, char p_ini_trama = 2, char p_fin_trama = 3)
	{
		static_assert(std::is_same<unsigned char, typename std::remove_reference<Iterator>::type::container_type::value_type>::value, "Las operaciones de serializacion/deserializacion se deben realizar sobre iteratores tipo unsigned char");

		*(p_begin++) = p_ini_trama;

		p_begin = std::copy(p_string.begin(), p_string.end(), p_begin);
		*p_begin = p_fin_trama;

		++p_begin;
	}

	void serializar_string(const std::string& p_string, std::vector<unsigned char>& p_vector, char p_ini_trama = 2, char p_fin_trama = 3);

	template<typename T>
	inline typename std::underlying_type<typename std::remove_reference<T>::type>::type get_enum_value(T&& p_enum)
	{
		static_assert(std::is_enum<typename std::remove_reference<T>::type>::value, "La funcion get_enum_value solo puede ser utilizada sobre enums");
		return static_cast<typename std::underlying_type<typename std::remove_reference<T>::type>::type>(p_enum);
	}

	std::string split_string(const std::string& p_string, char p_delim, const std::string& p_extract);


	bool is_integer(const std::string& s);
	int stoi_dec_or_hex(const std::string& s);
	void elimina_espacios_iniciales(std::string& s);

	/**
	*	Parsers para tipos desde string
	*/
	struct StrParser
	{
		std::string operator()(const std::string& string) const
		{
			if (!string.empty() && string[0] == '"')
			{
				return string.substr(1, string.find_last_of('"') - 1);
			}
			return string;
		}
	};
	template<typename T = int>
	struct IntegerParser
	{
		static_assert(std::is_integral<T>::value, "El valor proporcionado a IntegerParser debe ser integral");
		int operator()(const std::string& string) const
		{
			return (T)stoi_dec_or_hex(string);
		}
	};
	template<typename T = int>
	struct IntegerWriter
	{
		static_assert(std::is_integral<T>::value, "El valor proporcionado a IntegerParser debe ser integral");
		std::string operator()(const T& p_entero) const
		{
			return std::to_string(p_entero);
		}
	};
	struct BoolParser
	{
		bool operator()(const std::string& string) const
		{
			if (string.compare("0") == 0 || string.compare("false") == 0)
			{
				return false;
			}
			else if (string.compare("1") == 0 || string.compare("true") == 0)
			{
				return true;
			}
			else
			{
				throw(std::runtime_error("Argumento booleano incorrecto: " + string));
			}

			return false;
		}
	};
	struct BoolWriter
	{
		std::string operator()(const bool& p_bool) const
		{
			return p_bool ? "true" : "false";
		}
	};

	template<typename T_typ>
	T_typ dato_desde_stream(std::istringstream& p_stream)
	{
		T_typ ret;
		if (!(p_stream >> ret))
			throw(std::runtime_error("Invalid array size"));
		return ret;
	}

	template<typename... T_typ>
	std::tuple<T_typ...> leer_campo_vector(std::string p_campo)
	{
		if (p_campo.empty() || p_campo.front() != '[' || p_campo.back() != ']')
			throw(std::invalid_argument("Invalid argument"));

		std::replace(p_campo.begin(), p_campo.end(), ',', ' ');
		std::istringstream sstream(p_campo.substr(1, p_campo.size() - 1));

		return std::tuple<T_typ...>{ dato_desde_stream<T_typ>(sstream)... };
	}
}

#endif //SMART_AGV_UTILS