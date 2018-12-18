#include <ros/ros.h>
#include <sensor_msgs/LaserScan.h>
#include "nav_msgs/MapMetaData.h"
#include <vector>

class Agv
{
    public:
        Agv();
        Agv(nav_msgs::MapMetaData mapMetaData);
        void SetPose(double new_x, double new_y, double new_yaw);
        void SetNoise(float new_forward_noise, float new_turn_noise, float new_sense_noise);
        double Gaussian(double mu, double sigma, double x);
        double MeasurementProb(sensor_msgs::LaserScan scan, std::vector< std::vector<double> >& landmarks, int num_landmarks);
        void Move(double deltaX, double deltaY, double deltaYaw);

        double x;
        double y;
        double yaw;

    private:
        float forward_noise;
        float turn_noise;
        float sense_noise;
        float map_resolution;
        float width_map;
        float height_map;
};