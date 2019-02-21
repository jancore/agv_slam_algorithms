#include <ros/ros.h>
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include "geometry_msgs/PoseStamped.h"
#include "geometry_msgs/PoseArray.h"
#include "agv_localization/amcl_listener.h"
#include "agv_localization/send_position.h"
#include <tf/transform_listener.h>

#define RAD2DEG 180.0/M_PI

int main(int argc, char** argv)
{
    ros::init(argc, argv, "send_position_node");
    ros::NodeHandle n;
    Mrpt_listener estimated_pose_listener;
    geometry_msgs::PoseWithCovarianceStamped estimated_pose;
    geometry_msgs::PoseStamped initial_pose, final_pose;
    int x_mm, y_mm, error_mm;
    int yaw_mdeg = 0;
    std::string mapfile;

    tf::TransformListener listener(ros::Duration(10));
    ros::Subscriber poses_sub = n.subscribe<geometry_msgs::PoseArray>("particlecloud", 10, boost::bind(&Mrpt_listener::CallbackParticleCloud, boost::ref(estimated_pose_listener), _1));

    n.getParam("/mrpt_localization_node/map_file", mapfile);
    SendPosition setPosition("10.67.101.203", 8900);
    ros::Rate r(20);

    while(n.ok())
    {
        ros::spinOnce();

        estimated_pose = estimated_pose_listener.GetPose();

        try
        {
            geometry_msgs::PoseStamped aux_pose;
            initial_pose.header = estimated_pose.header;
            initial_pose.pose = estimated_pose.pose.pose;
            listener.transformPose("origin_map", initial_pose, aux_pose);
			initial_pose = aux_pose;
            listener.transformPose("origin_position", initial_pose, aux_pose);
            final_pose = aux_pose;
        }
        catch (const std::exception& ex)
        {
            final_pose.pose.position.x = -11.001;
            final_pose.pose.position.y = -11.001;
            final_pose.pose.orientation.x = 0.0;
            final_pose.pose.orientation.y = 0.0;
            final_pose.pose.orientation.z = sqrt(2.0)*sin(1.001/RAD2DEG)*sin(1.001/RAD2DEG)/2.0;
            final_pose.pose.orientation.w = -sqrt(2.0)/(2.0*sin(1.001/RAD2DEG)); 
            ROS_ERROR("An exception ocurred trying to TRANSFORM ESTIMATED POSITION. %s.", ex.what());
        }

        x_mm = int(final_pose.pose.position.x * 1000.0) + 10000;
        y_mm = int(final_pose.pose.position.y * 1000.0) + 10000;
        yaw_mdeg = int((tf::getYaw(final_pose.pose.orientation) < 0.0 ? 2.0*M_PI + tf::getYaw(final_pose.pose.orientation) : tf::getYaw(final_pose.pose.orientation)) * 1000.0 * RAD2DEG)  + 10000;
        error_mm = int(sqrt(estimated_pose.pose.covariance[0]*1000 + estimated_pose.pose.covariance[6]*1000));

        if(!mapfileExist(mapfile))
        {
            x_mm = -1000.0;
            y_mm = -1000.0;
            yaw_mdeg = -1000.0;
        }

        try
        {
            setPosition.Envia_posicion(x_mm, y_mm, yaw_mdeg, error_mm, 1000);
        }
        catch (const std::exception& e)
        {
            ROS_ERROR("Cannot send position to AGV. %s.", e.what());
        }

        r.sleep();
    }

    return 0;
}