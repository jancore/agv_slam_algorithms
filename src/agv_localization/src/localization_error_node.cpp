#include <ros/ros.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/PoseStamped.h>
#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>
#include <fstream>
#include "agv_localization/amcl_listener.h"
#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>

using namespace sensor_msgs;
using namespace message_filters;

int main(int argc, char** argv)
{
    std::ofstream file;
    ros::init(argc, argv, "localization_error_node");
    ros::NodeHandle n;

    Amcl_listener amcl_pose_listener;

    message_filters::Subscriber<geometry_msgs::PoseWithCovarianceStamped> sub_amcl_pose(n, "amcl_pose", 1);
    message_filters::Subscriber<geometry_msgs::PoseStamped> sub_nav350_pose(n, "nav350_position", 1);
    //typedef sync_policies::ApproximateTime<geometry_msgs::PoseWithCovarianceStamped, geometry_msgs::PoseStamped> MySyncPolicy;
    // ApproximateTime takes a queue size as its constructor argument, hence MySyncPolicy(10)
    //Synchronizer<MySyncPolicy> sync(MySyncPolicy(10), sub_amcl_pose, sub_nav350_pose);
    TimeSynchronizer<geometry_msgs::PoseWithCovarianceStamped, geometry_msgs::PoseStamped> sync(sub_amcl_pose, sub_nav350_pose, 10);
    sync.registerCallback(boost::bind(&Amcl_listener::Callback, boost::ref(amcl_pose_listener), _1, _2));

    tf::TransformListener listener(ros::Duration(10));
    geometry_msgs::PoseStamped initial_pose, final_pose;
    geometry_msgs::PoseWithCovarianceStamped amcl_pose;
    tf::Quaternion q_aux;
    double roll_n, pitch_n, yaw_n;
    double roll_a, pitch_a, yaw_a;
    double epsilon = 1.0;
    double x_pre = 0;
    double y_pre = 0;
    double th_pre = 0;

    ros::Rate r(10.0);

    try
    {
        file.open("/home/smarlogy/Errors/position_error.csv");
        file << "NAV350 pose, , , , AMCL pose, , , , abs. difference, , , , \n";
        file << "n_x, n_y, n_th, t_n, a_x, a_y, a_th, t_a, DELTA_x, DELTA_y, DELTA_th, DELTA_t, \n";
    }
    catch (const std::exception& ex)
    {
        ROS_ERROR("The file could not be open. %s.", ex.what());
    }
    

    while(n.ok())
    {
        ros::spinOnce();
        
        try
        {
            geometry_msgs::PoseStamped aux_pose;
            initial_pose = amcl_pose_listener.Getnav350pose();
            // initial_pose.header.frame_id = "base_laser";
            // listener.transformPose("base_link", initial_pose, aux_pose);
            // initial_pose = aux_pose;
            // initial_pose.header.frame_id = "localization_laser_frame";
            listener.transformPose("map", initial_pose, aux_pose);
            final_pose = aux_pose;
        }
        catch (const std::exception& ex)
        {
            ROS_ERROR("An exception ocurred trying to TRANSFORM POSITION from \"NAV350\". %s.", ex.what());
        }
        
        amcl_pose = amcl_pose_listener.Getamclpose();

        tf::quaternionMsgToTF(final_pose.pose.orientation, q_aux);
        tf::Matrix3x3 m_n(q_aux);
        tf::quaternionMsgToTF(amcl_pose.pose.pose.orientation, q_aux);
        tf::Matrix3x3 m_a(q_aux);
        m_n.getRPY(roll_n, pitch_n, yaw_n);
        m_a.getRPY(roll_a, pitch_a, yaw_a); 

        ROS_INFO("NAV350_pose: (%.2f, %.2f, %.2f), AMCL_POSE: (%.2f, %.2f, %.2f), ABS(Difference): (%.2f, %.2f. %.2f)",
            final_pose.pose.position.x , final_pose.pose.position.y, yaw_n,
            amcl_pose.pose.pose.position.x, amcl_pose.pose.pose.position.y, yaw_a,
            std::abs(final_pose.pose.position.x - amcl_pose.pose.pose.position.x),
            std::abs(final_pose.pose.position.y - amcl_pose.pose.pose.position.y),
            std::abs(yaw_n - yaw_a)
        );

        if(file.is_open() && amcl_pose.pose.covariance[0] < epsilon
                          && amcl_pose.pose.covariance[7] < epsilon
                          && amcl_pose.pose.covariance[35] < epsilon)
        {
            if(final_pose.pose.position.x != x_pre || final_pose.pose.position.y != y_pre || yaw_n != th_pre){
                file << final_pose.pose.position.x << ", " << final_pose.pose.position.y << ", " << yaw_n << ", " << final_pose.header.stamp.sec << ", ";
                file << amcl_pose.pose.pose.position.x << ", " << amcl_pose.pose.pose.position.y << ", " << yaw_a << ", " << amcl_pose.header.stamp.sec << ", ";
                file << final_pose.pose.position.x - amcl_pose.pose.pose.position.x << ", ";
                file << final_pose.pose.position.y - amcl_pose.pose.pose.position.y << ", ";
                file << yaw_n - yaw_a << ", ";
                file << final_pose.header.stamp.sec - amcl_pose.header.stamp.sec << ", \n";

                x_pre = final_pose.pose.position.x;
                y_pre = final_pose.pose.position.y;
                th_pre = yaw_n;
            }
        }

        r.sleep();
    }

    file.close();
    return 0;
}