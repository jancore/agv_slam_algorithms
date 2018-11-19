// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: matriz_transformacion.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2017/6/16

#pragma once

//Librerias
#include "../../Librerias.h"
#include "punto.h"
//Opencv
#ifdef SOPORTE_OPENCV
#include <opencv2/core.hpp>
#endif //SOPORTE_OPENCV
//STL
#include <vector>
#include <cmath>
#include <stdexcept>

namespace agv
{
	class Matriz
	{
	public:
		Matriz(std::size_t p_filas, std::size_t p_columnas)
			: filas(p_filas)
			, columnas(p_columnas)
			, coeficientes(p_filas * p_columnas, 0)
		{}
	
		Matriz(std::initializer_list<std::initializer_list<double>> p_ini)
			: filas(p_ini.size())
			, columnas(p_ini.begin()->size())
			, coeficientes(filas * columnas, 0)
		{
			std::size_t ptr_vector = 0;
			for (auto iter_i = p_ini.begin(); iter_i != p_ini.end(); ++iter_i)
			{
				if (iter_i->size() != columnas)
					throw std::runtime_error("Se ha proporcionado una lista de inicializacion incompleta al construir la matriz.");
				
				for (auto iter_j = iter_i->begin(); iter_j !=  iter_i->end(); ++iter_j)
				{
					coeficientes[ptr_vector] = *iter_j;
					++ptr_vector;
				}
			}
		}
		
		double& at_check(int fila, int columna)
		{
			return coeficientes.at((columnas * fila) + columna);
		}
	
		double at_check(int fila, int columna) const
		{
			return coeficientes.at((columnas * fila) + columna);
		}
	
		double& at(int fila, int columna)
		{
			return coeficientes[(columnas * fila) + columna];
		}
	
		double at(int fila, int columna) const
		{
			return coeficientes[(columnas * fila) + columna];
		}

		static Matriz identidad(std::size_t p_orden)
		{
			Matriz matriz_ret(p_orden, p_orden);
			for (std::size_t elem_i = 0; elem_i < p_orden; ++elem_i)
			{
				matriz_ret.at(elem_i, elem_i) = 1;
			}

			return matriz_ret;
		}
		
		Matriz operator*(const Matriz& m2) const
		{
			if (this->filas != m2.columnas || this->columnas != m2.filas)
				throw std::runtime_error("Rango incorrecto al multiplicar matrices");
		
			Matriz retorno(this->filas, m2.columnas);
			for (std::size_t i = 0; i < this->filas; ++i)
				for (std::size_t j = 0; j < m2.columnas; ++j)
				{
					double suma = 0;
					for (std::size_t k = 0; k < this->columnas; ++k)
					{
						suma += this->at(i, k) * m2.at(k, j);
					}
					retorno.at(i, j) = suma;
				}
		
			return retorno;
		}
		
		Matriz operator*(double escalar) const
		{
			Matriz retorno = *this;
			
			for (double& elem_i : retorno.coeficientes)
				elem_i *= escalar;
			
			return retorno;
		}
		
		Matriz operator/(double escalar) const
		{
			Matriz retorno = *this;
			
			for (double& elem_i : retorno.coeficientes)
				elem_i /= escalar;
			
			return retorno;
		}
		
		Matriz operator+(double escalar) const
		{
			Matriz retorno = *this;
			
			for (double& elem_i : retorno.coeficientes)
				elem_i += escalar;
			
			return retorno;
		}
		
		Matriz operator-(double escalar) const
		{
			Matriz retorno = *this;
			
			for (double& elem_i : retorno.coeficientes)
				elem_i -= escalar;
			
			return retorno;
		}
		Matriz operator+(const Matriz& matriz) const
		{
			Matriz retorno = *this;
			
			for (std::size_t iter = 0; iter < retorno.coeficientes.size(); ++iter)
			{
				retorno.coeficientes[iter] += matriz.coeficientes[iter];
			}
			
			return retorno;
		}
		
		Matriz operator-(const Matriz& matriz) const
		{
			Matriz retorno = *this;
			
			for (std::size_t iter = 0; iter < retorno.coeficientes.size(); ++iter)
			{
				retorno.coeficientes[iter] -= matriz.coeficientes[iter];
			}
			
			return retorno;
		}
	
#ifdef SOPORTE_OPENCV
		cv::Mat to_cv_mat()
		{
			return cv::Mat(filas, columnas, CV_64FC1, coeficientes.data()).clone();
		}
#endif //SOPORTE_OPENCV
	
