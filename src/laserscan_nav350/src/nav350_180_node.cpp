#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include <geometry_msgs/PoseStamped.h>
#include "std_msgs/String.h"
#include <comunicaciones/sensores/com_nav350.h>
#include <tf/transform_listener.h>
#include <math.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "laser_scan_publisher");
    ros::NodeHandle n;
    ros::Publisher scan_pub = n.advertise<sensor_msgs::LaserScan>("nav350_scan",1);
    ros::Publisher position_pub = n.advertise<geometry_msgs::PoseStamped>("nav350_position",1);

    std::string ip_nav350;
    const double angular_resolution = 0.25; //in degrees
    const long num_readings = 180/angular_resolution;
    const double laser_frequency = 8; //Hz

    n.param<std::string>("ip_nav350", ip_nav350, "10.67.101.36");
    ROS_INFO("Got param: %s", ip_nav350.c_str());
    agv::comtcp::nav350::ComNav350 comnav350(ip_nav350);
    ros::Rate r(80.0);

    /*populate the LaserScan message*/
    ros::Time scan_time;
    sensor_msgs::LaserScan scan;
    geometry_msgs::PoseStamped pose;
    pose.header.frame_id = "localization_laser_frame";

    scan.header.frame_id = "base_laser";
    scan.angle_min = -M_PI/2;
    scan.angle_max = M_PI/2;
    scan.angle_increment = angular_resolution * M_PI / 180.0; //in rads
    scan.scan_time = (1 / laser_frequency);
    scan.time_increment = (1 / laser_frequency) / (num_readings);
    scan.range_min = 0.5;
    scan.range_max = 250.0;

    while(n.ok())
    {
        ros::spinOnce();
        scan_time = ros::Time::now();
        scan.header.stamp = scan_time;
        ++scan.header.seq;

        pose.header.stamp = scan_time;
        //++pose.header.seq;

        try
        {
            agv::comtcp::nav350::NavPositionData data_laser;
            data_laser = comnav350.get_position_data_no_disconnect(5000,1,true, false);
            scan.ranges.resize(num_readings);
            if(data_laser.contorno.size() == 0){
                ROS_INFO("No data recieving...");
            }
            else{
                for(unsigned int i = 0; i < num_readings; ++i)
                {
					if(data_laser.contorno[i].angulo > 90000 && data_laser.contorno[i].angulo < 270000){
                    	scan.ranges[i] = data_laser.contorno[i].distancia / 1000.0; //distances in mm
                    }
                }
            }

            pose.pose.position.x = data_laser.datos_pose.pose.pos_x / 1000.0;
            pose.pose.position.y = data_laser.datos_pose.pose.pos_y / 1000.0;
            pose.pose.orientation = tf::createQuaternionMsgFromYaw(data_laser.datos_pose.pose.orientacion_mgrad/1000.0 * M_PI/180.0);

            scan_pub.publish(scan);
            position_pub.publish(pose);
        }
        catch (const std::exception& ex)
        {
            ROS_ERROR("An exception ocurred trying to recieve data from \"NAV350\". %s.", ex.what());
        }

        r.sleep();
    }
}