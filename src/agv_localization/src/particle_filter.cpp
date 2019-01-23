#include "agv_localization/particle_filter.h"

std::vector<Agv> ParticleFilter(std::vector<Agv> particles, int num_particles, sensor_msgs::LaserScan scan, std::vector< std::vector<double> >& landmarks, double deltaX, double deltaY, double deltaYaw)
{
    int i;
    double weights[num_particles];

    for(i = 0; i < num_particles; i++)
    {
        particles[i].Move(deltaX, deltaY, deltaYaw);
    }

    for(i = 0; i < num_particles; i++)
    {
        weights[i] = particles[i].MeasurementProb(scan, landmarks, landmarks.size());
    }

    ROS_INFO("deltaYaw = %.2lf, yaw = %.2lf, weight = %.2lf", deltaYaw, particles[0].yaw,  weights[0]);

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
            landmark[1] = (i / width)*resolution + map.info.origin.position.y;
            landmarks.push_back(landmark);
        }
    }

    return landmarks;
}