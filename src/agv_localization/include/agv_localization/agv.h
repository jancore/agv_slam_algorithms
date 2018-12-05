#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
class Agv
{
    public:
        Agv();
        void SetPose(double new_x, double new_y, double new_yaw);
        void SetNoise(float new_forward_noise, float new_turn_noise, float new_sense_noise);
        double Gaussian(double mu, double sigma, double x);
        double MeasurementProb(sensro_msgs::LaserScan scan);

        double x;
        double y;
        double yaw;

    private:
        float forward_noise;
        float turn_noise;
        float sense_noise;
};