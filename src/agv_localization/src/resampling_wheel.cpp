#include "agv_localization/resampling_wheel.h"

std::vector<Agv> ResamplingWheel(std::vector<Agv> particles, double weights[], int num_particles)
{
    //std::srand(std::time(nullptr));
    std::vector<Agv> p(num_particles);
    int i;
    float beta = 0.0;
    float r = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
    int index = int(r*num_particles);
    double maxWeight = MaxValue(weights, num_particles);

    for(i = 0; i < num_particles; i++)
    {
        r = static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
        beta += r * 2.0 * maxWeight;
        while (beta > weights[i])
        {
            beta -= weights[index];
            index = (index + 1) % num_particles;
        }
        p[i] = particles[index];
        
    }

    return p;
}

double MaxValue(double values[], int size)
{
    int i;
    double maxValue = 0.0;
    for(i=0; i < size; i++)
    {
        if(maxValue < values[i])
        {
            maxValue = values[i];
        }
    }
    return maxValue;
}