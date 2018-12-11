#include "agv_localization/agv.h"
#include "math.h"

Agv::Agv(){}

Agv::Agv(nav_msgs::MapMetaData mapMetaData)
{   
    map_resolution = mapMetaData.resolution;
    width_map = float(mapMetaData.width)*map_resolution;
    height_map = float(mapMetaData.height)*map_resolution;

    float r = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
    x = r*double(width_map);
    r = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
    y = r*double(height_map);
    r = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
    yaw = -M_PI + 2*M_PI*r;

    forward_noise = 0.0;
    turn_noise = 0.0;
    sense_noise = 0.0;
}

void Agv::SetPose(double new_x, double new_y, double new_yaw)
{
    if(new_x < 0 || new_x >= width_map)
    {
        throw "X coordinate out of bound";
    }

    if(new_y < 0 || new_y >= height_map)
    {
        throw "Y coordinate out of bound";
    }

    x = new_x;
    y = new_y;
    yaw = new_yaw;
}

void Agv::SetNoise(float new_forward_noise, float new_turn_noise, float new_sense_noise)
{
    forward_noise = new_forward_noise;
    turn_noise = new_turn_noise;
    sense_noise = new_sense_noise;
}

double Agv::Gaussian(double mu, double sigma, double x)
{
    return exp(-pow((mu - x), 2) / pow(sigma, 2)) / sqrt(2*M_PI*pow(sigma, 2));
}

double Agv::MeasurementProb(sensor_msgs::LaserScan scan, std::vector< std::vector<double> >& landmarks, int num_landmarks)
{
    int i, j;
    double dist;
    float prob = 1.0;
    float num_readings = (scan.angle_max - scan.angle_min) / scan.angle_increment;
    
    for(i = 0; i < num_landmarks; i++)
    {
        dist = sqrt(pow(this->x - landmarks[i][0], 2) + pow(this->y - landmarks[i][1], 2));
        //ROS_INFO("distancia: %.2lf", dist);
        for(j = 0; j < num_readings; j++)
        {
            prob *= this->Gaussian(dist, this->sense_noise, scan.ranges[j]);
        }
    }
    return prob;
}

void Agv::Move(float deltaX, float deltaY, float deltaYaw)
{
     this->yaw = atan2(sin(this->yaw + deltaYaw),cos(this->yaw + deltaYaw));
     this->x = this->x + deltaX;
     this->y = this->y + deltaY;
}