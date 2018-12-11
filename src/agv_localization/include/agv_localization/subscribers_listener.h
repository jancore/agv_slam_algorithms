#include <ros/ros.h>
#include <nav_msgs/OccupancyGrid.h>
#include <nav_msgs/Odometry.h>
#include <sensor_msgs/LaserScan.h>

class MapListener
{
    public:
        void Callback(const nav_msgs::OccupancyGrid::ConstPtr& mapListener);
        nav_msgs::OccupancyGrid GetDataMap();

    private:
        nav_msgs::OccupancyGrid map;
};

class OdomListener
{
    public:
        void Callback(const nav_msgs::Odometry::ConstPtr& odomListener);
        nav_msgs::Odometry GetDataOdom();

    private:
        nav_msgs::Odometry odom;
};

class ScanListener
{
    public:
        void Callback(const sensor_msgs::LaserScan::ConstPtr& scanListener);
        sensor_msgs::LaserScan GetDataScan();

    private:
        sensor_msgs::LaserScan scan;
};