		std::size_t filas;
		std::size_t columnas;
		std::vector<double> coeficientes;
	};

	class MatrizDeRotacion
	{
	public:
		MatrizDeRotacion()
			: matriz_coeficientes(3, 3)
		{
			matriz_coeficientes = Matriz::identidad(3);
		}
		
		//Obtenido de http://stackoverflow.com/questions/10161553/rotate-a-vector-to-reach-orthogonality-with-another-vector
		MatrizDeRotacion(const agv::Punto3d& v1, const agv::Punto3d& v2)
			: matriz_coeficientes(3, 3)
		{
			agv::Punto3d v3 = v1.cross(v2);
			v3.normalizar();
			
			double angulo = std::acos(v1.dot(v2) / (v1.modulo() * v2.modulo()));
			
			Matriz v3x = {
				{ 0, -v3.z, v3.y },
				{ v3.z, 0, -v3.x },
				{ -v3.y, v3.x, 0 }
			};
						
			Matriz I = { 
				{ 1, 0, 0 },
				{ 0, 1, 0 },
				{ 0, 0, 1 }
			};
			
			matriz_coeficientes = I + (v3x * std::sin(angulo)) + ((v3x * v3x) *(1 - std::cos(angulo)));
		}
		
		void incluir_rotacion_x(double alfa)
		{
			Matriz mat_rotacion = {
				{ 1, 0, 0 },
				{ 0, std::cos(alfa), -std::sin(alfa) },
				{ 0, std::sin(alfa), std::cos(alfa) },
			};
		
			matriz_coeficientes = mat_rotacion * matriz_coeficientes;
		}
	
		void incluir_rotacion_y(double alfa)
		{
			Matriz mat_rotacion = {
				{ std::cos(alfa), 0, std::sin(alfa) },
				{ 0, 1, 0 },
				{ -std::sin(alfa), 0, std::cos(alfa) },
			};
		
			matriz_coeficientes = mat_rotacion * matriz_coeficientes;
		}
	
		void incluir_rotacion_z(double alfa)
		{
			Matriz mat_rotacion = {
				{ std::cos(alfa), -std::sin(alfa), 0 },
				{ std::sin(alfa), std::cos(alfa), 0 },
				{ 0, 0, 1 },
			};
		
			matriz_coeficientes = mat_rotacion * matriz_coeficientes;
		}
	
		template<typename T>
		agv::Punto2_<T> rotar_punto(const agv::Punto2_<T>& p_punto) const
		{
			return {
				p_punto.x * matriz_coeficientes.at(0, 0) + p_punto.y * matriz_coeficientes.at(0, 1),
				p_punto.x * matriz_coeficientes.at(1, 0) + p_punto.y * matriz_coeficientes.at(1, 1)
			};
		}
	
		template<typename T>
		agv::Punto3_<T> rotar_punto(const agv::Punto3_<T>& p_punto) const
		{
			return {
				p_punto.x * matriz_coeficientes.at(0, 0) + p_punto.y * matriz_coeficientes.at(0, 1) + p_punto.z * matriz_coeficientes.at(0, 2),
				p_punto.x * matriz_coeficientes.at(1, 0) + p_punto.y * matriz_coeficientes.at(1, 1) + p_punto.z * matriz_coeficientes.at(1, 2),
				p_punto.x * matriz_coeficientes.at(2, 0) + p_punto.y * matriz_coeficientes.at(2, 1) + p_punto.z * matriz_coeficientes.at(2, 2)
			};
		}
		
		template<typename Iterator>
		void aplicar_rotacion(Iterator&& p_begin, Iterator&& p_end) const
		{
			for (auto iter = p_begin; iter != p_end; ++iter)
			{
				*iter = rotar_punto(*iter);
			}
		}
	
		Matriz matriz_coeficientes;
	};

	class MatrizDeTransformacion
	{
	public:
		MatrizDeTransformacion()
			: matriz_coeficientes(4, 4)
		{
			matriz_coeficientes = Matriz::identidad(4);
		}

		//Obtenido de http://stackoverflow.com/questions/10161553/rotate-a-vector-to-reach-orthogonality-with-another-vector
		MatrizDeTransformacion(const MatrizDeRotacion& p_matriz_rotacion)
			: matriz_coeficientes(4, 4)
		{
			matriz_coeficientes = Matriz::identidad(4);
			incluir_rotacion(p_matriz_rotacion);
		}

