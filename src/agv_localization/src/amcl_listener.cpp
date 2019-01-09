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

void Mrpt_listener::Callback(const geometry_msgs::PoseArray::ConstPtr& poses_listener,
                             const geometry_msgs::PoseStamped::ConstPtr& nav350_pose_listener){
    mrpt_poses = *poses_listener;
    nav350_pose = *nav350_pose_listener;
}

void Mrpt_listener::CallbackParticleCloud(const geometry_msgs::PoseArray::ConstPtr& poses_listener){
    mrpt_poses = *poses_listener;
}

geometry_msgs::PoseStamped Mrpt_listener::GetNav350Pose(){
    return nav350_pose;
}

geometry_msgs::PoseWithCovarianceStamped Mrpt_listener::GetPose(){
    int i;
    int size = mrpt_poses.poses.size();
    std::vector<double> array(mrpt_poses.poses.size());
    double mean;
    
    for(i = 0; i < size; i++)
    {
        array[i] = mrpt_poses.poses[i].position.x;
    }
    mean = this->Mean(array);
    this->pose_final.pose.pose.position.x = mean;
    this->pose_final.pose.covariance[0] = this->Variance(array, this->pose_final.pose.pose.position.x);

    array.clear();
    array.resize(size);
    for(i = 0; i < size; i++)
    {
        array[i] = mrpt_poses.poses[i].position.y;
    }
    mean = this->Mean(array);
    this->pose_final.pose.pose.position.y = mean;
    this->pose_final.pose.covariance[7] = this->Variance(array, this->pose_final.pose.pose.position.y);

    array.clear();
    array.resize(size);
    for(i = 0; i < size; i++)
    {
        array[i] = tf::getYaw(mrpt_poses.poses[i].orientation);
    }
    mean = this->Mean(array);
    this->pose_final.pose.pose.orientation = tf::createQuaternionMsgFromYaw(mean);
    this->pose_final.pose.covariance[35] = this->Variance(array, mean);

    this->pose_final.header.frame_id = "map";
    //this->pose_final.header.stamp = ros::Time::now();
    //this->pose_final.header.seq = mrpt_poses.header.seq;

    return this->pose_final;
}

double Mrpt_listener::Mean(std::vector<double> values){
    unsigned int i;
    double sum = 0;
    for(i = 0; i < values.size(); i++)
    {
        sum += values[i];
    }
    return sum / double(values.size());
}

double Mrpt_listener::Variance(std::vector<double> values, double mean){
    unsigned int i;
    double sum = 0;
    for(i = 0; i < values.size(); i++)
    {
        sum += pow((values[i] - mean), 2);
    }
    return sum / double(values.size());
}