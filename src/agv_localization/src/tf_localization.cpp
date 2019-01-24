#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <math.h>
#include <fstream>

int main(int argc, char** argv){
  ros::init(argc, argv, "global_localization_tf_publisher");
  ros::NodeHandle n;
  tf::TransformBroadcaster localization_broadcaster;

  std::string origin_file;
  n.param<std::string>("origin_file", origin_file, "/home/smarlogy/catkin_ws/origins/defaaault.txt");
  
  std::ifstream file;
  int i, j;
  double aux, offset_x, offset_y;
  double pose[2][7];

  try
    {
        i = 0;
        std::string line;
        file.open(origin_file);
        while(std::getline(file, line))
        {
          j = 0;
          std::istringstream iss(line);
          while(iss >> aux)
          {
            pose[i][j] = aux;
            j++;
          }
          i++;
        }
    }
    catch (const std::exception& ex)
    {
        ROS_ERROR("The Origin File could not be open. %s.", ex.what());
    }

  ros::Rate r(10);

  file.close();

  aux = tf::getYaw(tf::Quaternion(pose[0][3], pose[0][4], pose[0][5], pose[0][6])) + M_PI + 0.0061;
  offset_x = 1.154 * cos(aux);
  offset_y = 1.154 * sin(aux);

  while(n.ok()){
    localization_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::createQuaternionFromYaw(aux),
        tf::Vector3(pose[0][0] + offset_x, pose[0][1] + offset_y, pose[0][2])),
        ros::Time::now(),"origin_map", "map"));

    localization_broadcaster.sendTransform(
      tf::StampedTransform(
        tf::Transform(tf::Quaternion(pose[1][3], pose[1][4], pose[1][5], pose[1][6]),
        tf::Vector3(pose[1][0], pose[1][1], pose[1][2])),
        ros::Time::now(),"origin_position", "origin_map"));

    r.sleep();
  }
}