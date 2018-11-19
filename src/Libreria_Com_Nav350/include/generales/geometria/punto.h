// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: punto.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2017/6/16

#pragma once

#include "../../rapidxml/rapidxml.hpp"
#include <type_traits>
#include <cmath>
#include <stdexcept>

#ifdef SOPORTE_OPENCV
#include <opencv2/core.hpp>
#endif //SOPORTE_OPENCV

namespace agv
{
	struct DatosPose;

	template<typename T>
	struct Punto2_
	{
		static_assert(std::is_arithmetic<T>::value, "Los puntos se deben definir con tipo aritmetico.");

		T x;
		T y;

		Punto2_() :
			x(0), y(0)
		{};

		Punto2_(T p_x, T p_y) :
			x(p_x), y(p_y)
		{};
		
		Punto2_(rapidxml::xml_node<>* p_nodo_xml)
		{
			rapidxml::xml_attribute<>* atributo_xml;

			atributo_xml = p_nodo_xml->first_attribute("x");
			if (!atributo_xml)
				throw (std::runtime_error("No se ha proporcionado coordenada X"));
			x = (T)std::stod(atributo_xml->value());
			
			atributo_xml = p_nodo_xml->first_attribute("y");
			if (!atributo_xml)
				throw (std::runtime_error("No se ha proporcionado coordenada Y"));
			y = (T)std::stod(atributo_xml->value());
		}
		
		Punto2_(const Punto2_<T>&) = default;
		Punto2_(Punto2_<T>&&) = default;

		template<typename U>
		explicit inline operator Punto2_<U>() const
		{
			return{ static_cast<U>(x), static_cast<U>(y) };
		}
		
#ifdef SOPORTE_OPENCV

		Punto2_(const cv::Point_<T>& p_punto) 
			: x(p_punto.x)
			, y(p_punto.y)
		{};

		template<typename U>
		explicit Punto2_(const cv::Point_<U>& p_punto) 
			: x(static_cast<U>(p_punto.x))
			, y(static_cast<U>(p_punto.y))
		{};

		inline operator cv::Point_<T>() const { return{ x, y }; }

		template<typename U>
		explicit inline operator cv::Point_<U>() const { return{ static_cast<U>(x), static_cast<U>(y) }; }

#endif //SOPORTE_OPENCV

		Punto2_<T> operator+(const Punto2_<T>& punto) const
		{
			return{ this->x + punto.x, this->y + punto.y };
		}

		Punto2_<T> operator-(const Punto2_<T>& punto) const
		{
			return{ this->x - punto.x, this->y - punto.y };
		}

		Punto2_<T> operator*(T p_valor) const
		{
			return{ this->x * p_valor, this->y * p_valor };
		}

		Punto2_<T> operator/(T p_valor) const
		{
			return{ this->x / p_valor, this->y / p_valor };
		}

		void operator=(const Punto2_<T>& p_punto)
		{
			this->x = p_punto.x;
			this->y = p_punto.y;
		}

		void operator+=(const Punto2_<T>& p_punto)
		{
			this->x += p_punto.x;
			this->y += p_punto.y;
		}

		void operator-=(const Punto2_<T>& p_punto)
		{
			this->x -= p_punto.x;
			this->y -= p_punto.y;
		}

		void operator*=(T p_valor)
		{
			this->x = this->x * p_valor;
			this->y = this->y * p_valor;
		}

		void operator/=(T p_valor)
		{
			this->x = this->x / p_valor;
			this->y = this->y / p_valor;
		}

		bool operator==(const Punto2_<T>& p_punto) const
		{
			return (this->x == p_punto.x) && (this->y == p_punto.y);
		}

		bool operator!=(const Punto2_<T>& p_punto) const
		{
			return !(*this == p_punto);
		}
		
		void normalizar()
		{
			*this /= std::sqrt(x*x + y*y);
		}
	};

	typedef Punto2_<int> Punto2i;
	typedef Punto2_<float> Punto2f;
	typedef Punto2_<double> Punto2d;

	struct DatosPose
	{
		double pos_x;
		double pos_y;
		int orientacion_mgrad;
		int error;

		DatosPose()
		{
			pos_x = 0;
			pos_y = 0;
			orientacion_mgrad = 0;
			error = -1;
		}

		DatosPose(double p_pos_x, double p_pos_y, int p_orientacion_mgrad, int p_error = -1)
		{
			pos_x = p_pos_x;
			pos_y = p_pos_y;
			orientacion_mgrad = p_orientacion_mgrad;
			error = p_error;
		}

		template<typename T>
		DatosPose(Punto2_<T> p_punto, int p_orientacion_mgrad, int p_error = -1)
		{
			pos_x = p_punto.x;
			pos_y = p_punto.y;
			orientacion_mgrad = p_orientacion_mgrad;
			error = p_error;
		}

