; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude NetworkOfPoses.msg.html

(cl:defclass <NetworkOfPoses> (roslisp-msg-protocol:ros-message)
  ((root
    :reader root
    :initarg :root
    :type cl:integer
    :initform 0)
   (nodes
    :reader nodes
    :initarg :nodes
    :type mrpt_msgs-msg:NodeIDWithPose_vec
    :initform (cl:make-instance 'mrpt_msgs-msg:NodeIDWithPose_vec))
   (constraints
    :reader constraints
    :initarg :constraints
    :type (cl:vector mrpt_msgs-msg:GraphConstraint)
   :initform (cl:make-array 0 :element-type 'mrpt_msgs-msg:GraphConstraint :initial-element (cl:make-instance 'mrpt_msgs-msg:GraphConstraint))))
)

(cl:defclass NetworkOfPoses (<NetworkOfPoses>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NetworkOfPoses>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NetworkOfPoses)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<NetworkOfPoses> is deprecated: use mrpt_msgs-msg:NetworkOfPoses instead.")))

(cl:ensure-generic-function 'root-val :lambda-list '(m))
(cl:defmethod root-val ((m <NetworkOfPoses>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:root-val is deprecated.  Use mrpt_msgs-msg:root instead.")
  (root m))

(cl:ensure-generic-function 'nodes-val :lambda-list '(m))
(cl:defmethod nodes-val ((m <NetworkOfPoses>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:nodes-val is deprecated.  Use mrpt_msgs-msg:nodes instead.")
  (nodes m))

(cl:ensure-generic-function 'constraints-val :lambda-list '(m))
(cl:defmethod constraints-val ((m <NetworkOfPoses>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:constraints-val is deprecated.  Use mrpt_msgs-msg:constraints instead.")
  (constraints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NetworkOfPoses>) ostream)
  "Serializes a message object of type '<NetworkOfPoses>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'root)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'root)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'nodes) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'constraints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'constraints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NetworkOfPoses>) istream)
  "Deserializes a message object of type '<NetworkOfPoses>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'root)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'root)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'nodes) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'constraints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'constraints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'mrpt_msgs-msg:GraphConstraint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NetworkOfPoses>)))
  "Returns string type for a message object of type '<NetworkOfPoses>"
  "mrpt_msgs/NetworkOfPoses")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NetworkOfPoses)))
  "Returns string type for a message object of type 'NetworkOfPoses"
  "mrpt_msgs/NetworkOfPoses")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NetworkOfPoses>)))
  "Returns md5sum for a message object of type '<NetworkOfPoses>"
  "2f7e17a78e81d376b3e999d635df4228")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NetworkOfPoses)))
  "Returns md5sum for a message object of type 'NetworkOfPoses"
  "2f7e17a78e81d376b3e999d635df4228")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NetworkOfPoses>)))
  "Returns full string definition for message of type '<NetworkOfPoses>"
  (cl:format cl:nil "# Represents a 2D/3D Directed Graph of Constraints~%#~%# Graph consists of:~%# - NodeIDs with their corresponding poses~%# - Directed Constraints that connect 2 nodes with each other~%# - Root node marking the start of the graph~%~%uint64 root~%NodeIDWithPose_vec nodes~%GraphConstraint[] constraints~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose_vec~%# Vector of NodeIDWithPose msgs~%~%NodeIDWithPose[] vec~%~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose~%# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: mrpt_msgs/GraphConstraint~%# Graph constraint that connects 2 nodes~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID_from~%uint64 nodeID_to~%geometry_msgs/PoseWithCovariance constraint~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NetworkOfPoses)))
  "Returns full string definition for message of type 'NetworkOfPoses"
  (cl:format cl:nil "# Represents a 2D/3D Directed Graph of Constraints~%#~%# Graph consists of:~%# - NodeIDs with their corresponding poses~%# - Directed Constraints that connect 2 nodes with each other~%# - Root node marking the start of the graph~%~%uint64 root~%NodeIDWithPose_vec nodes~%GraphConstraint[] constraints~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose_vec~%# Vector of NodeIDWithPose msgs~%~%NodeIDWithPose[] vec~%~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose~%# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: mrpt_msgs/GraphConstraint~%# Graph constraint that connects 2 nodes~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID_from~%uint64 nodeID_to~%geometry_msgs/PoseWithCovariance constraint~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NetworkOfPoses>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'nodes))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'constraints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NetworkOfPoses>))
  "Converts a ROS message object to a list"
  (cl:list 'NetworkOfPoses
    (cl:cons ':root (root msg))
    (cl:cons ':nodes (nodes msg))
    (cl:cons ':constraints (constraints msg))
))
