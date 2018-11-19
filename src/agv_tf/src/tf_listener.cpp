#include <ros/ros.h>
#include <geometry_msgs/PointStamped.h>
#include <sensor_msgs/LaserScan.h>
#include "std_msgs/String.h"
#include <tf/transform_listener.h>
#include "math.h"


class Laser_listener
{
public:
    Laser_listener(){
        ranges = std::vector<double>();
        angle_increment = 0.0;
    }
    void Callback(const sensor_msgs::LaserScan::ConstPtr& scan){
        angle_increment = scan->angle_increment;
        ranges.resize(scan->ranges.size());
        for(unsigned int i = 0; i < scan->ranges.size(); i++){
            ranges[i] = scan->ranges[i];
        }
    }
    std::vector<double> GetRanges(){
        return ranges;
    }
    double GetAngleIncrement(){
        return angle_increment;
    } 

private:
    std::vector<double> ranges;
    double angle_increment;
};


void transformPoint(const tf::TransformListener& listener){
  //we'll create a point in the base_laser frame that we'd like to transform to the base_link frame
  ros::NodeHandle nh;
  Laser_listener laser_listener;
  ros::Subscriber sub_laser = nh.subscribe("nav350_scan", 1000, &Laser_listener::Callback, &laser_listener);
  geometry_msgs::PointStamped laser_point;

  laser_point.header.frame_id = "base_laser";

  //we'll just use the most recent transform available for our simple example
  laser_point.header.stamp = ros::Time();

  //just an arbitrary point in space
  laser_point.point.x = laser_listener.GetRanges()[0] * cos(-M_PI);
  laser_point.point.y = laser_listener.GetRanges()[0] * cos(-M_PI);
  laser_point.point.z = 0.0;

  try{
    geometry_msgs::PointStamped base_point;
    listener.transformPoint("base_link", laser_point, base_point);

    ROS_INFO("base_laser: (%.2f, %.2f. %.2f) -----> base_link: (%.2f, %.2f, %.2f) at time %.2f",
        laser_point.point.x, laser_point.point.y, laser_point.point.z,
        base_point.point.x, base_point.point.y, base_point.point.z, base_point.header.stamp.toSec());
  }
  catch(tf::TransformException& ex){
    ROS_ERROR("Received an exception trying to transform a point from \"base_laser\" to \"base_link\": %s", ex.what());
  }
}

int main(int argc, char** argv){
  ros::init(argc, argv, "robot_tf_listener");
  ros::NodeHandle n;

  tf::TransformListener listener(ros::Duration(10));

  //we'll transform a point once every second
  ros::Timer timer = n.createTimer(ros::Duration(1.0), boost::bind(&transformPoint, boost::ref(listener)));

  ros::spin();

}