#include <ros/ros.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>

class Amcl_listener
{
    public:
        Amcl_listener();
        void Callback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr& amcl_pose_listener);
        geometry_msgs::PoseWithCovarianceStamped Getamclpose();
        bool IsSameTime(unsigned int t);

    private:
        geometry_msgs::PoseWithCovarianceStamped amcl_pose;
        unsigned int time;
};