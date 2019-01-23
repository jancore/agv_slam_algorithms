#ifndef CONTROLLER_NODE_FUNCTIONS_H
#define CONTROLLER_NODE_FUNCTIONS_H

#include <stdlib.h>
#include <sstream>
#include <fstream>
#include "ros/ros.h"
#include "tf/transform_datatypes.h"
#include "geometry_msgs/Pose.h"
#include <comunicaciones/sockets/tcp/cliente_tcp.h>
#include <comunicaciones/sockets/tcp/tramas/protocolo_red_agv.h>
#include "lectura_odometria.h"
#include "std_msgs/String.h"


void setMapParam(std::string map_name);
void setPosesFile(geometry_msgs::Pose origin_map, geometry_msgs::Pose origin_position);
std::vector<std::string> extractArguments(std::string command, std::vector<std::string> name_arguments);
void newMapArguments(std::string command, std::string map_name_argument, std::string& map_name);
void localizationArguments(std::string command, std::vector<std::string> localization_arguments, std::string& map_name,
                            geometry_msgs::Pose& origin_map, geometry_msgs::Pose& origin_position);

#endif