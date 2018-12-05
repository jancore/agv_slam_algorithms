#include <ros/ros.h>
#include <nav_msgs/OccupancyGrid.h>

class MapListener
{
    public:
        void Callback(const nav_msgs::OccupancyGrid::ConstPtr& mapListener);
        nav_msgs::OccupancyGrid GetDataMap();

    private:
        nav_msgs::OccupancyGrid map;
};