#pragma once

#include <generales/geometria/punto.h>
#include <comunicaciones/sockets/tcp/tramas/protocolo_red_agv.h>
#include <string>


class SendPosition
{
	typedef agv::comtcp::ProtocoloRedAgv Protocolo;
	constexpr static auto cm_nombre_red_nodo = "ROS_POSE";
public:
	SendPosition(const std::string& p_ip_agv, int p_puerto = 8900);
    void Envia_posicion(int p_pos_x_mm, int p_pos_y_mm, int p_orientacion_mgrad, long p_timeout_ms);
	
	bool get_esta_conectado() const;

private:
	std::string m_ip_agv;
	int m_puerto_agv;
	std::string m_nombre_red_agv = "AGV";

	agv::comtcp::WrapperClienteProtocolo<Protocolo> m_com_agv;
};