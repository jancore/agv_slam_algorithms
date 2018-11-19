// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: poligono.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2017/6/16

#ifndef POLIGONO_HPP
#define POLIGONO_HPP

#include "../../Librerias.h"
#include "../../rapidxml/rapidxml.hpp"
#include "funciones_matematicas.h"
#include "punto.h"
  //STL
#include <limits>
#include <cmath>
#include <vector>
#include <stdexcept>

namespace agv
{
	template <typename T>
	class Poligono {
	public:
		static_assert(std::is_arithmetic<T>::value, "Los poligonos se deben definir con tipo aritmetico.");

		Poligono() : m_definido(false) {};
		virtual ~Poligono() = default;
		Poligono(const std::vector<Punto2_<T>>& puntos);
		Poligono(rapidxml::xml_node<>* p_nodo_xml);
		Poligono(const Poligono&) = default;
		Poligono(Poligono&& p_poligono);
		Poligono<T>& operator=(Poligono<T>&& p_poligono);
		Poligono<T>& operator=(const Poligono<T>& p_poligono) = default;
		void redefine_poligono(const std::vector<Punto2_<T>>& puntos);
		bool punto_dentro(const Punto2_<T>& punto) const;
		bool punto_dentro(T pos_x, T pos_y) const;
		//bool comprueba_colision(const Poligono<T>& p_poligono2) const;
		bool comprueba_colision(const Poligono<T>& p_poligono2) const;
		std::pair<T, T> proyectar_en_eje(const Punto2_<T>& p_eje) const;
		void proyectar_en_eje(float p_eje_x, float p_eje_y, float& p_min, float& p_max) const;
		bool esta_definido() const;
		std::vector<Punto2_<T>> get_puntos() const;
		Punto2d get_centroide() const;
		template<typename U>
		double distancia(const Poligono<U>& p_poligono) const;

#ifdef SOPORTE_OPENCV
		Poligono(const std::vector<cv::Point_<T>>& puntos);
		void redefine_poligono(const std::vector<cv::Point_<T>>& puntos);
		std::vector<cv::Point_<T>> get_puntos_cv() const;
#endif //SOPORTE_OPENCV

	protected:
		template<typename T_Punto>
		void redefine_poligono(const std::vector<T_Punto>& puntos);

		bool m_definido;
		std::size_t m_polyCorners; // =  how many corners the polygon has (no repeats)
		std::vector<T> m_polyX; // =  coordenadas horizontales de los vertices
		std::vector<T> m_polyY; // =  coordenadas verticales de loc vertices
		T m_max_x;
		T m_max_y;
		T m_min_x;
		T m_min_y;
		Punto2d m_centroide;
		void calcula_centroide();
	};

	template <typename T>
	Poligono<T>::Poligono(const std::vector<Punto2_<T>>& p_puntos)
	{
		redefine_poligono(p_puntos);
	}

#ifdef SOPORTE_OPENCV
	template <typename T>
	Poligono<T>::Poligono(const std::vector<cv::Point_<T>>& p_puntos)
	{
		redefine_poligono(p_puntos);
	}
#endif //SOPORTE_OPENCV

	template<typename T>
	inline Poligono<T>::Poligono(rapidxml::xml_node<>* p_nodo_xml)
	{
		std::vector<agv::Punto2_<T>> puntos_zona;

		for (rapidxml::xml_node<>* nodo_punto = p_nodo_xml->first_node("punto"); nodo_punto; nodo_punto = nodo_punto->next_sibling("punto"))
		{
			agv::Punto2_<T> punto_aux;
			rapidxml::xml_attribute<>* atributo = nodo_punto->first_attribute("x");
			if (!atributo)
				throw(std::runtime_error("Lectura de zona incorrecta, falta coordenada x"));
			punto_aux.x = std::stod(atributo->value());

			atributo = nodo_punto->first_attribute("y");
			if (!atributo)
				throw(std::runtime_error("Lectura de zona incorrecta, falta coordenada y"));
			punto_aux.y = std::stod(atributo->value());

			puntos_zona.push_back(punto_aux);
		}

		redefine_poligono(puntos_zona);
	}

