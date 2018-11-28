#include "agv_localization/amcl_listener.h"

void Amcl_listener::Callback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& amcl_pose_listener,
                             const geometry_msgs::PoseStamped::ConstPtr& nav350_pose_listener){
    amcl_pose = *amcl_pose_listener;
    nav350_pose = *nav350_pose_listener;
}

geometry_msgs::PoseWithCovarianceStamped Amcl_listener::Getamclpose(){
    return amcl_pose;
}

geometry_msgs::PoseStamped Amcl_listener::Getnav350pose(){
    return nav350_pose;
}