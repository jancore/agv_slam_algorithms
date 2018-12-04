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
        tf::Transform(tf::Quaternion(tf::createQuaternionFromRPY(0.0, 0.0, 0.94 + M_PI)), tf::Vector3((57.34 + 0.98), (94.18 + 0.46), 0.0)),
        ros::Time::now(),"map", "localization_laser_frame"));
    r.sleep();
  }
}