# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2/build

# Utility rule file for test-results.

# Include the progress variables for this target.
include CMakeFiles/test-results.dir/progress.make

CMakeFiles/test-results:
	/opt/ros/kinetic/share/rosunit/cmake/../scripts/summarize_results.py --nodeps ORB_SLAM2

test-results: CMakeFiles/test-results
test-results: CMakeFiles/test-results.dir/build.make

.PHONY : test-results

# Rule to build all files generated by this target.
CMakeFiles/test-results.dir/build: test-results

.PHONY : CMakeFiles/test-results.dir/build

CMakeFiles/test-results.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/test-results.dir/cmake_clean.cmake
.PHONY : CMakeFiles/test-results.dir/clean

CMakeFiles/test-results.dir/depend:
	cd /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2 /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2 /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2/build /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2/build /home/smarlogy/catkin_ws/src/ORB_SLAM2/Examples/ROS/ORB_SLAM2/build/CMakeFiles/test-results.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/test-results.dir/depend

