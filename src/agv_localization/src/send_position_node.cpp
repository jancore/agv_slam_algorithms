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
    double x_mm, y_mm, yaw_mdeg;

    tf::TransformListener listener(ros::Duration(10));
    ros::Subscriber poses_sub = n.subscribe<geometry_msgs::PoseArray>("particlecloud", 10, boost::bind(&Mrpt_listener::CallbackParticleCloud, boost::ref(estimated_pose_listener), _1));

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
            listener.transformPose("localization_laser_frame", initial_pose, aux_pose);
            final_pose = aux_pose;
        }
        catch (const std::exception& ex)
        {
            ROS_ERROR("An exception ocurred trying to TRANSFORM ESTIMATED POSITION. %s.", ex.what());
        }

        x_mm = int(final_pose.pose.position.x * 1000.0);
        y_mm = int(final_pose.pose.position.y * 1000.0);
        ROS_INFO("x = %.3lf y = %.3lf z = %.3lf w = %.3lf", final_pose.pose.orientation.x, final_pose.pose.orientation.y, final_pose.pose.orientation.z, final_pose.pose.orientation.w);
        yaw_mdeg = int((tf::getYaw(final_pose.pose.orientation) + M_PI) * 1000.0 * RAD2DEG);

        try
        {
            setPosition.Envia_posicion(x_mm, y_mm, yaw_mdeg, 1000);
        }
        catch (const std::exception& e)
        {
            ROS_ERROR("Cannot send position to AGV. %s.", e.what());
        }

        r.sleep();
    }

    return 0;
}