#include "agv_localization/send_position.h"

SendPosition::SendPosition(const std::string& p_ip_agv, int p_puerto)
	: m_ip_agv(p_ip_agv)
	, m_puerto_agv(p_puerto)
{
}

bool SendPosition::get_esta_conectado() const
{
	return m_com_agv.esta_conectado();
}

void SendPosition::Envia_posicion(int p_pos_x_mm, int p_pos_y_mm, int p_orientacion_mgrad, long p_timeout_ms)
{
	if (!get_esta_conectado())
	{
		m_com_agv.establece_conexion(m_ip_agv, m_puerto_agv);
		Protocolo::Paquete consulta_login = Protocolo::nueva_consulta_ascii(cm_nombre_red_nodo, m_nombre_red_agv, agv::comtcp::comando_red_to_string(agv::comtcp::Comandos_Red_Agv::logIn));
		consulta_login.on_respuesta = [this](const Protocolo::Paquete& p_paquete) { m_nombre_red_agv = p_paquete.origen; };
		m_com_agv.enviar_datos(consulta_login, p_timeout_ms);
	}
 
	std::string variables;
 
	variables += " i_slam_pos_x=" + std::to_string(p_pos_x_mm);
	variables += " i_slam_pos_y=" + std::to_string(p_pos_y_mm);
	variables += " i_slam_ang=" + std::to_string(p_orientacion_mgrad);
 
	Protocolo::Paquete envio_posicion = Protocolo::nueva_consulta_ascii(cm_nombre_red_nodo, m_nombre_red_agv, agv::comtcp::comando_red_to_string(agv::comtcp::Comandos_Red_Agv::setVariable) + variables);
	m_com_agv.enviar_datos(envio_posicion, p_timeout_ms);

	Protocolo::Paquete reset_watchdog = Protocolo::nueva_consulta_ascii(cm_nombre_red_nodo, m_nombre_red_agv, agv::comtcp::comando_red_to_string(agv::comtcp::Comandos_Red_Agv::resetProgramWatchdog));
	m_com_agv.enviar_datos(reset_watchdog, p_timeout_ms);
}