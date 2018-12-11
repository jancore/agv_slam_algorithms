#include <ros/ros.h>
#include "agv_localization/particle_filter.h"
#include "agv_localization/subscribers_listener.h"
#include "geometry_msgs/Pose.h"
#include "geometry_msgs/PoseArray.h"

int main(int argc, char** argv)
{
    std::string map_topic;
    std::string scan_topic;
    std::string odom_topic;
    int num_particles;

    ros::init(argc, argv, "particle_filter_node");
    ros::NodeHandle nh;

    nh.param<std::string>("map_topic", map_topic, "map");
    nh.param<std::string>("scan_topic", scan_topic, "nav350_scan");
    nh.param<std::string>("odom_topic", odom_topic, "odom");
    nh.param<int>("num_particles", num_particles, 2000);

    MapListener mapListener;
    OdomListener odomListener;
    ScanListener scanListener;

    ros::Subscriber sub_map = nh.subscribe<nav_msgs::OccupancyGrid>(map_topic, 1000, boost::bind(&MapListener::Callback, boost::ref(mapListener), _1));
    ros::Subscriber sub_odom = nh.subscribe<nav_msgs::Odometry>(odom_topic, 1000, boost::bind(&OdomListener::Callback, boost::ref(odomListener), _1));
    ros::Subscriber sub_scan = nh.subscribe<sensor_msgs::LaserScan>(scan_topic, 1000, boost::bind(&ScanListener::Callback, boost::ref(scanListener), _1));

    ros::Publisher poses_pub = nh.advertise<geometry_msgs::PoseArray>("pf_poses",10);

    nav_msgs::OccupancyGrid map;
    nav_msgs::Odometry odom;
    sensor_msgs::LaserScan scan;
    geometry_msgs::PoseArray poses;
    geometry_msgs::Pose pose;

    std::vector< std::vector<double> > landmarks;

    poses.header.frame_id = "base_laser";

    double x_pre = 0.0;
    double y_pre = 0.0;
    double yaw_pre = 0.0;
    double deltaX, deltaY, deltaYaw;
    bool gottenLandmarks = false;

    std::vector<Agv> particles(num_particles);
    for(int i = 0; i < num_particles; i++)
    {   
        try
        {
            Agv particle(map.info);
            particle.SetNoise(0.05, 0.05, 5.0);
            particles[i] = particle;
        }
        catch (const std::exception& e)
        {
            ROS_ERROR("An error ocurred trying to create the particles. %s.", e.what());
            return 0;
        }       
    }

    ros::Rate r(10.0);    

    ROS_INFO("Particle filter initialized...");
    while(nh.ok())
    {
        ros::spinOnce();

        if(!gottenLandmarks || landmarks.size() == 0)
        {
            map = mapListener.GetDataMap();
            //std::cout << "holi";
            landmarks = GetLandmarks(map);
            gottenLandmarks = true;
        }

    //ROS_INFO("%d", int(landmarks.size()));
        scan = scanListener.GetDataScan();
        odom = odomListener.GetDataOdom();
        deltaX = odom.pose.pose.position.x - x_pre;
        deltaY = odom.pose.pose.position.y - y_pre;
        deltaYaw = tf::getYaw(odom.pose.pose.orientation) - yaw_pre;

        particles = ParticleFilter(particles, num_particles, scan, landmarks, deltaX, deltaY, deltaYaw);
        //ROS_INFO("deltaYaw = %.2lf, w = %.2lf", deltaYaw, particles[0].yaw);

        x_pre = odom.pose.pose.position.x;
        y_pre = odom.pose.pose.position.y;
        yaw_pre = tf::getYaw(odom.pose.pose.orientation);

        poses.poses.clear();
        for(int i = 0; i < num_particles; i++)
        {
            pose.position.x = particles[i].x;
            pose.position.y = particles[i].y;
            pose.orientation = tf::createQuaternionMsgFromYaw(particles[i].yaw);
            poses.poses.push_back(pose);
        }

        poses.header.seq++;
        poses.header.stamp = ros::Time::now();

        poses_pub.publish(poses);
        r.sleep();
    }

    return 0;
}