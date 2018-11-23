#include <ros/ros.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/Pose.h>
#include "std_msgs/String.h"
#include <comunicaciones/sensores/com_nav350.h>
#include <tf/transform_listener.h>
#include <tf/transform_datatypes.h>
#include <fstream>
#include "agv_localization/amcl_listener.h"

int main(int argc, char** argv)
{
    std::ofstream file;
    ros::init(argc, argv, "localization_error_node");
    ros::NodeHandle n;
    ros::NodeHandle nh("~");
    Amcl_listener amcl_pose_listener;
    ros::Subscriber sub_amcl_pose = n.subscribe("amcl_pose", 1000, &Amcl_listener::Callback, &amcl_pose_listener);
    tf::TransformListener listener(ros::Duration(10));
    geometry_msgs::PoseStamped initial_pose, final_pose;
    geometry_msgs::PoseWithCovarianceStamped amcl_pose;
    tf::Quaternion q_aux;
    double roll_n, pitch_n, yaw_n;
    double roll_a, pitch_a, yaw_a;
    double epsilon = 1.0;
    unsigned int t_aux;

    std::string ip_nav350;

    nh.param<std::string>("ip_nav350", ip_nav350, "10.67.101.36");
    agv::comtcp::nav350::ComNav350 comnav350(ip_nav350);
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
        t_aux = amcl_pose_listener.Getamclpose().header.stamp.nsec;

        if(amcl_pose_listener.IsSameTime(t_aux)){
            try
            {
                agv::comtcp::nav350::NavPositionData data_position;
                data_position = comnav350.get_position_data_no_disconnect(5000,1,true, false);

                if(data_position.contorno.size() == 0){
                    ROS_INFO("No position data recieving...");
                }
                else{
                    initial_pose.header.seq++;
                    initial_pose.header.stamp = ros::Time();
                    initial_pose.header.frame_id = "localization_laser_frame";
                    initial_pose.pose.position.x = data_position.datos_pose.pose.pos_x / 1000.0;
                    initial_pose.pose.position.y = data_position.datos_pose.pose.pos_y / 1000.0;
                    initial_pose.pose.orientation = tf::createQuaternionMsgFromYaw(data_position.datos_pose.pose.orientacion_mgrad/1000.0 * M_PI/180.0);

                    geometry_msgs::PoseStamped aux_pose;
                    listener.transformPose("map", initial_pose, aux_pose);
                    final_pose = aux_pose;
                }
            }
            catch (const std::exception& ex)
            {
                ROS_ERROR("An exception ocurred trying to recieve POSITION from \"NAV350\". %s.", ex.what());
            }
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
                          && amcl_pose.pose.covariance[14] < epsilon)
        {
            if(amcl_pose_listener.IsSameTime(t_aux)){
                file << final_pose.pose.position.x << ", " << final_pose.pose.position.y << ", " << yaw_n << ", " << final_pose.header.stamp.sec << ", ";
                file << amcl_pose.pose.pose.position.x << ", " << amcl_pose.pose.pose.position.y << ", " << yaw_a << ", " << amcl_pose.header.stamp.sec << ", ";
                file << std::abs(final_pose.pose.position.x - amcl_pose.pose.pose.position.x) << ", ";
                file << std::abs(final_pose.pose.position.y - amcl_pose.pose.pose.position.y) << ", ";
                file << std::abs(yaw_n - yaw_a) << ", ";
                file << std::abs(final_pose.header.stamp.nsec - amcl_pose.header.stamp.nsec) << ", \n";
            }
        }

        r.sleep();
    }

    file.close();
    return 0;
}