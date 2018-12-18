; Auto-generated. Do not edit!


(cl:in-package marker_msgs-msg)


;//! \htmlinclude MarkerWithCovarianceStamped.msg.html

(cl:defclass <MarkerWithCovarianceStamped> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (marker
    :reader marker
    :initarg :marker
    :type marker_msgs-msg:MarkerWithCovariance
    :initform (cl:make-instance 'marker_msgs-msg:MarkerWithCovariance)))
)

(cl:defclass MarkerWithCovarianceStamped (<MarkerWithCovarianceStamped>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerWithCovarianceStamped>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerWithCovarianceStamped)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marker_msgs-msg:<MarkerWithCovarianceStamped> is deprecated: use marker_msgs-msg:MarkerWithCovarianceStamped instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MarkerWithCovarianceStamped>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:header-val is deprecated.  Use marker_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'marker-val :lambda-list '(m))
(cl:defmethod marker-val ((m <MarkerWithCovarianceStamped>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:marker-val is deprecated.  Use marker_msgs-msg:marker instead.")
  (marker m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerWithCovarianceStamped>) ostream)
  "Serializes a message object of type '<MarkerWithCovarianceStamped>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'marker) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerWithCovarianceStamped>) istream)
  "Deserializes a message object of type '<MarkerWithCovarianceStamped>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'marker) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerWithCovarianceStamped>)))
  "Returns string type for a message object of type '<MarkerWithCovarianceStamped>"
  "marker_msgs/MarkerWithCovarianceStamped")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerWithCovarianceStamped)))
  "Returns string type for a message object of type 'MarkerWithCovarianceStamped"
  "marker_msgs/MarkerWithCovarianceStamped")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerWithCovarianceStamped>)))
  "Returns md5sum for a message object of type '<MarkerWithCovarianceStamped>"
  "1c6b4e4db4f1f1f63303a467ab44aef6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerWithCovarianceStamped)))
  "Returns md5sum for a message object of type 'MarkerWithCovarianceStamped"
  "1c6b4e4db4f1f1f63303a467ab44aef6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerWithCovarianceStamped>)))
  "Returns full string definition for message of type '<MarkerWithCovarianceStamped>"
  (cl:format cl:nil "# This represents a marker with reference coordinate frame and timestamp and covariance matrix~%Header header~%MarkerWithCovariance marker~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: marker_msgs/MarkerWithCovariance~%# This expresses a marker in free space with uncertainty.~%~%Marker marker~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerWithCovarianceStamped)))
  "Returns full string definition for message of type 'MarkerWithCovarianceStamped"
  (cl:format cl:nil "# This represents a marker with reference coordinate frame and timestamp and covariance matrix~%Header header~%MarkerWithCovariance marker~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: marker_msgs/MarkerWithCovariance~%# This expresses a marker in free space with uncertainty.~%~%Marker marker~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerWithCovarianceStamped>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'marker))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerWithCovarianceStamped>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerWithCovarianceStamped
    (cl:cons ':header (header msg))
    (cl:cons ':marker (marker msg))
))
