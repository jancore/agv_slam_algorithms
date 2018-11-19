#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include "std_msgs/String.h"
#include <comunicaciones/sensores/com_nav350.h>
#include <math.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "laser_scan_publisher");
    ros::NodeHandle n;
    ros::Publisher scan_pub = n.advertise<sensor_msgs::LaserScan>("nav350_scan",100);

    std::string ip_nav350;
    const double angular_resolution = 0.25; //in degrees
    const long num_readings = 360/angular_resolution;
    const double laser_frequency = 8; //Hz

    n.param<std::string>("ip_nav350", ip_nav350, "10.67.101.36");
    ROS_INFO("Got param: %s", ip_nav350.c_str());
    agv::comtcp::nav350::ComNav350 comnav350(ip_nav350);
    agv::comtcp::nav350::NavPositionData data_laser; 
    ros::Rate r(100.0);

    /*populate the LaserScan message*/
    ros::Time scan_time;
    sensor_msgs::LaserScan scan;
    scan.header.frame_id = "base_laser";
    scan.angle_min = -M_PI;
    scan.angle_max = M_PI;
    scan.angle_increment = angular_resolution * M_PI / 180.0; //in rads
    scan.scan_time = (1 / laser_frequency);
    scan.time_increment = (1 / laser_frequency) / (num_readings);
    scan.range_min = 0.5;
    scan.range_max = 250.0;

    while(n.ok())
    {
        scan_time = ros::Time::now();
        scan.header.stamp = scan_time;

        try
        {
            data_laser = comnav350.get_position_data_no_disconnect(5000,1,true, false);
            scan.ranges.resize(num_readings);
            if(data_laser.contorno.size() == 0){
                ROS_INFO("No data recieving...");
            }
            else{
                for(unsigned int i = 0; i < num_readings; ++i)
                {
                    scan.ranges[i] = data_laser.contorno[i].distancia / 1000.0; //distances in mm
                }
            }

            scan_pub.publish(scan);
        }
        catch (const std::exception& ex)
        {
            ROS_ERROR("An exception ocurred trying to recieve data from \"NAV350\". %s.", ex.what());
        }

        r.sleep();
    }
}