	template<typename T>
	Poligono<T>::Poligono(Poligono&& p_poligono)
	{
		*this = std::move(p_poligono);
	}

	template<typename T>
	Poligono<T>& Poligono<T>::operator=(Poligono&& p_poligono)
	{
		this->m_definido = std::move(p_poligono.m_definido);
		if (m_definido)
		{
			this->m_polyCorners = std::move(p_poligono.m_polyCorners);
			this->m_polyX = std::move(p_poligono.m_polyX);
			this->m_polyY = std::move(p_poligono.m_polyY);
			this->m_max_x = std::move(p_poligono.m_max_x);
			this->m_max_y = std::move(p_poligono.m_max_y);
			this->m_min_x = std::move(p_poligono.m_min_x);
			this->m_min_y = std::move(p_poligono.m_min_y);
			this->m_centroide = std::move(p_poligono.m_centroide);
		}

		return *this;
	}
/*
	template<typename T>
	inline Poligono<T>& Poligono<T>::operator=(const Poligono<T>& p_poligono)
	{
		*this = Poligono<T>(p_poligono);

		return *this;
	}
*/
	template<typename T>
	template<typename T_Punto>
	void Poligono<T>::redefine_poligono(const std::vector<T_Punto>& p_puntos)
	{
		m_polyCorners = p_puntos.size();

		if (m_polyCorners == 0)
		{
			m_definido = false;
			return;
		}

		m_definido = true;

		m_polyX.clear();
		m_polyY.clear();

		m_polyX.resize(m_polyCorners);
		m_polyY.resize(m_polyCorners);

		//Copiar puntos a los vectores
		for (std::size_t index = 0; index < m_polyCorners; ++index)
		{
			m_polyX[index] = p_puntos[index].x;
			m_polyY[index] = p_puntos[index].y;
		}

		//Valores precalculados
		this->m_max_x = m_polyX.front();
		this->m_max_y = m_polyY.front();
		this->m_min_x = m_polyX.front();
		this->m_min_y = m_polyY.front();

		for (std::size_t i = 0; i < m_polyCorners; ++i)
		{
			//En x
			if (m_max_x < m_polyX[i])
			{
				m_max_x = m_polyX[i];
			}
			if (m_min_x > m_polyX[i])
			{
				m_min_x = m_polyX[i];
			}
			//En y
			if (m_max_y < m_polyY[i])
			{
				m_max_y = m_polyY[i];
			}
			if (m_min_y > m_polyY[i])
			{
				m_min_y = m_polyY[i];
			}
		}

		calcula_centroide();
	}

	template<typename T>
	void Poligono<T>::redefine_poligono(const std::vector<agv::Punto2_<T>>& p_puntos)
	{
		redefine_poligono<agv::Punto2_<T>>(p_puntos);
	}

#ifdef SOPORTE_OPENCV
	template<typename T>
	void Poligono<T>::redefine_poligono(const std::vector<cv::Point_<T>>& p_puntos)
	{
		redefine_poligono<cv::Point_<T>>(p_puntos);
	}
#endif //SOPORTE_OPENCV

	template<typename T>
	bool Poligono<T>::punto_dentro(const Punto2_<T>& p_punto) const
	{
		return punto_dentro(p_punto.x, p_punto.y);
	}

