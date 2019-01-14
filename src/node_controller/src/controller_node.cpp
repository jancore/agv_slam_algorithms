#include "ros/ros.h"
#include "std_msgs/String.h"

#include <sstream>

int main(int argc, char *argv[])
{

	ros::init(argc, argv, "controller_node");
	ros::NodeHandle n;
	ros::Publisher launcher_pub = n.advertise<std_msgs::String>("launcher", 10);

	ros::Rate loop_rate(10);

    std::size_t index_delimiter;
    std::string delimiter = "_";
	std::string command, action_str, node_str;

	while (ros::ok())
	{
		std_msgs::String msg;

		std::stringstream ss;
		std::cout << "Command: ";
		std::cin >> command;

        index_delimiter = command.find(delimiter);
        
        if(index_delimiter != std::string::npos)
        {
            action_str = command.substr(0, index_delimiter);
            node_str = command.substr(action_str.length() + delimiter.length(), command.length() - 1);

            if(action_str == "launch" && node_str.length() > 0)
            {
                ss << "launch_" << node_str;
                msg.data = ss.str();
                launcher_pub.publish(msg);
            }
            else if(action_str == "shutdown" && node_str.length() > 0)
            {
                ss << "shutdown_" << node_str;
                msg.data = ss.str();
                launcher_pub.publish(msg);
            }
            else
            {
                ss << "nothing";
                msg.data = ss.str();
                launcher_pub.publish(msg);
            }
        }        
		
		ros::spinOnce();
		loop_rate.sleep();
	}

	return 0;
}