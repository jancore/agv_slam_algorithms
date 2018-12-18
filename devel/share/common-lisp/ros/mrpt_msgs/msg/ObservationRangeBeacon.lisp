; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude ObservationRangeBeacon.msg.html

(cl:defclass <ObservationRangeBeacon> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (sensor_pose_on_robot
    :reader sensor_pose_on_robot
    :initarg :sensor_pose_on_robot
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (min_sensor_distance
    :reader min_sensor_distance
    :initarg :min_sensor_distance
    :type cl:float
    :initform 0.0)
   (max_sensor_distance
    :reader max_sensor_distance
    :initarg :max_sensor_distance
    :type cl:float
    :initform 0.0)
   (sensor_std_range
    :reader sensor_std_range
    :initarg :sensor_std_range
    :type cl:float
    :initform 0.0)
   (sensed_data
    :reader sensed_data
    :initarg :sensed_data
    :type (cl:vector mrpt_msgs-msg:SingleRangeBeaconObservation)
   :initform (cl:make-array 0 :element-type 'mrpt_msgs-msg:SingleRangeBeaconObservation :initial-element (cl:make-instance 'mrpt_msgs-msg:SingleRangeBeaconObservation))))
)

(cl:defclass ObservationRangeBeacon (<ObservationRangeBeacon>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObservationRangeBeacon>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObservationRangeBeacon)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<ObservationRangeBeacon> is deprecated: use mrpt_msgs-msg:ObservationRangeBeacon instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ObservationRangeBeacon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:header-val is deprecated.  Use mrpt_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'sensor_pose_on_robot-val :lambda-list '(m))
(cl:defmethod sensor_pose_on_robot-val ((m <ObservationRangeBeacon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:sensor_pose_on_robot-val is deprecated.  Use mrpt_msgs-msg:sensor_pose_on_robot instead.")
  (sensor_pose_on_robot m))

(cl:ensure-generic-function 'min_sensor_distance-val :lambda-list '(m))
(cl:defmethod min_sensor_distance-val ((m <ObservationRangeBeacon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:min_sensor_distance-val is deprecated.  Use mrpt_msgs-msg:min_sensor_distance instead.")
  (min_sensor_distance m))

(cl:ensure-generic-function 'max_sensor_distance-val :lambda-list '(m))
(cl:defmethod max_sensor_distance-val ((m <ObservationRangeBeacon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:max_sensor_distance-val is deprecated.  Use mrpt_msgs-msg:max_sensor_distance instead.")
  (max_sensor_distance m))

(cl:ensure-generic-function 'sensor_std_range-val :lambda-list '(m))
(cl:defmethod sensor_std_range-val ((m <ObservationRangeBeacon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:sensor_std_range-val is deprecated.  Use mrpt_msgs-msg:sensor_std_range instead.")
  (sensor_std_range m))

(cl:ensure-generic-function 'sensed_data-val :lambda-list '(m))
(cl:defmethod sensed_data-val ((m <ObservationRangeBeacon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:sensed_data-val is deprecated.  Use mrpt_msgs-msg:sensed_data instead.")
  (sensed_data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObservationRangeBeacon>) ostream)
  "Serializes a message object of type '<ObservationRangeBeacon>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'sensor_pose_on_robot) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'min_sensor_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'max_sensor_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'sensor_std_range))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'sensed_data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'sensed_data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObservationRangeBeacon>) istream)
  "Deserializes a message object of type '<ObservationRangeBeacon>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'sensor_pose_on_robot) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min_sensor_distance) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'max_sensor_distance) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sensor_std_range) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'sensed_data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'sensed_data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'mrpt_msgs-msg:SingleRangeBeaconObservation))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObservationRangeBeacon>)))
  "Returns string type for a message object of type '<ObservationRangeBeacon>"
  "mrpt_msgs/ObservationRangeBeacon")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObservationRangeBeacon)))
  "Returns string type for a message object of type 'ObservationRangeBeacon"
  "mrpt_msgs/ObservationRangeBeacon")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObservationRangeBeacon>)))
  "Returns md5sum for a message object of type '<ObservationRangeBeacon>"
  "94cf8974a1eec8843e3b69c87cc25d62")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObservationRangeBeacon)))
  "Returns md5sum for a message object of type 'ObservationRangeBeacon"
  "94cf8974a1eec8843e3b69c87cc25d62")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObservationRangeBeacon>)))
  "Returns full string definition for message of type '<ObservationRangeBeacon>"
  (cl:format cl:nil "# This message holds an observation of one or more landmarks ~%#  detected by their range (distance) ~%#  from some sensor on the robot.~%~%# Time of sensor data acquisition, coordinate frame ID.~%Header header~%~%# The sensor pose on the robot coordinates frame.~%geometry_msgs/Pose sensor_pose_on_robot~%~%# Sensor characteristics:~%float64 min_sensor_distance   # In meters (m)~%float64 max_sensor_distance   # (m)~%~%# Typical sensor noise:~%float64 sensor_std_range      # (m)~%~%# The vector of individual observations~%SingleRangeBeaconObservation[] sensed_data~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: mrpt_msgs/SingleRangeBeaconObservation~%#int32 INVALID_LANDMARK_ID = -1~%~%~%float64  range    # Distance, in meters.~%int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObservationRangeBeacon)))
  "Returns full string definition for message of type 'ObservationRangeBeacon"
  (cl:format cl:nil "# This message holds an observation of one or more landmarks ~%#  detected by their range (distance) ~%#  from some sensor on the robot.~%~%# Time of sensor data acquisition, coordinate frame ID.~%Header header~%~%# The sensor pose on the robot coordinates frame.~%geometry_msgs/Pose sensor_pose_on_robot~%~%# Sensor characteristics:~%float64 min_sensor_distance   # In meters (m)~%float64 max_sensor_distance   # (m)~%~%# Typical sensor noise:~%float64 sensor_std_range      # (m)~%~%# The vector of individual observations~%SingleRangeBeaconObservation[] sensed_data~%~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: mrpt_msgs/SingleRangeBeaconObservation~%#int32 INVALID_LANDMARK_ID = -1~%~%~%float64  range    # Distance, in meters.~%int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObservationRangeBeacon>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'sensor_pose_on_robot))
     8
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'sensed_data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObservationRangeBeacon>))
  "Converts a ROS message object to a list"
  (cl:list 'ObservationRangeBeacon
    (cl:cons ':header (header msg))
    (cl:cons ':sensor_pose_on_robot (sensor_pose_on_robot msg))
    (cl:cons ':min_sensor_distance (min_sensor_distance msg))
    (cl:cons ':max_sensor_distance (max_sensor_distance msg))
    (cl:cons ':sensor_std_range (sensor_std_range msg))
    (cl:cons ':sensed_data (sensed_data msg))
))
