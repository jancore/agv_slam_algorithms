#include <ros/ros.h>
#include <tf/transform_broadcaster.h>

int main(int argc, char** argv){
  ros::init(argc, argv, "agv_tf_publisher");
  ros::NodeHandle n;

  ros::Rate r(10);

  tf::TransformBroadcaster laser_broadcaster;

  while(n.ok()){
    laser_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(tf::createQuaternionFromRPY(0.0, 0.0, M_PI)), tf::Vector3(-1.154, 0.0, 2.650)),
        ros::Time::now(),"base_link", "base_laser"));
    r.sleep();
  }
}