	/*
	 * Comprueba si un punto esta dentro del poligono.
	 * Sacado de https://stackoverflow.com/questions/27589796/check-point-within-polygon
	 */
	template<typename T>
	bool Poligono<T>::punto_dentro(T p_pos_x, T p_pos_y) const
	{
		if (!m_definido) return false;

		if (p_pos_x < m_min_x || p_pos_x > m_max_x || p_pos_y < m_min_y || p_pos_y > m_max_y)
		{
			return false;
		}

		bool cn = false;
		for (std::size_t i = 0, j = m_polyCorners - 1; i < m_polyCorners; j = i++)
		{
			if (((m_polyY[i] <= p_pos_y) && (m_polyY[j] > p_pos_y))     // an upward crossing
				|| ((m_polyY[i] > p_pos_y) && (m_polyY[j] <= p_pos_y))) { // a downward crossing
					// compute  the actual edge-ray intersect x-coordinate
				float vt = (float)(p_pos_y - m_polyY[i]) / (m_polyY[j] - m_polyY[i]);
				if ((float)p_pos_x < ((float)m_polyX[i] + vt * (float)(m_polyX[j] - m_polyX[i]))) // P.x < intersect
					cn = !cn;   // a valid crossing of y=P.y right of P.x
			}
		}

		return cn;
	}

	/*
	template<typename T>
	bool Poligono<T>::comprueba_colision(const Poligono<T>& p_poligono2) const
	{
		std::size_t edgeCountA = this->m_polyCorners;
		std::size_t edgeCountB = p_poligono2.m_polyCorners;
		float edge_x;
		float edge_y;

		// Loop through all the edges of both polygons
		for (std::size_t edgeIndex = 0; edgeIndex < (edgeCountA + edgeCountB) - 1; ++edgeIndex)
		{
			if (edgeIndex < edgeCountA - 1)
			{
				edge_x = m_polyX[edgeIndex + 1] - m_polyX[edgeIndex];
				edge_y = m_polyY[edgeIndex + 1] - m_polyY[edgeIndex];
			}
			else if (edgeIndex == edgeCountA - 1)
			{
				edge_x = m_polyX[0] - m_polyX[edgeIndex];
				edge_y = m_polyY[0] - m_polyY[edgeIndex];
			}
			else if (edgeIndex - edgeCountA < edgeCountB - 1)
			{
				edge_x = m_polyX[edgeIndex - edgeCountA + 1] - m_polyX[edgeIndex - edgeCountA];
				edge_y = m_polyY[edgeIndex - edgeCountA + 1] - m_polyY[edgeIndex - edgeCountA];
			}
			else
			{
				edge_x = m_polyX[0] - m_polyX[edgeIndex - edgeCountA];
				edge_y = m_polyY[0] - m_polyY[edgeIndex - edgeCountA];
			}

			// ===== 1. Find if the polygons are currently intersecting =====

			// Find the axis perpendicular to the current edge
			double modulo = sqrt(((double)edge_x * (double)edge_x) + ((double)edge_y * (double)edge_y));
			float axis_x = edge_x / modulo;
			float axis_y = edge_y / modulo;
			float axis_perp_x = -edge_y / modulo;
			float axis_perp_y = edge_x / modulo;

			// Find the projection of the polygon on the current axis
			float minA, minB, maxA, maxB;
			this->proyectar_en_eje(axis_x, axis_y, minA, maxA);
			p_poligono2.proyectar_en_eje(axis_x, axis_y, minB, maxB);

			float minA_perp, minB_perp, maxA_perp, maxB_perp;
			this->proyectar_en_eje(axis_perp_x, axis_perp_y, minA_perp, maxA_perp);
			p_poligono2.proyectar_en_eje(axis_perp_x, axis_perp_y, minB_perp, maxB_perp);

			// Check if the polygon projections are currentlty intersecting
			//Correccion del metodo anterior
			if (minA < minB)
			{
				if (minB < maxA)
				{
					if (minA_perp < minB_perp)
					{
						if (minB_perp > maxA_perp)
						{
							return false;
						}
					}
					else
					{
						if (minA_perp > maxB_perp)
						{
							return false;
						}
					}
				}
				else
				{
					return false;
				}
			}
			else
			{
				if (minA < maxB)
				{
					if (minA_perp < minB_perp)
					{
						if (minB_perp > maxA_perp)
						{
							return false;
						}
					}
					else
					{
						if (minA_perp > maxB_perp)
						{
							return false;
						}
					}
				}
				else
				{
					return false;
				}
			}

		}

		return true;
	}
	*/

