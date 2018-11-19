// Copyright (C) 2017 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: funciones_matematicas.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2015/11/13

#pragma once

#ifndef _FUNCIONES_MATEMATICAS_H
#define _FUNCIONES_MATEMATICAS_H

#include "../../Librerias.h"
#include "punto.h"
#include "../tipos_dato.h"
#include <cmath>
#include <stdexcept>
#include <vector>

namespace agv
{
	double grados(double anguloRadianes);
	double radianes(double anguloGrados);
	double incrementa_angulo(double p_angulo_grados, double p_incremento);
	double incrementa_angulo_mgrad(double p_angulo_miligrados, double p_incremento);
	Punto2d rotar_punto(const Punto2d& punto, double angulo_grados);
	double calcula_distancia(const Punto2d& punto0, const Punto2d& punto1);
	double calcula_distancia(const DatosPose& punto0, const DatosPose& punto1);
	Punto2d vector_unitario(double angulo);
	Punto2d vector_unitario(const Punto2d& punto0, const Punto2d& punto1);
	Punto2d desplazar_punto(const Punto2d& punto, double angulo, double distancia);
	DatosPose desplazar_punto(const DatosPose& punto, double angulo, double distancia);
	double distancia_punto_segmento(const Punto2d& p_inicio_linea, const Punto2d& p_fin_linea, const Punto2d& p_punto, Punto2d* p_ret_punto_cercano = nullptr);
	/**
	*	@return t<0 = antes del punto inicial, t = 0 en el punto inicial, t > 0 && t < 1 = en el tramo, t = 1 en el punto final, t > 1 despues del punto final
	*/
	double coeficiente_pretenencia_segmento(const Punto2d& p_inicio_segmento, const Punto2d& p_fin_segmento, const Punto2d& p_punto);
	double distancia_punto_linea(const Punto2d& inicio_linea, const Punto2d& fin_linea, const Punto2d& punto);
	double distancia_punto_linea(const Punto2d& inicio_linea, double angulo, const Punto2d& punto);
	Punto2d proyeccion_punto_linea(const Punto2d& inicio_linea, const Punto2d& fin_linea, const Punto2d& punto);
	Punto2d proyeccion_punto_linea(const Punto2d& inicio_linea, double angulo, const Punto2d& punto);
	//Obtenido de http://www.ilikebigbits.com/blog/2015/3/2/plane-from-points
	bool plano_a_partir_de_puntos(const std::vector<Punto3d>& p_vector_puntos, Punto3d& ret_normal, Punto3d& ret_centroide);
	//Determina si el punto "punto" perteneciente a la recta que pasa por puntos inicio_tramo y
	//fin_tramo se encuentra en el tramo formado por los puntos inicio_tramo y fin_tramo
	bool punto_linea_en_tramo(const Punto2d& inicio_tramo, const Punto2d& fin_tramo, const Punto2d& punto);
	double orientacion_2p_grados(const Punto2d& punto0, const Punto2d& punto1);
	double orientacion_2p_miligrados(const Punto2d& punto0, const Punto2d& punto1);
	double menor_diferencia_angulos(double angulo0, double angulo1);
	double menor_diferencia_angulos_mgrad(double angulo0, double angulo1);
	int menor_diferencia_angulos_mgrad(int angulo0, int angulo1);
	int bisectriz_mgrad(int angulo0, int angulo1);
	Punto2d polar_to_cartesian(double p_radio, double p_angulo_mgrad);
	
	// Given three colinear points p, q, r, the function checks if
	// point q lies on line segment 'pr'
	bool punto_en_segmento(const agv::Punto2i& p, const agv::Punto2i& q, const agv::Punto2i& r);

	// The main function that returns true if line segment 'p1q1'
	// and 'p2q2' intersect.
	bool comprueba_interseccion_segmentos(const agv::Punto2i& p1, const agv::Punto2i& q1, const agv::Punto2i& p2, const agv::Punto2i& q2);
	
	class Interpolador
	{
	public:
		virtual ~Interpolador() = default;
		virtual double get_y(double p_x) const = 0;
		virtual double get_x(double p_y) const = 0;
	};
	
	class InterpoladorLineal : public Interpolador
	{
	public:
		InterpoladorLineal();
		InterpoladorLineal(const agv::Punto2d& p_p1, const agv::Punto2d& p_p2, bool p_limita_extremos = false);
		InterpoladorLineal(double p_pendiente, double p_ordenada);
		virtual ~InterpoladorLineal() = default;
		virtual double get_y(double p_x) const override;
		virtual double get_x(double p_y) const override;
		double get_x_ilimitada(double p_x) const;
		double get_y_ilimitada(double p_x) const;
		void set_max(const agv::Punto2d& p_max) { m_max = p_max; };
		void set_min(const agv::Punto2d& p_min) { m_min = p_min; };
		agv::Punto2d get_max() const { return m_max; }
		agv::Punto2d get_min() const { return m_min; }
		
	private:
		double m_pendiente;
		double m_ordenada;
		agv::Punto2d m_max;
		agv::Punto2d m_min;
	};

	/**
	 * @brief Limita la variacion de un valor con rampas de subida y bajada en funcion del slew rate configurado
	 */
	class LimitadorSlewRate
	{
	public:
		LimitadorSlewRate();
		virtual ~LimitadorSlewRate() = default;
		void set_ref(double p_ref, double p_ts = -1);
		double get_real_set_ref(double p_ref, double p_ts = -1);
		double get_real(double p_ts = -1);
		void set_slew_rate(double p_pos_slew_rate, double p_neg_slew_rate);
		void set_limites(double p_valor_max, double p_valor_min);

	protected:
		virtual void simular(double p_ts = -1);
		agv::Temporizador m_temp_sim;
		double m_max_pos_slew_rate;
		double m_max_neg_slew_rate;
		double m_salida_max;
		double m_salida_min;

		double m_ultimo_valor;
		double m_valor_ref;
	};

	/**
	* @brief Similar a LimitadorSlewRate pero en este caso el slew rate se aplica en valor absoluto, como incremento y decremento maximos.
	* Esto quiere decir que si se especifica un slew rate positivo de 100 unidades y uno negativo de 1000 unidades, 
	* el paso de 0 a 1000 lo hara en el mismo tiempo que de 0 a -1000 (en 10 segundos) mientras que de 1000 a 0 o -1000 a 0 tardara 1 segundo.
	* Sin embargo, el paso de -1000 a 1000 lo hara en dos tramos: 1 segundo de -1000 a 0 y en 10 segundos de 0 a 1000 (total 11 segundos)
	*/
	class LimitadorSlewRateAbsoluto : public LimitadorSlewRate
	{
	public:
		using LimitadorSlewRate::LimitadorSlewRate;

	private:
		virtual void simular(double p_ts = -1) override;
	};
}
#endif /* _FUNCIONES_MATEMATICAS_H */
