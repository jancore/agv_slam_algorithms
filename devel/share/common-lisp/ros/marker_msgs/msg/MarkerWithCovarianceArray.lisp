; Auto-generated. Do not edit!


(cl:in-package marker_msgs-msg)


;//! \htmlinclude MarkerWithCovarianceArray.msg.html

(cl:defclass <MarkerWithCovarianceArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (markers
    :reader markers
    :initarg :markers
    :type (cl:vector marker_msgs-msg:MarkerWithCovariance)
   :initform (cl:make-array 0 :element-type 'marker_msgs-msg:MarkerWithCovariance :initial-element (cl:make-instance 'marker_msgs-msg:MarkerWithCovariance))))
)

(cl:defclass MarkerWithCovarianceArray (<MarkerWithCovarianceArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerWithCovarianceArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerWithCovarianceArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marker_msgs-msg:<MarkerWithCovarianceArray> is deprecated: use marker_msgs-msg:MarkerWithCovarianceArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MarkerWithCovarianceArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:header-val is deprecated.  Use marker_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'markers-val :lambda-list '(m))
(cl:defmethod markers-val ((m <MarkerWithCovarianceArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:markers-val is deprecated.  Use marker_msgs-msg:markers instead.")
  (markers m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerWithCovarianceArray>) ostream)
  "Serializes a message object of type '<MarkerWithCovarianceArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'markers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'markers))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerWithCovarianceArray>) istream)
  "Deserializes a message object of type '<MarkerWithCovarianceArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'markers) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'markers)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'marker_msgs-msg:MarkerWithCovariance))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerWithCovarianceArray>)))
  "Returns string type for a message object of type '<MarkerWithCovarianceArray>"
  "marker_msgs/MarkerWithCovarianceArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerWithCovarianceArray)))
  "Returns string type for a message object of type 'MarkerWithCovarianceArray"
  "marker_msgs/MarkerWithCovarianceArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerWithCovarianceArray>)))
  "Returns md5sum for a message object of type '<MarkerWithCovarianceArray>"
  "5b4524ee352826cec566891ecfc427c6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerWithCovarianceArray)))
  "Returns md5sum for a message object of type 'MarkerWithCovarianceArray"
  "5b4524ee352826cec566891ecfc427c6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerWithCovarianceArray>)))
  "Returns full string definition for message of type '<MarkerWithCovarianceArray>"
  (cl:format cl:nil "# An array of markers with covariance and with a header for global reference.~%~%Header header~%MarkerWithCovariance[] markers     #  array of markers with covariance~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: marker_msgs/MarkerWithCovariance~%# This expresses a marker in free space with uncertainty.~%~%Marker marker~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerWithCovarianceArray)))
  "Returns full string definition for message of type 'MarkerWithCovarianceArray"
  (cl:format cl:nil "# An array of markers with covariance and with a header for global reference.~%~%Header header~%MarkerWithCovariance[] markers     #  array of markers with covariance~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: marker_msgs/MarkerWithCovariance~%# This expresses a marker in free space with uncertainty.~%~%Marker marker~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerWithCovarianceArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'markers) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerWithCovarianceArray>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerWithCovarianceArray
    (cl:cons ':header (header msg))
    (cl:cons ':markers (markers msg))
))
