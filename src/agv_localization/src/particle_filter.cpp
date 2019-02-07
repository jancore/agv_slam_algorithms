#include "agv_localization/particle_filter.h"
#include <fstream>

std::vector<Agv> ParticleFilter(std::vector<Agv> particles, int num_particles, sensor_msgs::LaserScan scan, std::vector<double>& landmarks, double deltaX, double deltaY, double deltaYaw)
{
    int i;
    double weights[num_particles];

    for(i = 0; i < num_particles; i++)
    {
        particles[i].Move(deltaX, deltaY, deltaYaw);
    }

    for(i = 0; i < num_particles; i++)
    {
        weights[i] = particles[i].MeasurementProb3(scan, landmarks, landmarks.size());
        ROS_INFO("weight = %.2lf", weights[i]);
    }

   

    particles = ResamplingWheel(particles, weights, num_particles);

    return particles;
}

std::vector< std::vector<double> > GetLandmarks(nav_msgs::OccupancyGrid map)
{
    std::vector<double> landmark(2);
    std::vector< std::vector<double> > landmarks;
    int i;
    int width = map.info.width;
    int height = map.info.height;
    int map_size = width*height;
    float resolution = map.info.resolution;

    for(i = 0; i < map_size; i++)
    {
        if(map.data[i] > 0)
        {
            landmark[0] = (i % width)*resolution + map.info.origin.position.x;
            landmark[1] = (i % height)*resolution + map.info.origin.position.y;
            landmarks.push_back(landmark);
        }
    }

    return landmarks;
}

std::vector<double> GetLandmarks3(nav_msgs::OccupancyGrid map)
{
    int i;
    int width = map.info.width;
    int height = map.info.height;
    std::vector<double> landmarks(width*height);

    for(i = 0; i < width*height; i++)
    {
        landmarks[i] = double(map.data[i]);       
    }
    return landmarks;
}

double Mean(std::vector<double> values){
    unsigned int i;
    double sum = 0;
    for(i = 0; i < values.size(); i++)
    {
        sum += values[i];
    }
    return sum / double(values.size());
}

double MeanAngle(std::vector<double> values){
    std::vector<double> cosValues;
    std::vector<double> sinValues;
    unsigned int i;

    for(i = 0; i < values.size(); i++){
        cosValues.push_back(cos(values[i]));
        sinValues.push_back(sin(values[i]));
    }

    return atan2(Mean(sinValues), Mean(cosValues));
}

