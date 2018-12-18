#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <math.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "global_localization_tf_publisher");
  ros::NodeHandle n;

  ros::Rate r(10);

  tf::TransformBroadcaster localization_broadcaster;

  while(n.ok()){
    localization_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(tf::createQuaternionFromRPY(0.0, 0.0, M_PI-2.66)), tf::Vector3(98.25, 4.26, 0.0)),
        ros::Time::now(),"localization_laser_frame", "map"));
    r.sleep();
  }
}