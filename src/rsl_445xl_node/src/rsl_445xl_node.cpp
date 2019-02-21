#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include "std_msgs/String.h"
#include <tf/transform_listener.h>
#include "rsl_445xl_node/socket.h"

int main(int argc, char** argv)
{
    ros::init(argc, argv, "rsl_445xl_node");
    ros::NodeHandle n;
    ros::Publisher scan_pub = n.advertise<sensor_msgs::LaserScan>("rsl_445xl_scan",10);

    int port = 10445;
    int receiverSocket;

    const double angular_resolution = 0.5; //in degrees
    const double laser_frequency = 1.0/0.04; //Hz

    ros::Rate r(100.0);

    /*populate the LaserScan message*/
    ros::Time scan_time;
    sensor_msgs::LaserScan scan;

    scan.header.frame_id = "base_laser";
    scan.scan_time = (1 / laser_frequency);
    scan.range_min = 0.1;
    scan.range_max = 8.25;

    try
    {
        receiverSocket = openUdpConnection(port);
    }
    catch(const std::exception& ex)
    {
        ROS_ERROR("An exception ocurred trying to open UDP connection. %s.", ex.what());
        return -1;
    }

    while(n.ok())
    {
        ros::spinOnce();
        scan_time = ros::Time::now();
        scan.header.stamp = scan_time;
        ++scan.header.seq;

        try
        {
            setLaserParams(receiverSocket, scan.angle_min, scan.angle_max, scan.angle_increment, scan.scan_time, scan.time_increment);
            getBeams(receiverSocket, scan.ranges);
            scan_pub.publish(scan);
        }
        catch (const std::exception& ex)
        {
            ROS_ERROR("An exception ocurred trying to recieve data from \"RSL 445XL\". %s.", ex.what());
        }

        r.sleep();
    }

    close(receiverSocket);
    return 0;
}