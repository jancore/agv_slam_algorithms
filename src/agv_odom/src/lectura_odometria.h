// Copyright (C) 2018 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: lectura_odometria.h
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2018/11/13

#pragma once

#include <generales/geometria/punto.h>
#include <comunicaciones/sockets/tcp/tramas/protocolo_red_agv.h>
#include <string>


class LecturaOdometria
{
	typedef agv::comtcp::ProtocoloRedAgv Protocolo;
	constexpr static auto cm_nombre_red_nodo = "ROS";
public:
	LecturaOdometria(const std::string& p_ip_agv, int p_puerto = 8900);
	
	bool get_esta_conectado() const;
	agv::Punto2d get_vector_movimiento(long p_timeout_ms = 1000);

private:
	std::string m_ip_agv;
	int m_puerto_agv;
	agv::Punto2d m_ultimo_vector;
	std::string m_nombre_red_agv = "AGV";
	double m_distancia_ruedas = 1200;

	agv::comtcp::WrapperClienteProtocolo<Protocolo> m_com_agv;
	std::vector<std::pair<std::string, std::string>> get_variable(const std::vector<std::string>& p_variables, long p_timeout_ms);
	int m_paquete_en_espera_respuesta = -1;
	bool m_esperando_respuesta;
	bool m_hay_error;
};

std::pair<std::string, std::string> leer_argumento(const std::string& p_argumento);
bool leer_argumento_stream(std::istream& p_stream, std::pair<std::string, std::string>& ret, bool p_incluye_comillas);
void leer_campo_entrecomillado(std::string& p_campo, std::istream& p_istream, bool p_incluye_comillas);