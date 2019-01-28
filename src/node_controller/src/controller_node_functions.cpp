#include <node_controller/controller_node_functions.h>

void setMapParam(std::string map_name)
{
    ros::NodeHandle n_;

    std::ofstream file;
    const char* homeDir = getenv("HOME");
    std::string directory = "/.ros/";
    std::string result = homeDir + directory + map_name;
    n_.setParam("/mrpt_localization_node/map_file", result);
}

void setPosesFile(geometry_msgs::Pose origin_map, geometry_msgs::Pose origin_position)
{
    ros::NodeHandle n_;
    std::ofstream file;
    const char* homeDir = getenv("HOME");
    std::string directory = "/catkin_ws/origins/";
    std::string filename = "default.txt";
    std::string result = homeDir + directory + filename;

    try
    {
        file.open(result);
        file << origin_map.position.x << " " << origin_map.position.y << " " << origin_map.position.z << " " << origin_map.orientation.x << " " << origin_map.orientation.y << " " << origin_map.orientation.z << " " << origin_map.orientation.w << "\n";
        file << origin_position.position.x << " " << origin_position.position.y << " " << origin_position.position.z << " " << origin_position.orientation.x << " " << origin_position.orientation.y << " " << origin_position.orientation.z << " " << origin_position.orientation.w;
    }
    catch (const std::exception& ex)
    {
        ROS_ERROR("The file could not be open. %s.", ex.what());
    }
    
    n_.setParam("origin_file", result);
}

void newMapArguments(std::istream& args, const std::string& map_name_argument, std::string& map_name)
{

    std::pair<std::string, std::string> argumentos;
    while (leer_argumento_stream(args, argumentos, false))
    {
        if(argumentos.first.compare(map_name_argument) == 0)
        {
            map_name = argumentos.second;
        }
        else
        {
            throw(std::runtime_error("Argumento no reconocido: " + argumentos.first));
        }
    }
}

void localizationArguments(std::istream& args, const std::vector<std::string>& localization_arguments, std::string& map_name,
                            geometry_msgs::Pose& origin_map, geometry_msgs::Pose& origin_position)
{
    int i = 0;
    std::vector<std::string> results;
    std::pair<std::string, std::string> argumentos;
    while (leer_argumento_stream(args, argumentos, false))
    {
        if(argumentos.first.compare(localization_arguments[i]) == 0)
        {
            results.push_back(argumentos.second);
        }
        else
        {
            throw(std::runtime_error("Argumento no reconocido: " + argumentos.first));
        }
        i++;
    }

    map_name = results[0];

    origin_map.position.x = atof(results[1].c_str());
    origin_map.position.y = atof(results[2].c_str());
    origin_map.orientation = tf::createQuaternionMsgFromYaw(atof(results[3].c_str())*M_PI/180.0);

    origin_position.position.x = atof(results[4].c_str());
    origin_position.position.y = atof(results[5].c_str());
    origin_position.orientation = tf::createQuaternionMsgFromYaw(atof(results[6].c_str())*M_PI/180.0);
}