	template<typename T>
	bool Poligono<T>::comprueba_colision(const Poligono<T>& p_poligono2) const
	{
		//Si los bounding squares no colisionan terminamos la comprobacion en false
		if ((this->m_min_x > p_poligono2.m_max_x || this->m_max_x < p_poligono2.m_min_x)
			&& (this->m_min_y > p_poligono2.m_max_y || this->m_max_y < p_poligono2.m_min_y))
		{
			return false;
		}

		//Comprobamos si hay algun vertice dentro del otro poligono
		for (std::size_t vertice_i = 0; vertice_i < m_polyCorners; ++vertice_i)
		{
			if (p_poligono2.punto_dentro(agv::Punto2_<T>(m_polyX[vertice_i], m_polyY[vertice_i])))
			{
				return true;
			}
		}

		//Comprobamos si el otro poligono tiene algun vertice dentro de este
		for (std::size_t vertice_i = 0; vertice_i < p_poligono2.m_polyCorners; ++vertice_i)
		{
			if (this->punto_dentro(agv::Punto2_<T>(p_poligono2.m_polyX[vertice_i], p_poligono2.m_polyY[vertice_i])))
			{
				return true;
			}
		}

		//Comprobamos si intersecta alguna recta del perimetro de los dos poligonos
		for (std::size_t this_vertice_i = 0, this_vertice_j = m_polyCorners - 1; this_vertice_i < m_polyCorners; this_vertice_j = this_vertice_i++)
		{
			for (std::size_t p2_vertice_i = 0, p2_vertice_j = p_poligono2.m_polyCorners - 1; p2_vertice_i < p_poligono2.m_polyCorners; p2_vertice_j = p2_vertice_i++)
			{
				if (comprueba_interseccion_segmentos({ m_polyX[this_vertice_j], m_polyY[this_vertice_j] }, { m_polyX[this_vertice_i], m_polyY[this_vertice_i] }
					, { p_poligono2.m_polyX[p2_vertice_j],  p_poligono2.m_polyY[p2_vertice_j] }, { p_poligono2.m_polyX[p2_vertice_i],  p_poligono2.m_polyY[p2_vertice_i] }))
				{
					return true;
				}
			}
		}

		return false;
	}

	// Calculate the projection of a polygon on an axis
	// and returns it as a [min, max] interval
	template<typename T>
	std::pair<T, T> Poligono<T>::proyectar_en_eje(const Punto2_<T>& p_eje) const
	{
		// To project a point on an axis use the dot product
		T min = std::numeric_limits<T>::max();
		T max = std::numeric_limits<T>::min();

		proyectar_en_eje(p_eje.x, p_eje.y, min, max);

		return{ min, max };
	}

	// Calculate the projection of a polygon on an axis
	// and returns it as a [min, max] interval
	template<typename T>
	void Poligono<T>::proyectar_en_eje(float p_eje_x, float p_eje_y, float& p_min, float& p_max) const
	{
		// To project a point on an axis use the dot product
		double dotProduct;
		p_min = std::numeric_limits<float>::max();
		p_max = -std::numeric_limits<float>::max();

		for (std::size_t i = 0; i < m_polyCorners; ++i)
		{
			dotProduct = (m_polyX[i] * p_eje_x) + (m_polyY[i] * p_eje_y);
			if (dotProduct < p_min)
			{
				p_min = dotProduct;
			}

			if (dotProduct > p_max)
			{
				p_max = dotProduct;
			}
		}
	}

	template<typename T>
	bool Poligono<T>::esta_definido() const
	{
		return m_definido;
	}

