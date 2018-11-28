#include <ros/ros.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/PoseStamped.h>

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