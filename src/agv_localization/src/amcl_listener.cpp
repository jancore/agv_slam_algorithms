#include "agv_localization/amcl_listener.h"

Amcl_listener::Amcl_listener(){
    time = 0;
}

void Amcl_listener::Callback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& amcl_pose_listener){
    amcl_pose.header.seq = amcl_pose_listener->header.seq;
    amcl_pose.header.frame_id = amcl_pose_listener->header.frame_id;
    amcl_pose.header.stamp = amcl_pose_listener->header.stamp;

    amcl_pose.pose.covariance = amcl_pose_listener->pose.covariance;
    amcl_pose.pose.pose.position.x = amcl_pose_listener->pose.pose.position.x;
    amcl_pose.pose.pose.position.y = amcl_pose_listener->pose.pose.position.y;
    amcl_pose.pose.pose.position.z = amcl_pose_listener->pose.pose.position.z;

    amcl_pose.pose.pose.orientation.x = amcl_pose_listener->pose.pose.orientation.x;
    amcl_pose.pose.pose.orientation.y = amcl_pose_listener->pose.pose.orientation.y;
    amcl_pose.pose.pose.orientation.z = amcl_pose_listener->pose.pose.orientation.z;
    amcl_pose.pose.pose.orientation.w = amcl_pose_listener->pose.pose.orientation.w;

    time = amcl_pose.header.stamp.nsec;
}

geometry_msgs::PoseWithCovarianceStamped Amcl_listener::Getamclpose(){
    return amcl_pose;
}

bool Amcl_listener::IsSameTime(unsigned int t){
    return time == t;
}