#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <fstream>
#include <time.h>


geometry_msgs::PoseStamped G_Origin;

void getOriginCallback(const geometry_msgs::PoseStamped::ConstPtr& pose)
{
    G_Origin = *pose;
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "get_origin_node");
    ros::NodeHandle n;
    ros::Subscriber origin_sub = n.subscribe<geometry_msgs::PoseStamped>("nav350_position", 10, getOriginCallback);

    std::ofstream file;
    time_t rawtime;
    struct tm * now;

    time(&rawtime);
    now = localtime(&rawtime);
    std::string directory = "/home/smarlogy/catkin_ws/origins/";
    std::string filename = "origin_map_" + 
        std::to_string(1900 + now->tm_year) + "-" + std::to_string(now->tm_mon + 1) + "-" + std::to_string(now->tm_mday) + "-" + 
        std::to_string(now->tm_hour) + "h" + std::to_string(now->tm_min) + "m" + std::to_string(now->tm_sec) + "s";

    try
    {
        file.open(directory + filename + ".txt");
    }
    catch (const std::exception& ex)
    {
        ROS_ERROR("The file could not be open. %s.", ex.what());
    }

    ros::Rate r(10.0);

    while(n.ok())
    {
        ros::spinOnce();

        if(G_Origin.pose.position.x != 0.0 && G_Origin.pose.position.y != 0.0)
        {
            file << G_Origin.pose.position.x << " " << G_Origin.pose.position.y << " " << G_Origin.pose.position.z << " ";
            file << G_Origin.pose.orientation.x << " " << G_Origin.pose.orientation.y << " " << G_Origin.pose.orientation.z << " " << G_Origin.pose.orientation.w;
            ros::shutdown();
        }

        r.sleep();
    }

    file.close();
    return 0;
}