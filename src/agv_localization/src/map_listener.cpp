#include "agv_localization/map_listener.h"

void MapListener::Callback(const nav_msgs::OccupancyGrid::ConstPtr& mapListener){
    map = *mapListener;
}

nav_msgs::OccupancyGrid GetDataMap(){
    return map;
}