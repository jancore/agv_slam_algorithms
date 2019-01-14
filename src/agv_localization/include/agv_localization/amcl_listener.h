#include <ros/ros.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PoseArray.h>
#include <tf/transform_datatypes.h>
#include <math.h>

class Amcl_listener
{
    public:
        void Callback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& amcl_pose_listener,
                      const geometry_msgs::PoseStamped::ConstPtr& nav350_pose_listener);
        geometry_msgs::PoseWithCovarianceStamped Getamclpose();
        geometry_msgs::PoseStamped Getnav350pose();

    private:
        geometry_msgs::PoseWithCovarianceStamped amcl_pose;
        geometry_msgs::PoseStamped nav350_pose;
};

class Mrpt_listener
{
    public:
        void Callback(const geometry_msgs::PoseArray::ConstPtr& poses_listener,
                      const geometry_msgs::PoseStamped::ConstPtr& nav350_pose_listener);
        void CallbackParticleCloud(const geometry_msgs::PoseArray::ConstPtr& poses_listener);
        geometry_msgs::PoseWithCovarianceStamped GetPose();
        geometry_msgs::PoseStamped GetNav350Pose();

    private:
        geometry_msgs::PoseArray mrpt_poses;
        geometry_msgs::PoseStamped nav350_pose;
        geometry_msgs::PoseWithCovarianceStamped pose_final;
        double Mean(std::vector<double> values);
        double MeanAngle(std::vector<double> values);
        double Variance(std::vector<double> values, double mean);
};