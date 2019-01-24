#include <node_controller/controller_node_functions.h>
#include <sstream>


int main(int argc, char *argv[])
{

	ros::init(argc, argv, "controller_node");
	ros::NodeHandle n;
	ros::Publisher launcher_pub = n.advertise<std_msgs::String>("launcher", 10);
    ros::Publisher mapName_pub = n.advertise<std_msgs::String>("mapName", 10);
    std_msgs::String map_name;

	ros::Rate loop_rate(10);

    typedef agv::comtcp::ProtocoloRedAgv Protocolo;
	agv::comtcp::WrapperClienteProtocolo<Protocolo> m_socket_com_agv;
	agv::comtcp::ClienteTcp m_socket_com_detector;

	std::string m_tag_red_local = "ros_comm";
	std::string m_tag_red_agv = "AGV";
	std::string m_ip_agv = "127.0.0.1";
	int m_puerto_agv = 8900;

    while (ros::ok())
    {
        std_msgs::String msg;
		std::stringstream ss;

        try
        {
            std::vector<Protocolo::Paquete> paquetes_recibidos;

            if (!m_socket_com_agv.esta_conectado())
            {
                m_socket_com_agv.establece_conexion(m_ip_agv, m_puerto_agv);
                Protocolo::Paquete paquete_envio = Protocolo::nueva_consulta_ascii(m_tag_red_local, m_tag_red_agv, "logIn");
                m_socket_com_agv.enviar_datos(paquete_envio);
            }

            if (m_socket_com_agv.listo_para_recibir(1000))
            {
                m_socket_com_agv.recibir_datos(paquetes_recibidos);
                for (const auto& paquete_i : paquetes_recibidos)
                {
                    if (paquete_i.tipo == Protocolo::Paquete::Tipo_Paquete::CONSULTA)
                    {
                        std::istringstream comando_recibido(paquete_i.comando);
                        std::string nombre_cmd;
                        comando_recibido >> nombre_cmd;

                        Protocolo::Paquete paquete_respuesta = paquete_i.compon_respuesta(false, "Command not available");
                        try{
                            if (nombre_cmd.compare("newMap") == 0)
                            {
                                ss << "launch_mapping";
                                msg.data = ss.str();
                                std::string map_name_aux = "";      
                                std::string map_name_argument = "map_name";
                                newMapArguments(comando_recibido, map_name_argument, map_name_aux);

                                map_name.data = map_name_aux;

                                
                                launcher_pub.publish(msg);
                                paquete_respuesta = paquete_i.compon_respuesta(true, "Comando newMap");
                            }
                            else if (nombre_cmd.compare("localization") == 0)
                            {
                                ss << "launch_localization";
                                msg.data = ss.str();
                                std::string map_name = "";
                                geometry_msgs::Pose origin_map, origin_position;
                                std::vector<std::string> localization_arguments{"map_name","xm","ym","yawm","xp","yp","yawp"};
                                localizationArguments(comando_recibido, localization_arguments, map_name, origin_map, origin_position);
                                
                                setMapParam(map_name);
                                setPosesFile(origin_map, origin_position);
                                launcher_pub.publish(msg);
                                paquete_respuesta = paquete_i.compon_respuesta(true, "Comando localization");
                            }
                            else if (nombre_cmd.compare("stopLocalization") == 0)
                            {
                                ss << "shutdown_localization";
                                msg.data = ss.str();
                                launcher_pub.publish(msg);

                                paquete_respuesta = paquete_i.compon_respuesta(true, "Comando stopLocalization");
                            }else if (nombre_cmd.compare("saveMap") == 0)
                            {
                                ss << "shutdown_mapping";
                                msg.data = ss.str();
                                launcher_pub.publish(msg);

                                paquete_respuesta = paquete_i.compon_respuesta(true, "Comando saveMap");
                            }
                            else if (nombre_cmd.compare("exit") == 0)
                            {
                                ss << "nothing";
                                msg.data = ss.str();
                                launcher_pub.publish(msg);
                                paquete_respuesta = paquete_i.compon_respuesta(true, "Ningun comando");
                            }               
                        }
                        catch(const std::exception& e)
                        {
                            paquete_respuesta = paquete_i.compon_respuesta(false, e.what());
                        }
                        m_socket_com_agv.enviar_datos(paquete_respuesta);
                    }
                    else
                    {
                        m_tag_red_agv = paquete_i.origen;
                    }
                }
            }

            paquetes_recibidos.clear();
        }
        catch (const std::exception& e)
        {
            LOG_ALARM("Error al comunicar con el AGV: " << e.what());
        }

        mapName_pub.publish(map_name);
    	ros::spinOnce();
		loop_rate.sleep();
    }

	return 0;
}