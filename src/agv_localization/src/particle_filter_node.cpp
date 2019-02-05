#include <ros/ros.h>
#include "agv_localization/particle_filter.h"
#include "agv_localization/subscribers_listener.h"
#include "geometry_msgs/Pose.h"
#include "geometry_msgs/PoseArray.h"
#include <tf/transform_broadcaster.h>
#include <tf/transform_listener.h>

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
    nh.param<int>("num_particles", num_particles, 10);

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
    geometry_msgs::PoseStamped final_pose;

    tf::TransformListener listener(ros::Duration(10));
    tf::TransformBroadcaster pf_broadcaster;

    //std::vector< std::vector<double> > landmarks;
    std::vector<double> landmarks;

    poses.header.frame_id = "map";

    double x_pre = 0.0;
    double y_pre = 0.0;
    double yaw_pre = 0.0;
    double deltaX, deltaY, deltaYaw, dist;
    double dist_update = 0.20; 
    double yaw_update = 0.26;
    std::vector<double> x_base_link, y_base_link, yaw_base_link;

    std::vector<Agv> particles(num_particles);

    ros::Rate r(0.5);    

    while(nh.ok())
    {
        ros::spinOnce();

        if(landmarks.size() == 0)
        {
            map = mapListener.GetDataMap();
            landmarks = GetLandmarks3(map);
            srand(time(NULL));

            for(int i = 0; i < num_particles; i++)
            {   
                try
                {
                    Agv particle(map.info);
                    particle.SetNoise(0.05, 0.05, 5.0);
                    particles[i] = particle;

                //ROS_INFO("x = %.2lf, y = %.2lf, yaw = %.2lf", particles[i].x, particles[i].y, particles[i].yaw);
                }
                catch (const std::exception& e)
                {
                    ROS_ERROR("An error ocurred trying to create the particles. %s.", e.what());
                    return 0;
                }       
            }
            //sub_map.shutdown();
            ROS_INFO("Particle filter initialized...");
        }

        //ROS_INFO("%d", int(landmarks.size()));
        scan = scanListener.GetDataScan();
        odom = odomListener.GetDataOdom();
        pf_broadcaster.sendTransform(
            tf::StampedTransform(
            tf::Transform(tf::Quaternion(odom.pose.pose.orientation.x, odom.pose.pose.orientation.y, odom.pose.pose.orientation.z, odom.pose.pose.orientation.w),
            tf::Vector3(odom.pose.pose.position.x, odom.pose.pose.position.y, odom.pose.pose.position.z)),
            ros::Time::now(),"map", "odom"));

        deltaX = odom.pose.pose.position.x - x_pre;
        deltaY = odom.pose.pose.position.y - y_pre;
        if(odom.pose.pose.orientation.x == 0 && odom.pose.pose.orientation.y == 0 && odom.pose.pose.orientation.z == 0 && odom.pose.pose.orientation.w == 0)
        {
            odom.pose.pose.orientation.w = 1;
            deltaYaw = tf::getYaw(odom.pose.pose.orientation) - yaw_pre;
        }
        else
        {
            deltaYaw = tf::getYaw(odom.pose.pose.orientation) - yaw_pre;
        }
        
        dist = sqrt(pow(deltaX,2) + pow(deltaY,2));

        if(abs(dist) > dist_update || abs(deltaYaw) > yaw_update)
        {
            particles = ParticleFilter(particles, num_particles, scan, landmarks, deltaX, deltaY, deltaYaw);

            x_pre = odom.pose.pose.position.x;
            y_pre = odom.pose.pose.position.y;
            yaw_pre = tf::getYaw(odom.pose.pose.orientation);
        }

        poses.poses.clear();
        for(int i = 0; i < num_particles; i++)
        {
            pose.position.x = particles[i].x;
            x_base_link.push_back(particles[i].x);
            pose.position.y = particles[i].y;
            y_base_link.push_back(particles[i].y);
            pose.orientation = tf::createQuaternionMsgFromYaw(particles[i].yaw);
            yaw_base_link.push_back(particles[i].yaw);
            poses.poses.push_back(pose);
        }

        poses.header.seq++;
        poses.header.stamp = ros::Time::now();

        poses_pub.publish(poses);

        // try
        // {
        //     geometry_msgs::PoseStamped aux_pose;
        //     geometry_msgs::PoseStamped initial_pose;
        //     initial_pose.header.frame_id = "map";
        //     initial_pose.pose.position.x = Mean(x_base_link);
        //     initial_pose.pose.position.y = Mean(y_base_link);
        //     initial_pose.pose.orientation = tf::createQuaternionMsgFromYaw(MeanAngle(yaw_base_link));
        //     listener.transformPose("odom", initial_pose, aux_pose);
        //     final_pose = aux_pose;
        // }
        // catch (const std::exception& ex)
        // {
        //     ROS_ERROR("An exception ocurred trying to TRANSFORM ESTIMATED POSITION. %s.", ex.what());
        // }

        // pf_broadcaster.sendTransform(
        //     tf::StampedTransform(
        //     tf::Transform(tf::createQuaternionFromYaw(MeanAngle(yaw_base_link)),
        //     tf::Vector3(Mean(x_base_link), Mean(y_base_link), 0.0)),
        //     ros::Time::now(),"map", "base_link"));

        r.sleep();
    }

    return 0;
}