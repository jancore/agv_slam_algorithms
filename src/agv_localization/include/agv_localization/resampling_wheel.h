#include "agv_localization/agv.h"
#include <ctime>

std::vector<Agv> ResamplingWheel(std::vector<Agv> particles, double weights[], int num_particles);

double MaxValue(double values[], int size);