#include "sensor_msgs/LaserScan.h"
#include "nav_msgs/OccupancyGrid.h"
#include <tf/transform_datatypes.h>
#include "agv_localization/resampling_wheel.h"


std::vector<Agv> ParticleFilter(std::vector<Agv> particles, int num_particles, sensor_msgs::LaserScan scan, std::vector< std::vector<double> >& landmarks, double deltaX, double deltaY, double deltaYaw);

std::vector< std::vector<double> > GetLandmarks(nav_msgs::OccupancyGrid map);