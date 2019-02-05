#include "agv_localization/agv.h"

Agv::Agv(){}

Agv::Agv(nav_msgs::MapMetaData mapMetaData)
{   
    float r;
    map_resolution = mapMetaData.resolution;
    width_map = float(mapMetaData.width)*map_resolution;
    height_map = float(mapMetaData.height)*map_resolution;
    x_origin_map = mapMetaData.origin.position.x;
    y_origin_map = mapMetaData.origin.position.y;

    //srand(time(NULL));
    r = float(rand()) / float(RAND_MAX);
    this->x = r*width_map + x_origin_map;
    
    //srand(time(NULL));
    r = float(rand()) / float(RAND_MAX);
    this->y = r*height_map + y_origin_map;

    //srand(time(NULL));
    r = float(rand()) / float(RAND_MAX);
    this->yaw = -M_PI + 2*M_PI*r;

    this->forward_noise = 0.0;
    this->turn_noise = 0.0;
    this->sense_noise = 0.0;
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
    return exp(-pow((mu - x), 2) / pow(sigma, 2) / 2.0) / sqrt(2*M_PI*pow(sigma, 2));
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

double Agv::MeasurementProb3(sensor_msgs::LaserScan scan, std::vector<double>& landmarks, int num_landmarks)
{
    using namespace Eigen;

    int i, array_pose;
    double y_cell, x_cell;
    double Escalado = 10.0;
    Eigen::Matrix3f TF = Eigen::Matrix3f::Constant(0.0); 
    Eigen::Vector3f pose_map_frame;
    Eigen::Vector3f pose_agv_frame;
    float prob = 0.0;
    float num_readings = (scan.angle_max - scan.angle_min) / scan.angle_increment;

    TF(2,2) = 1.0;
    pose_agv_frame(2) = 1.0;
    
    for(i = 0; i < num_readings; i++)
    {
        double r = double(rand()) / double(RAND_MAX);

        pose_agv_frame(0) = (scan.ranges[i] +  this->Gaussian(0.0, this->sense_noise, r)) * cos(i * scan.angle_increment);
        pose_agv_frame(1) = (scan.ranges[i] +  this->Gaussian(0.0, this->sense_noise, r)) * sin(i * scan.angle_increment);

        TF(0,0) = cos(this->yaw);
        TF(0,1) = -sin(this->yaw);
        TF(0,2) = this->x;
        TF(1,0) = sin(this->yaw);
        TF(1,1) = cos(this->yaw);
        TF(1,2) = this->y;

        pose_map_frame = TF*pose_agv_frame;
        y_cell = (pose_map_frame(1) + x_origin_map)/map_resolution;
        x_cell = (pose_map_frame(0) + y_origin_map)/map_resolution;
        array_pose = int(x_cell + y_cell * width_map/map_resolution);
        
        if(array_pose < num_landmarks && array_pose > 0)
        //if(y_cell >= 0.0 && y_cell < width_map/map_resolution && x_cell >= 0.0 && x_cell < height_map/map_resolution)
        {            
            if(landmarks[array_pose] > 50.0)
            {
                prob++;
            }  
        }      
    }

    return prob * Escalado;
}

void Agv::Move(double deltaX, double deltaY, double deltaYaw)
{
     double r = double(rand()) / double(RAND_MAX);
     double s = sin(this->yaw + deltaYaw + this->Gaussian(0.0, this->turn_noise, r));
     double c = cos(this->yaw + deltaYaw + this->Gaussian(0.0, this->turn_noise, r));
     this->yaw = atan2(s,c);

     double x_new = this->x + deltaX + this->Gaussian(0.0, this->forward_noise, r)*cos(this->yaw);
     double y_new = this->y + deltaY + this->Gaussian(0.0, this->forward_noise, r)*sin(this->yaw);
     this->x = std::fmod(x_new,  width_map);
     this->y = std::fmod(y_new, height_map);
}