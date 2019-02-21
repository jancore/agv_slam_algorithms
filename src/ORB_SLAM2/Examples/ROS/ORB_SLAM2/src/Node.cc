#include "Node.h"

#include <iostream>

Node::Node (ORB_SLAM2::System* pSLAM, ros::NodeHandle &node_handle, image_transport::ImageTransport &image_transport) {
  name_of_node_ = ros::this_node::getName();
  orb_slam_ = pSLAM;
  node_handle_ = node_handle;

  InitParameters ();

  rendered_image_publisher_ = image_transport.advertise (name_of_node_+"/debug_image", 1);
  if (publish_pointcloud_param_) {
    map_points_publisher_ = node_handle_.advertise<sensor_msgs::PointCloud2> (name_of_node_+"/map_points", 1);
  }
}


Node::~Node () {

}


void Node::Update () {
  cv::Mat position = orb_slam_->GetCurrentPosition();

  if (!position.empty()) {
    PublishPositionAsTransform (position);
  }

  PublishRenderedImage (orb_slam_->DrawCurrentFrame());

  if (publish_pointcloud_param_) {
    PublishMapPoints (orb_slam_->GetAllMapPoints());
  }

  UpdateParameters ();
}


void Node::PublishMapPoints (std::vector<ORB_SLAM2::MapPoint*> map_points) {
  sensor_msgs::PointCloud2 cloud = MapPointsToPointCloud (map_points);
  map_points_publisher_.publish (cloud);
}


void Node::PublishPositionAsTransform (cv::Mat position) {
  tf::Transform transform = TransformFromMat (position);
  static tf::TransformBroadcaster tf_broadcaster;
  tf_broadcaster.sendTransform(tf::StampedTransform(transform, current_frame_time_, map_frame_id_param_, camera_frame_id_param_));
}


void Node::PublishRenderedImage (cv::Mat image) {
  std_msgs::Header header;
  header.stamp = current_frame_time_;
  header.frame_id = map_frame_id_param_;
  const sensor_msgs::ImagePtr rendered_image_msg = cv_bridge::CvImage(header, "bgr8", image).toImageMsg();
  rendered_image_publisher_.publish(rendered_image_msg);
}


tf::Transform Node::TransformFromMat (cv::Mat position_mat) {
  cv::Mat rotation(3,3,CV_32F);
  cv::Mat translation(3,1,CV_32F);

  rotation = position_mat.rowRange(0,3).colRange(0,3).t();
  translation = rotation*position_mat.rowRange(0,3).col(3);

  tf::Matrix3x3 tf_camera_rotation (rotation.at<float> (0,0), rotation.at<float> (0,1), rotation.at<float> (0,2),
                                    rotation.at<float> (1,0), rotation.at<float> (1,1), rotation.at<float> (1,2),
                                    rotation.at<float> (2,0), rotation.at<float> (2,1), rotation.at<float> (2,2)
                                   );

  tf::Vector3 tf_camera_translation (translation.at<float> (0), translation.at<float> (1), translation.at<float> (2));

  const tf::Matrix3x3 Rx (1, 0, 0,
                          0, 0, -1,
                          0, 1, 0);

  const tf::Matrix3x3 Rz (0, -1, 0,
                          1, 0, 0,
                          0, 0, 1);

  const tf::Matrix3x3 invX (-1, 0, 0,
                            0, 1, 0,
                            0, 0, 1);

  const tf::Matrix3x3 invYZ (1, 0, 0,
                            0, -1, 0,
                            0, 0, -1);

  tf_camera_rotation = Rx*tf_camera_rotation;
  tf_camera_rotation = Rz*tf_camera_rotation;
  tf_camera_translation = Rx*tf_camera_translation;
  tf_camera_translation = Rz*tf_camera_translation;

  tf_camera_rotation = invYZ*tf_camera_rotation;
  tf_camera_translation = invX*tf_camera_translation;

  return tf::Transform (tf_camera_rotation, tf_camera_translation);
}


sensor_msgs::PointCloud2 Node::MapPointsToPointCloud (std::vector<ORB_SLAM2::MapPoint*> map_points) {
  if (map_points.size() == 0) {
    std::cout << "Map point vector is empty!" << std::endl;
  }

  sensor_msgs::PointCloud2 cloud;

  const int num_channels = 3; // x y z

  cloud.header.stamp = current_frame_time_;
  cloud.header.frame_id = map_frame_id_param_;
  cloud.height = 1;
  cloud.width = map_points.size();
  cloud.is_bigendian = false;
  cloud.is_dense = true;
  cloud.point_step = num_channels * sizeof(float);
  cloud.row_step = cloud.point_step * cloud.width;
  cloud.fields.resize(num_channels);

  std::string channel_id[] = { "x", "y", "z"};
  for (int i = 0; i<num_channels; i++) {
  	cloud.fields[i].name = channel_id[i];
  	cloud.fields[i].offset = i * sizeof(float);
  	cloud.fields[i].count = 1;
  	cloud.fields[i].datatype = sensor_msgs::PointField::FLOAT32;
  }

  cloud.data.resize(cloud.row_step * cloud.height);

	unsigned char *cloud_data_ptr = &(cloud.data[0]);

  float data_array[3];
  for (unsigned int i=0; i<cloud.width; i++) {
    if (!map_points.at(i)->isBad()) {
      data_array[0] = map_points.at(i)->GetWorldPos().at<float> (2); //x. Do the transformation by just reading at the position of z instead of x
      data_array[1] = -1.0* map_points.at(i)->GetWorldPos().at<float> (0); //y. Do the transformation by just reading at the position of x instead of y
      data_array[2] = -1.0* map_points.at(i)->GetWorldPos().at<float> (1); //z. Do the transformation by just reading at the position of y instead of z
      //TODO dont hack the transformation but have a central conversion function for MapPointsToPointCloud and TransformFromMat

      memcpy(cloud_data_ptr+(i*cloud.point_step), data_array, 3*sizeof(float));
    }
  }

  return cloud;
}


void Node::InitParameters () {
  node_handle_.param(name_of_node_+"/publish_pointcloud", publish_pointcloud_param_, true);
  node_handle_.param(name_of_node_+"/localize_only", localize_only_param_, false);
  node_handle_.param(name_of_node_+"/reset_map", reset_map_param_, false);
  node_handle_.param<std::string>(name_of_node_+"/pointcloud_frame_id", map_frame_id_param_, "map");
  node_handle_.param<std::string>(name_of_node_+"/camera_frame_id", camera_frame_id_param_, "camera_link");
  node_handle_.param(name_of_node_+"/min_num_kf_in_map", minimum_num_of_kf_in_map_param_, 5);
  orb_slam_->SetMinimumKeyFrames (minimum_num_of_kf_in_map_param_);
}


void Node::UpdateParameters () {
  node_handle_.param(name_of_node_+"/localize_only", localize_only_param_, false);
  orb_slam_->EnableLocalizationOnly (localize_only_param_);

  node_handle_.param(name_of_node_+"/reset_map", reset_map_param_, false);
  if (reset_map_param_) {
    orb_slam_->Reset();
    node_handle_.setParam (name_of_node_+"/reset_map", false);
  }

  node_handle_.param(name_of_node_+"/min_num_kf_in_map", minimum_num_of_kf_in_map_param_, 5);
  orb_slam_->SetMinimumKeyFrames (minimum_num_of_kf_in_map_param_);
}
