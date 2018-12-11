#include "agv_localization/subscribers_listener.h"

void MapListener::Callback(const nav_msgs::OccupancyGrid::ConstPtr& mapListener){
    map = *mapListener;
}

nav_msgs::OccupancyGrid MapListener::GetDataMap(){
    return map;
}

void OdomListener::Callback(const nav_msgs::Odometry::ConstPtr& odomListener){
    odom = *odomListener;
}

nav_msgs::Odometry OdomListener::GetDataOdom(){
    return odom;
}

void ScanListener::Callback(const sensor_msgs::LaserScan::ConstPtr& scanListener){
    scan = *scanListener;
}

sensor_msgs::LaserScan ScanListener::GetDataScan(){
    return scan;
}