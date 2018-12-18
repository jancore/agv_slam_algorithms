; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude GraphSlamStats.msg.html

(cl:defclass <GraphSlamStats> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (nodes_total
    :reader nodes_total
    :initarg :nodes_total
    :type cl:integer
    :initform 0)
   (edges_total
    :reader edges_total
    :initarg :edges_total
    :type cl:integer
    :initform 0)
   (edges_ICP2D
    :reader edges_ICP2D
    :initarg :edges_ICP2D
    :type cl:integer
    :initform 0)
   (edges_ICP3D
    :reader edges_ICP3D
    :initarg :edges_ICP3D
    :type cl:integer
    :initform 0)
   (edges_odom
    :reader edges_odom
    :initarg :edges_odom
    :type cl:integer
    :initform 0)
   (loop_closures
    :reader loop_closures
    :initarg :loop_closures
    :type cl:integer
    :initform 0)
   (slam_evaluation_metric
    :reader slam_evaluation_metric
    :initarg :slam_evaluation_metric
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass GraphSlamStats (<GraphSlamStats>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GraphSlamStats>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GraphSlamStats)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<GraphSlamStats> is deprecated: use mrpt_msgs-msg:GraphSlamStats instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:header-val is deprecated.  Use mrpt_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'nodes_total-val :lambda-list '(m))
(cl:defmethod nodes_total-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:nodes_total-val is deprecated.  Use mrpt_msgs-msg:nodes_total instead.")
  (nodes_total m))

(cl:ensure-generic-function 'edges_total-val :lambda-list '(m))
(cl:defmethod edges_total-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:edges_total-val is deprecated.  Use mrpt_msgs-msg:edges_total instead.")
  (edges_total m))

(cl:ensure-generic-function 'edges_ICP2D-val :lambda-list '(m))
(cl:defmethod edges_ICP2D-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:edges_ICP2D-val is deprecated.  Use mrpt_msgs-msg:edges_ICP2D instead.")
  (edges_ICP2D m))

(cl:ensure-generic-function 'edges_ICP3D-val :lambda-list '(m))
(cl:defmethod edges_ICP3D-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:edges_ICP3D-val is deprecated.  Use mrpt_msgs-msg:edges_ICP3D instead.")
  (edges_ICP3D m))

(cl:ensure-generic-function 'edges_odom-val :lambda-list '(m))
(cl:defmethod edges_odom-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:edges_odom-val is deprecated.  Use mrpt_msgs-msg:edges_odom instead.")
  (edges_odom m))

(cl:ensure-generic-function 'loop_closures-val :lambda-list '(m))
(cl:defmethod loop_closures-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:loop_closures-val is deprecated.  Use mrpt_msgs-msg:loop_closures instead.")
  (loop_closures m))

(cl:ensure-generic-function 'slam_evaluation_metric-val :lambda-list '(m))
(cl:defmethod slam_evaluation_metric-val ((m <GraphSlamStats>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:slam_evaluation_metric-val is deprecated.  Use mrpt_msgs-msg:slam_evaluation_metric instead.")
  (slam_evaluation_metric m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GraphSlamStats>) ostream)
  "Serializes a message object of type '<GraphSlamStats>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'nodes_total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'edges_total)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'edges_ICP2D)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'edges_ICP3D)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'edges_odom)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'loop_closures)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'slam_evaluation_metric))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'slam_evaluation_metric))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GraphSlamStats>) istream)
  "Deserializes a message object of type '<GraphSlamStats>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nodes_total) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edges_total) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edges_ICP2D) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edges_ICP3D) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edges_odom) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'loop_closures) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'slam_evaluation_metric) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'slam_evaluation_metric)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GraphSlamStats>)))
  "Returns string type for a message object of type '<GraphSlamStats>"
  "mrpt_msgs/GraphSlamStats")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphSlamStats)))
  "Returns string type for a message object of type 'GraphSlamStats"
  "mrpt_msgs/GraphSlamStats")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GraphSlamStats>)))
  "Returns md5sum for a message object of type '<GraphSlamStats>"
  "eacf2f0450892c9d53ce9dcaa0385298")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GraphSlamStats)))
  "Returns md5sum for a message object of type 'GraphSlamStats"
  "eacf2f0450892c9d53ce9dcaa0385298")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GraphSlamStats>)))
  "Returns full string definition for message of type '<GraphSlamStats>"
  (cl:format cl:nil "# Statistics related to the execution of graphSLAM.~%# Message is utilized in the mrpt_graphslam ROS package~%~%# Time of message acquisition~%Header header~%~%# node-related stats~%int32 nodes_total~%~%# edge-related stats~%int32 edges_total~%int32 edges_ICP2D~%int32 edges_ICP3D~%int32 edges_odom~%int32 loop_closures~%~%# Evaluation metric of the SLAM process~%float64[] slam_evaluation_metric~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GraphSlamStats)))
  "Returns full string definition for message of type 'GraphSlamStats"
  (cl:format cl:nil "# Statistics related to the execution of graphSLAM.~%# Message is utilized in the mrpt_graphslam ROS package~%~%# Time of message acquisition~%Header header~%~%# node-related stats~%int32 nodes_total~%~%# edge-related stats~%int32 edges_total~%int32 edges_ICP2D~%int32 edges_ICP3D~%int32 edges_odom~%int32 loop_closures~%~%# Evaluation metric of the SLAM process~%float64[] slam_evaluation_metric~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GraphSlamStats>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'slam_evaluation_metric) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GraphSlamStats>))
  "Converts a ROS message object to a list"
  (cl:list 'GraphSlamStats
    (cl:cons ':header (header msg))
    (cl:cons ':nodes_total (nodes_total msg))
    (cl:cons ':edges_total (edges_total msg))
    (cl:cons ':edges_ICP2D (edges_ICP2D msg))
    (cl:cons ':edges_ICP3D (edges_ICP3D msg))
    (cl:cons ':edges_odom (edges_odom msg))
    (cl:cons ':loop_closures (loop_closures msg))
    (cl:cons ':slam_evaluation_metric (slam_evaluation_metric msg))
))
