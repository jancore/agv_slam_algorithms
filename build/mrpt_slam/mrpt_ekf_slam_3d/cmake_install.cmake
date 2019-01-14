# Install script for directory: /home/smarlogy/catkin_ws/src/mrpt_slam/mrpt_ekf_slam_3d

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/smarlogy/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/smarlogy/catkin_ws/build/mrpt_slam/mrpt_ekf_slam_3d/catkin_generated/installspace/mrpt_ekf_slam_3d.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mrpt_ekf_slam_3d/cmake" TYPE FILE FILES
    "/home/smarlogy/catkin_ws/build/mrpt_slam/mrpt_ekf_slam_3d/catkin_generated/installspace/mrpt_ekf_slam_3dConfig.cmake"
    "/home/smarlogy/catkin_ws/build/mrpt_slam/mrpt_ekf_slam_3d/catkin_generated/installspace/mrpt_ekf_slam_3dConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mrpt_ekf_slam_3d" TYPE FILE FILES "/home/smarlogy/catkin_ws/src/mrpt_slam/mrpt_ekf_slam_3d/package.xml")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d" TYPE EXECUTABLE FILES "/home/smarlogy/catkin_ws/devel/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d"
         OLD_RPATH "/opt/ros/kinetic/lib/x86_64-linux-gnu:/home/smarlogy/catkin_ws/devel/lib:/opt/ros/kinetic/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/mrpt_ekf_slam_3d/mrpt_ekf_slam_3d")
    endif()
  endif()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/mrpt_ekf_slam_3d" TYPE DIRECTORY FILES
    "/home/smarlogy/catkin_ws/src/mrpt_slam/mrpt_ekf_slam_3d/launch"
    "/home/smarlogy/catkin_ws/src/mrpt_slam/mrpt_ekf_slam_3d/tutorial"
    )
endif()

