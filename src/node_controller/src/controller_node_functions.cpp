#include <node_controller/controller_node_functions.h>

void setMapParam(std::string map_name)
{
    ros::NodeHandle n_;
    const char* homeDir = getenv("HOME");
    std::string directory = "/.ros";
    std::string result = homeDir + directory + map_name;
    n_.setParam("map_file", result);
}

void setPosesFile(geometry_msgs::Pose origin_map, geometry_msgs::Pose origin_position)
{
    ros::NodeHandle n_;
    std::ofstream file;
    const char* homeDir = getenv("HOME");
    std::string directory = "/catkin_ws/origins";
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

std::vector<std::string> extractArguments(std::string command, std::vector<std::string> name_arguments)
{
    std::vector<std::string> results;
    std::istringstream command_(command);
	std::stringstream ss;
    std::pair<std::string, std::string> argumentos;
    int i = 0;
    
    while (leer_argumento_stream(command_, argumentos, false))
    {
        if (argumentos.first.compare(name_arguments[i]) == 0){
            ss << argumentos.second;
            results.push_back(ss.str());
        }
        i++;
    }
    return results;
}

void newMapArguments(std::string command, std::string map_name_argument, std::string& map_name)
{
    std::vector<std::string> arguments;
    arguments.push_back(map_name_argument);
    
    std::vector<std::string> results;
    results = extractArguments(command, arguments);
    map_name = results[0];
}

void localizationArguments(std::string command, std::vector<std::string> localization_arguments, std::string& map_name,
                            geometry_msgs::Pose& origin_map, geometry_msgs::Pose& origin_position)
{
    std::vector<std::string> results = extractArguments(command, localization_arguments);
    map_name = results[0];

    origin_map.position.x = atof(results[1].c_str());
    origin_map.position.y = atof(results[2].c_str());
    origin_map.orientation = tf::createQuaternionMsgFromYaw(atof(results[3].c_str())*180.0/M_PI);

    origin_position.position.x = atof(results[4].c_str());
    origin_position.position.y = atof(results[5].c_str());
    origin_position.orientation = tf::createQuaternionMsgFromYaw(atof(results[6].c_str())*180.0/M_PI);
}