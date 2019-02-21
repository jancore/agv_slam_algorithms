#ifndef GETBEAMS_H
#define GETBEAMS_H

#include "stateimage.h"
#include "udpstateimage.h"
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <unistd.h>
#include <sys/un.h>
#include <stdexcept>
#include <vector>

int openUdpConnection(int port);

void readSocket(const int& receiverSocket, char** receiveBuffer);

void setLaserParams(const int& receiverSocket, float& angle_min, float& angle_max, float& angle_increment, float scan_time, float& time_increment);

void getBeams(const int& receiverSocket, std::vector<float>& scans);

int getBeamCount(RSL400::PBeamDescription pBeamDesc);

#endif