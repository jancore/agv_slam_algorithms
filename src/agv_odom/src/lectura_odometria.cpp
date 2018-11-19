// Copyright (C) 2018 Smart Technology S.A. - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited.
// Proprietary and confidential.
//
// File: lectura_odometria.cpp
// Author: Jesus Rueda Gonzalez <jesus.rueda@smarlogy.com>
// Date: 2018/11/13

#include "lectura_odometria.h"
#include <generales/geometria/funciones_matematicas.h>

LecturaOdometria::LecturaOdometria(const std::string& p_ip_agv, int p_puerto)
	: m_ip_agv(p_ip_agv)
	, m_puerto_agv(p_puerto)
{
}

bool LecturaOdometria::get_esta_conectado() const
{
	return m_com_agv.esta_conectado();
}

agv::Punto2d LecturaOdometria::get_vector_movimiento(long p_timeout_ms)
{
	agv::Punto2d vector_movimiento;

	if (!get_esta_conectado())
	{
		m_com_agv.establece_conexion(m_ip_agv, m_puerto_agv);
		Protocolo::Paquete consulta_login = Protocolo::nueva_consulta_ascii(cm_nombre_red_nodo, m_nombre_red_agv, agv::comtcp::comando_red_to_string(agv::comtcp::Comandos_Red_Agv::logIn));
		consulta_login.on_respuesta = [this](const Protocolo::Paquete& p_paquete) { m_nombre_red_agv = p_paquete.origen; };
		m_com_agv.enviar_datos(consulta_login, p_timeout_ms);
	}

	auto variables = get_variable({ "__sv_real_speed_mms", "__sv_real_wheel_angle_deg" }, p_timeout_ms);
	if (variables.size() != 2)
		throw(std::runtime_error("No se han podido obtener datos"));

	double velocidad_rueda = std::stoi(variables[0].second) / 1000.0;
	double angulo_rueda = std::stoi(variables[1].second) / 1000.0;
	
	double modulo_velocidad = velocidad_rueda * std::cos(agv::radianes(angulo_rueda));
	double velocidad_angular_rads = -(velocidad_rueda / (m_distancia_ruedas / 1000)) * std::sin(agv::radianes(angulo_rueda));
	
	vector_movimiento.x = modulo_velocidad;
	vector_movimiento.y = velocidad_angular_rads;

	return vector_movimiento;
}

std::vector<std::pair<std::string, std::string>> LecturaOdometria::get_variable(const std::vector<std::string>& p_variables, long p_timeout_ms)
{
	std::string comando_envio = agv::comtcp::comando_red_to_string(agv::comtcp::Comandos_Red_Agv::getVariable);

	for (const std::string& variable_i : p_variables)
		comando_envio += ' ' + variable_i;

	std::vector<std::pair<std::string, std::string>> retorno;

	Protocolo::Paquete paquete_envio = Protocolo::nueva_consulta_ascii(cm_nombre_red_nodo, m_nombre_red_agv, comando_envio);
	paquete_envio.timeout_paquete = 5000;
	paquete_envio.timeout_respuesta = 5000;
	paquete_envio.on_respuesta = [&](const Protocolo::Paquete& p_paquete)
	{
		if (m_paquete_en_espera_respuesta != (int)p_paquete.get_numero_paquete())
			return;

		m_esperando_respuesta = false;
		if (p_paquete.tipo == Protocolo::Paquete::Tipo_Paquete::NACK)
		{
			m_hay_error = true;
			return;
		}

		std::istringstream sstream_comando(p_paquete.comando);
		std::string token;
		sstream_comando >> token; //Eliminamos el comando

		std::pair<std::string, std::string> argumentos;
		while (leer_argumento_stream(sstream_comando, argumentos, false))
		{
			retorno.emplace_back(std::move(argumentos));
		}
	};

	paquete_envio.on_error_envio = [this](const std::string& p_string)
	{
		m_esperando_respuesta = false;
		m_hay_error = true;
	};

	paquete_envio.on_timeout_respuesta = [this]()
	{
		m_esperando_respuesta = false;
		m_hay_error = true;
	};

	m_esperando_respuesta = true;
	m_paquete_en_espera_respuesta = paquete_envio.get_numero_paquete();
	m_hay_error = false;
	m_com_agv.enviar_datos(paquete_envio, p_timeout_ms);
	agv::Temporizador temp_timeout(p_timeout_ms);
	while (m_esperando_respuesta)
	{
		if (m_com_agv.listo_para_recibir(p_timeout_ms))
		{
			std::vector<Protocolo::Paquete> paquetes_ret;
			m_com_agv.recibir_datos(paquetes_ret);
			if (!paquetes_ret.empty())
			{
				m_nombre_red_agv = paquetes_ret[0].origen;
			}
		}

		m_com_agv.limpia_buffers_protocolo();

		if (temp_timeout.terminado())
			throw(agv::comtcp::TcpTimeoutExcept("Timeout sobrepasado"));
	}

	m_paquete_en_espera_respuesta = -1;

	return retorno;
}

std::pair<std::string, std::string> leer_argumento(const std::string& p_argumento)
{
	std::size_t operador = p_argumento.find_first_of('=');
	if (operador == std::string::npos || operador == p_argumento.size() - 1)
		throw (std::runtime_error("Lectura de argumento incorrecto: " + p_argumento));

	return { p_argumento.substr(0, operador), p_argumento.substr(operador + 1) };
}

bool leer_argumento_stream(std::istream& p_stream, std::pair<std::string, std::string>& ret, bool p_incluye_comillas)
{
	std::string entrada;

	if (!(p_stream >> entrada))
		return false;

	std::pair<std::string, std::string> argumento = leer_argumento(entrada);

	leer_campo_entrecomillado(argumento.second, p_stream, p_incluye_comillas);
	
	ret = argumento;

	return true;
}

void leer_campo_entrecomillado(std::string& p_campo, std::istream& p_istream, bool p_incluye_comillas)
{
	if (!p_campo.empty() && p_campo[0] == '"')
	{
		bool buscando_fin_comillas = p_campo.size() == 1 || p_campo.back() != '"' || *(p_campo.end() - 2) == '\\';

		std::string string_ret = { p_incluye_comillas ? p_campo.begin() : (p_campo.begin() + 1), (buscando_fin_comillas || p_incluye_comillas) ? p_campo.end() : (p_campo.end() - 1) };

		//Buscamos todas las comillas precedidas del caracter \ y lo borramos
		for (auto iter = string_ret.begin(); iter != string_ret.end() && (iter + 1) != string_ret.end();)
		{
			if (*iter == '\\' && *(iter + 1) == '"')
			{
				iter = string_ret.erase(iter);
			}
			else
			{
				++iter;
			}
		}

		while (buscando_fin_comillas)
		{
			std::string token;
			if (!std::getline(p_istream, token, '"') || p_istream.eof())
				throw(std::runtime_error("Uso de comillas inconsistente"));

			if (token.size() > 1 && *(token.rbegin()) == '\\')
			{
				string_ret.append(token.begin(), token.end() - 1);
				string_ret.append(1, '"');
			}
			else
			{
				string_ret.append(token);
				if (p_incluye_comillas)
					string_ret.append(1, '"');
				buscando_fin_comillas = false;
			}
		}

		p_campo = std::move(string_ret);
	}
}