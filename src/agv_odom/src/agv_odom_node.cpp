#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include "lectura_odometria.h"
#include <comunicaciones/sensores/com_nav350.h>
#include "math.h"
#include "std_msgs/String.h"

int main(int argc, char** argv){
  ros::init(argc, argv, "odom_agv_publisher");
  std::string ip_address;
  agv::Punto2d velocity_agv;

  ros::NodeHandle n;
  ros::Publisher odom_pub = n.advertise<nav_msgs::Odometry>("odom", 1 /*50*/);
  tf::TransformBroadcaster odom_broadcaster;
  n.param<std::string>("ip_address", ip_address, "10.67.101.203");
  LecturaOdometria odom_agv(ip_address, 8900);

  double x = 0.0;
  double y = 0.0;
  double th = 0.0;

  double vx = 0.0;
  double vy = 0.0;
  double vth = 0.0;

  ros::Time current_time, last_time;
  current_time = ros::Time::now();
  last_time = ros::Time::now();

  ros::Rate r(80.0);
  while(n.ok()){

    ros::spinOnce();               // check for incoming messages
    current_time = ros::Time::now();
    try
    {
      velocity_agv = odom_agv.get_vector_movimiento(500.0);
      //ROS_INFO("vx = %lf, w = %lf", velocity_agv.x, velocity_agv.y);
    }
    catch (const std::exception& e)
    {
      ROS_ERROR("Cannot get velocity. %s.", e.what());
    }
    
    vx = velocity_agv.x;
    vy = 0.0;
    vth = velocity_agv.y; // velocity_agv.y actually is angular velocity in axis z of robot frame.

    //compute odometry in a typical way given the velocities of the robot
    double dt = (current_time - last_time).toSec();
    double delta_x = (vx * cos(th) - vy * sin(th)) * dt;
    double delta_y = (vx * sin(th) + vy * cos(th)) * dt;
    double delta_th = vth * dt;

    x += delta_x;
    y += delta_y;
    th += delta_th;

    //since all odometry is 6DOF we'll need a quaternion created from yaw
    geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(th);

    //first, we'll publish the transform over tf
    geometry_msgs::TransformStamped odom_trans;
    odom_trans.header.stamp = current_time;
    odom_trans.header.frame_id = "odom";
    odom_trans.child_frame_id = "base_link";

    odom_trans.transform.translation.x = x;
    odom_trans.transform.translation.y = y;
    odom_trans.transform.translation.z = 0.0;
    odom_trans.transform.rotation = odom_quat;

    //send the transform
    odom_broadcaster.sendTransform(odom_trans);

    //next, we'll publish the odometry message over ROS
    nav_msgs::Odometry odom;
    odom.header.stamp = current_time;
    odom.header.frame_id = "odom";

    //set the position
    odom.pose.pose.position.x = x;
    odom.pose.pose.position.y = y;
    odom.pose.pose.position.z = 0.0;
    odom.pose.pose.orientation = odom_quat;

    //set the velocity
    odom.child_frame_id = "base_link";
    odom.twist.twist.linear.x = vx;
    odom.twist.twist.linear.y = vy;
    odom.twist.twist.angular.z = vth;

    odom.pose.covariance[0] = 0.0;
    odom.pose.covariance[7] = 0.0;
    odom.pose.covariance[14] = 0.0;
    odom.pose.covariance[21] = 0.0;
    odom.pose.covariance[28] = 0.0;
    odom.pose.covariance[35] = 0.0;
    
    //publish the message
    odom_pub.publish(odom);

    last_time = current_time;
    r.sleep();
  }
}