		void incluir_rotacion_x(double alfa)
		{
			Matriz mat_rotacion = {
				{ 1, 0, 0, 0 },
				{ 0, std::cos(alfa), -std::sin(alfa), 0 },
				{ 0, std::sin(alfa), std::cos(alfa), 0 },
				{ 0, 0, 0, 1 },
			};

			matriz_coeficientes = mat_rotacion * matriz_coeficientes;
		}

		void incluir_rotacion_y(double alfa)
		{
			Matriz mat_rotacion = {
				{ std::cos(alfa), 0, std::sin(alfa), 0 },
				{ 0, 1, 0, 0 },
				{ -std::sin(alfa), 0, std::cos(alfa), 0 },
				{ 0, 0, 0, 1 },
			};

			matriz_coeficientes = mat_rotacion * matriz_coeficientes;
		}

		void incluir_rotacion_z(double alfa)
		{
			Matriz mat_rotacion = {
				{ std::cos(alfa), -std::sin(alfa), 0, 0 },
				{ std::sin(alfa), std::cos(alfa), 0, 0 },
				{ 0, 0, 1, 0 },
				{ 0, 0, 0, 1 },
			};

			matriz_coeficientes = mat_rotacion * matriz_coeficientes;
		}

		void incluir_rotacion(const agv::MatrizDeRotacion& p_matriz_rotacion)
		{
			agv::Matriz mat_rotacion_ampliada(4, 4);
			mat_rotacion_ampliada.coeficientes = p_matriz_rotacion.matriz_coeficientes.coeficientes;
			mat_rotacion_ampliada.coeficientes.insert(mat_rotacion_ampliada.coeficientes.begin() + 3, 0);
			mat_rotacion_ampliada.coeficientes.insert(mat_rotacion_ampliada.coeficientes.begin() + 7, 0);
			mat_rotacion_ampliada.coeficientes.insert(mat_rotacion_ampliada.coeficientes.end(), 4, 0);
			mat_rotacion_ampliada.coeficientes.push_back(1);

			matriz_coeficientes = mat_rotacion_ampliada * matriz_coeficientes;
		}

		void incluir_traslacion(const agv::Punto2d& p_punto)
		{
			Matriz mat_traslacion = {
				{ 1, 0, 0, p_punto.x },
				{ 0, 1, 0, p_punto.y },
				{ 0, 0, 1, 0 },
				{ 0, 0, 0, 1 },
			};

			matriz_coeficientes = mat_traslacion * matriz_coeficientes;
		}

		void incluir_traslacion(const agv::Punto3d& p_punto)
		{
			Matriz mat_traslacion = {
				{ 1, 0, 0, p_punto.x },
				{ 0, 1, 0, p_punto.y },
				{ 0, 0, 1, p_punto.z },
				{ 0, 0, 0, 1 },
			};

			matriz_coeficientes = mat_traslacion * matriz_coeficientes;
		}

		template<typename T>
		agv::Punto2_<T> transformar_punto(const agv::Punto2_<T>& p_punto) const
		{
			return {
				p_punto.x * matriz_coeficientes.at(0, 0) + p_punto.y * matriz_coeficientes.at(0, 1) + matriz_coeficientes.at(0, 3),
				p_punto.x * matriz_coeficientes.at(1, 0) + p_punto.y * matriz_coeficientes.at(1, 1) + matriz_coeficientes.at(1, 3)
			};
		}

		template<typename T>
		agv::Punto3_<T> transformar_punto(const agv::Punto3_<T>& p_punto) const
		{
			return {
				p_punto.x * matriz_coeficientes.at(0, 0) + p_punto.y * matriz_coeficientes.at(0, 1) + p_punto.z * matriz_coeficientes.at(0, 2) + matriz_coeficientes.at(0, 3),
				p_punto.x * matriz_coeficientes.at(1, 0) + p_punto.y * matriz_coeficientes.at(1, 1) + p_punto.z * matriz_coeficientes.at(1, 2) + matriz_coeficientes.at(1, 3),
				p_punto.x * matriz_coeficientes.at(2, 0) + p_punto.y * matriz_coeficientes.at(2, 1) + p_punto.z * matriz_coeficientes.at(2, 2) + matriz_coeficientes.at(2, 3)
			};
		}

		template<typename Iterator>
		void aplicar_transformacion(Iterator&& p_begin, Iterator&& p_end) const
		{
			for (auto iter = p_begin; iter != p_end; ++iter)
			{
				*iter = transformar_punto(*iter);
			}
		}

		Matriz matriz_coeficientes;
	};
}