		template<typename T>
		explicit DatosPose(Punto2_<T> p_punto)
		{
			pos_x = p_punto.x;
			pos_y = p_punto.y;
			orientacion_mgrad = 0;
			error = -1;
		}

		bool operator==(const DatosPose& p_punto) const
		{
			return (this->pos_x == p_punto.pos_x) && (this->pos_y == p_punto.pos_y) && (this->orientacion_mgrad == p_punto.orientacion_mgrad);
		}

		bool operator!=(const DatosPose& p_punto) const
		{
			return !(*this == p_punto);
		}

		template<typename U>
		inline operator Punto2_<U>() const { return{ static_cast<U>(pos_x), static_cast<U>(pos_y) }; }
	};
		
	template<typename T>
	struct Punto3_
	{
		static_assert(std::is_arithmetic<T>::value, "Los puntos se deben definir con tipo aritmetico.");

		T x;
		T y;
		T z;

		Punto3_()
			: x(0)
			, y(0)
			, z(0)
		{}
		;

		Punto3_(T p_x, T p_y, T p_z)
			: x(p_x)
			, y(p_y)
			, z(p_z)
		{}
		;

		Punto3_(const Punto3_<T>&) = default;
		Punto3_(Punto3_<T>&&) = default;

		template<typename U>
		explicit inline operator Punto3_<U>() const
		{
			return { static_cast<U>(x), static_cast<U>(y), static_cast<U>(z) };
		}
		
#ifdef SOPORTE_OPENCV

		Punto3_(const cv::Point3_<T>& p_punto) 
			: x(p_punto.x)
			, y(p_punto.y)
			, z(p_punto.z)
		{}
			
		template<typename U>
		explicit Punto3_(const cv::Point3_<U>& p_punto) 
			: x(static_cast<U>(p_punto.x))
			, y(static_cast<U>(p_punto.y))
			, z(static_cast<U>(p_punto.z))
		{}

		inline operator cv::Point3_<T>() const { return { x, y, z }; }

		template<typename U>
		explicit inline operator cv::Point3_<U>() const { return { static_cast<U>(x), static_cast<U>(y) , static_cast<U>(z)}; }

#endif //SOPORTE_OPENCV

		Punto3_<T> operator+(const Punto3_<T>& punto) const
		{
			return { this->x + punto.x, this->y + punto.y, this->z + punto.z };
		}

		Punto3_<T> operator-(const Punto3_<T>& punto) const
		{
			return { this->x - punto.x, this->y - punto.y, this->z - punto.z };
		}

		Punto3_<T> operator*(T p_valor) const
		{
			return { this->x * p_valor, this->y * p_valor, this->z * p_valor };
		}

		Punto3_<T> operator/(T p_valor) const
		{
			return { this->x / p_valor, this->y / p_valor, this->z / p_valor };
		}

		void operator=(const Punto3_<T>& p_punto)
		{
			this->x = p_punto.x;
			this->y = p_punto.y;
			this->z = p_punto.z;
		}

		void operator+=(const Punto3_<T>& p_punto)
		{
			this->x += p_punto.x;
			this->y += p_punto.y;
			this->z += p_punto.z;
		}

		void operator-=(const Punto3_<T>& p_punto)
		{
			this->x -= p_punto.x;
			this->y -= p_punto.y;
			this->z -= p_punto.z;
		}

		void operator*=(T p_valor)
		{
			this->x = this->x * p_valor;
			this->y = this->y * p_valor;
			this->z = this->z * p_valor;
		}

		void operator/=(T p_valor)
		{
			this->x = this->x / p_valor;
			this->y = this->y / p_valor;
			this->z = this->z / p_valor;
		}

		bool operator==(const Punto3_<T>& p_punto) const
		{
			return (this->x == p_punto.x) && (this->y == p_punto.y) && (this->z == p_punto.z);
		}

		bool operator!=(const Punto3_<T>& p_punto) const
		{
			return !(*this == p_punto);
		}
		
		void normalizar()
		{
			*this /= modulo();
		}
		
		double modulo() const
		{
			return std::sqrt(x*x + y*y + z*z);
		}
		
		double dot(const Punto3_<T>& v2) const
		{
			return this->x * v2.x + this->y * v2.y + this->z * v2.z;
		}
		
		Punto3_<T> cross(const Punto3_<T>& v2) const
		{
			return { this->y * v2.z - v2.y * this->z, v2.x * this->z - this->x * v2.z, this->x * v2.y - v2.x * this->y };
		}
	};

	typedef Punto3_<int> Punto3i;
	typedef Punto3_<float> Punto3f;
	typedef Punto3_<double> Punto3d;
}