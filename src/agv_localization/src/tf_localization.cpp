#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <math.h>
#include <fstream>

int main(int argc, char** argv){
  ros::init(argc, argv, "global_localization_tf_publisher");
  ros::NodeHandle n;
  tf::TransformBroadcaster localization_broadcaster;

  std::string origin_file;
  n.param<std::string>("origin_file", origin_file, "/home/smarlogy/catkin_ws/origins/default.txt");
  
  std::ifstream file;
  int i = 0;
  double aux, offset_x, offset_y;
  double pose[7];

  try
    {
        file.open(origin_file);
        while(file >> aux)
        {
          pose[i] = aux;
          i++;
        }
    }
    catch (const std::exception& ex)
    {
        ROS_ERROR("The Origin File could not be open. %s.", ex.what());
    }

  ros::Rate r(10);

  file.close();

  aux = tf::getYaw(tf::Quaternion(pose[3], pose[4], pose[5], pose[6])) + M_PI + 0.0061;
  offset_x = 1.154 * cos(aux);
  offset_y = 1.154 * sin(aux);

  while(n.ok()){
    localization_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::createQuaternionFromYaw(aux),
        tf::Vector3(pose[0] + offset_x, pose[1] + offset_y, pose[2])),
        ros::Time::now(),"localization_laser_frame", "map"));
    r.sleep();
  }
}