# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "dvo_slam: 1 messages, 0 services")

set(MSG_I_FLAGS "-Idvo_slam:/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(dvo_slam_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" NAME_WE)
add_custom_target(_dvo_slam_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "dvo_slam" "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" "geometry_msgs/Quaternion:geometry_msgs/PoseStamped:geometry_msgs/Pose:std_msgs/Header:geometry_msgs/Point"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(dvo_slam
  "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dvo_slam
)

### Generating Services

### Generating Module File
_generate_module_cpp(dvo_slam
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dvo_slam
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(dvo_slam_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(dvo_slam_generate_messages dvo_slam_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" NAME_WE)
add_dependencies(dvo_slam_generate_messages_cpp _dvo_slam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dvo_slam_gencpp)
add_dependencies(dvo_slam_gencpp dvo_slam_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dvo_slam_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(dvo_slam
  "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dvo_slam
)

### Generating Services

### Generating Module File
_generate_module_eus(dvo_slam
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dvo_slam
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(dvo_slam_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(dvo_slam_generate_messages dvo_slam_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" NAME_WE)
add_dependencies(dvo_slam_generate_messages_eus _dvo_slam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dvo_slam_geneus)
add_dependencies(dvo_slam_geneus dvo_slam_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dvo_slam_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(dvo_slam
  "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dvo_slam
)

### Generating Services

### Generating Module File
_generate_module_lisp(dvo_slam
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dvo_slam
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(dvo_slam_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(dvo_slam_generate_messages dvo_slam_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" NAME_WE)
add_dependencies(dvo_slam_generate_messages_lisp _dvo_slam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dvo_slam_genlisp)
add_dependencies(dvo_slam_genlisp dvo_slam_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dvo_slam_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(dvo_slam
  "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dvo_slam
)

### Generating Services

### Generating Module File
_generate_module_nodejs(dvo_slam
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dvo_slam
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(dvo_slam_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(dvo_slam_generate_messages dvo_slam_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" NAME_WE)
add_dependencies(dvo_slam_generate_messages_nodejs _dvo_slam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dvo_slam_gennodejs)
add_dependencies(dvo_slam_gennodejs dvo_slam_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dvo_slam_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(dvo_slam
  "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dvo_slam
)

### Generating Services

### Generating Module File
_generate_module_py(dvo_slam
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dvo_slam
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(dvo_slam_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(dvo_slam_generate_messages dvo_slam_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/smarlogy/catkin_ws/src/dvo_slam/dvo_slam/msg/PoseStampedArray.msg" NAME_WE)
add_dependencies(dvo_slam_generate_messages_py _dvo_slam_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(dvo_slam_genpy)
add_dependencies(dvo_slam_genpy dvo_slam_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS dvo_slam_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dvo_slam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/dvo_slam
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(dvo_slam_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dvo_slam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/dvo_slam
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(dvo_slam_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dvo_slam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/dvo_slam
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(dvo_slam_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dvo_slam)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/dvo_slam
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(dvo_slam_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dvo_slam)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dvo_slam\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/dvo_slam
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(dvo_slam_generate_messages_py geometry_msgs_generate_messages_py)
endif()