	template<typename T>
	std::vector<Punto2_<T>> Poligono<T>::get_puntos() const
	{
		if (!m_definido)
			throw(std::runtime_error("Plano no definido"));

		std::vector<Punto2_<T>> vector_puntos;

		for (std::size_t index = 0; index < m_polyCorners; ++index)
		{
			vector_puntos.emplace_back(m_polyX[index], m_polyY[index]);
		}

		return vector_puntos;
	}

#ifdef SOPORTE_OPENCV
	template<typename T>
	std::vector<cv::Point_<T>> Poligono<T>::get_puntos_cv() const
	{
		if (!m_definido)
			throw(std::runtime_error("Plano no definido"));

		std::vector<cv::Point_<T>> vector_puntos;

		for (std::size_t index = 0; index < m_polyCorners; ++index)
		{
			vector_puntos.emplace_back(m_polyX[index], m_polyY[index]);
		}

		return vector_puntos;
	}
#endif //SOPORTE_OPENCV

	template<typename T>
	Punto2d Poligono<T>::get_centroide() const
	{
		return m_centroide;
	}

	template<typename T>
	template<typename U>
	double Poligono<T>::distancia(const Poligono<U>& p_poligono) const
	{
		if (!this->esta_definido() || !p_poligono.esta_definido())
			throw(std::invalid_argument("Poligono no definido"));

		double min_dist = std::numeric_limits<double>::max();
		//Calculamos la distancia de los vertices de este poligono al poligono 2
		for(int i = 0; i < this->m_polyCorners; ++i)
		{
			for (int j = 1; j < p_poligono.m_polyCorners; ++j)
			{
				double dist_segmento = distancia_punto_segmento(
					agv::Punto2d(p_poligono.m_polyX[j - 1], p_poligono.m_polyY[j - 1]),
					agv::Punto2d(p_poligono.m_polyX[j], p_poligono.m_polyY[j]),
					agv::Punto2d(this->m_polyX[i], this->m_polyY[i])
				);

				if (dist_segmento < min_dist)
				{
					min_dist = dist_segmento;
				}
			}
		}

		//Repetimos con los vertices del poligono 2 al poligono 1
		for (int i = 0; i < p_poligono.m_polyCorners; ++i)
		{
			for (int j = 1; j < this->m_polyCorners; ++j)
			{
				double dist_segmento = distancia_punto_segmento(
					agv::Punto2d(this->m_polyX[j - 1], this->m_polyY[j - 1]),
					agv::Punto2d(this->m_polyX[j], this->m_polyY[j]),
					agv::Punto2d(p_poligono.m_polyX[i], p_poligono.m_polyY[i])
				);

				if (dist_segmento < min_dist)
				{
					min_dist = dist_segmento;
				}
			}
		}

		return min_dist;
	}

	//Obtenido de: http://stackoverflow.com/questions/2792443/finding-the-centroid-of-a-polygon
	template<typename T>
	void Poligono<T>::calcula_centroide()
	{
		double signedArea = 0.0;
		double x0 = 0.0; // Current vertex X
		double y0 = 0.0; // Current vertex Y
		double x1 = 0.0; // Next vertex X
		double y1 = 0.0; // Next vertex Y
		double a = 0.0;  // Partial signed area

							// For all vertices except last
		std::size_t i = 0;
		for (; i < m_polyCorners - 1; ++i)
		{
			x0 = m_polyX[i];
			y0 = m_polyY[i];
			x1 = m_polyX[i + 1];
			y1 = m_polyY[i + 1];
			a = x0*y1 - x1*y0;
			signedArea += a;
			m_centroide.x += (x0 + x1)*a;
			m_centroide.y += (y0 + y1)*a;
		}

		// Do last vertex separately to avoid performing an expensive
		// modulus operation in each iteration.
		x0 = m_polyX[i];
		y0 = m_polyY[i];
		x1 = m_polyX[0];
		y1 = m_polyY[0];
		a = x0*y1 - x1*y0;
		signedArea += a;
		m_centroide.x += (x0 + x1)*a;
		m_centroide.y += (y0 + y1)*a;

		signedArea *= 0.5;
		m_centroide.x /= (6.0*signedArea);
		m_centroide.y /= (6.0*signedArea);
	}

	typedef Poligono<int> PoligonoInt;
}

#endif /* POLIGONO_HPP */