#include "rsl_445xl_node/socket.h"

int openUdpConnection(int port){
    int receiverSocket;
    sockaddr_in receiverAddr;

    receiverSocket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (receiverSocket == -1) {
        throw std::runtime_error("Cannot open server socket.\n");
    }

    receiverAddr.sin_family = AF_INET;
    receiverAddr.sin_port = htons(port);
    receiverAddr.sin_addr.s_addr = htonl(INADDR_ANY);

    if (bind(receiverSocket, (struct sockaddr *) &receiverAddr, sizeof (receiverAddr)) == -1) {
        throw std::runtime_error("Cannot bind socket.\n");
        close(receiverSocket);
    }

    return receiverSocket;
}

void readSocket(const int& receiverSocket, char** receiveBuffer){
    int receiveBufferLen = 2048000;
    sockaddr_in senderAddr;
    int senderAddrSize = sizeof (senderAddr);
    *receiveBuffer = new char[receiveBufferLen];

    int received = recvfrom(receiverSocket,
            *receiveBuffer,
            receiveBufferLen,
            0,
            (struct sockaddr *) &senderAddr,
            (socklen_t *) & senderAddrSize);

    if (received == -1) {
        throw std::runtime_error("Error receiving data");
    }
}

void setLaserParams(const int& receiverSocket, float& angle_min, float& angle_max, float& angle_increment, float scan_time, float& time_increment){
    char* receiveBuffer;
    readSocket(receiverSocket, &receiveBuffer);

    RSL400::PUdpTelegramType udpTelegramType = (RSL400::PUdpTelegramType)receiveBuffer;

    if (udpTelegramType->Id == 1) {
        RSL400::PUdpExtStateImageType1 udpExtStateImageType1 = (RSL400::PUdpExtStateImageType1)receiveBuffer;
        angle_min = (udpExtStateImageType1->BeamDesc.Start/10.0 - 135.0) * M_PI/180.0;
        angle_max = (udpExtStateImageType1->BeamDesc.Stop/10.0 - 135.0) * M_PI/180.0;
        angle_increment = udpExtStateImageType1->BeamDesc.Resolution/10.0 * M_PI/180.0;
        RSL400::PBeamDescription pBeamDesc = &udpExtStateImageType1->BeamDesc;
        time_increment = scan_time / getBeamCount(pBeamDesc);
    }

    delete[] receiveBuffer;
}

void getBeams(const int& receiverSocket, std::vector<float>& scans) {

    std::vector<float> beams;
    char *receiveBuffer;
    readSocket(receiverSocket, &receiveBuffer);

    RSL400::PUdpTelegramType udpTelegramType = (RSL400::PUdpTelegramType)receiveBuffer;

    if (udpTelegramType->Id == 6) {
        RSL400::PUdpBeamPacket t3 = (RSL400::PUdpBeamPacket)receiveBuffer;
        for(int i = 0; i < sizeof(t3->Beams)/sizeof(RSL400::Beam); i++){
            beams.push_back(t3->Beams[i].Distance/1000.0);
        }
        scans = beams;
    }

    delete[] receiveBuffer;
}

int getBeamCount( RSL400::PBeamDescription pBeamDesc ) {
		if ( pBeamDesc->Start == 0 && pBeamDesc->Stop == 0 && pBeamDesc->Resolution == 0 )
        {
            return 0;
        }

        return 1 + (int)ceil((pBeamDesc->Stop - pBeamDesc->Start)/(double)pBeamDesc->Resolution);
}