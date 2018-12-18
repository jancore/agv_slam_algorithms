; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude NodeIDWithPose.msg.html

(cl:defclass <NodeIDWithPose> (roslisp-msg-protocol:ros-message)
  ((nodeID
    :reader nodeID
    :initarg :nodeID
    :type cl:integer
    :initform 0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (str_ID
    :reader str_ID
    :initarg :str_ID
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (nodeID_loc
    :reader nodeID_loc
    :initarg :nodeID_loc
    :type cl:integer
    :initform 0))
)

(cl:defclass NodeIDWithPose (<NodeIDWithPose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NodeIDWithPose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NodeIDWithPose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<NodeIDWithPose> is deprecated: use mrpt_msgs-msg:NodeIDWithPose instead.")))

(cl:ensure-generic-function 'nodeID-val :lambda-list '(m))
(cl:defmethod nodeID-val ((m <NodeIDWithPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:nodeID-val is deprecated.  Use mrpt_msgs-msg:nodeID instead.")
  (nodeID m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <NodeIDWithPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:pose-val is deprecated.  Use mrpt_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'str_ID-val :lambda-list '(m))
(cl:defmethod str_ID-val ((m <NodeIDWithPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:str_ID-val is deprecated.  Use mrpt_msgs-msg:str_ID instead.")
  (str_ID m))

(cl:ensure-generic-function 'nodeID_loc-val :lambda-list '(m))
(cl:defmethod nodeID_loc-val ((m <NodeIDWithPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:nodeID_loc-val is deprecated.  Use mrpt_msgs-msg:nodeID_loc instead.")
  (nodeID_loc m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NodeIDWithPose>) ostream)
  "Serializes a message object of type '<NodeIDWithPose>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'str_ID) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID_loc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID_loc)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NodeIDWithPose>) istream)
  "Deserializes a message object of type '<NodeIDWithPose>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'str_ID) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID_loc)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NodeIDWithPose>)))
  "Returns string type for a message object of type '<NodeIDWithPose>"
  "mrpt_msgs/NodeIDWithPose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NodeIDWithPose)))
  "Returns string type for a message object of type 'NodeIDWithPose"
  "mrpt_msgs/NodeIDWithPose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NodeIDWithPose>)))
  "Returns md5sum for a message object of type '<NodeIDWithPose>"
  "87c8db37a689c10a5c5dc1aa39838320")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NodeIDWithPose)))
  "Returns md5sum for a message object of type 'NodeIDWithPose"
  "87c8db37a689c10a5c5dc1aa39838320")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NodeIDWithPose>)))
  "Returns full string definition for message of type '<NodeIDWithPose>"
  (cl:format cl:nil "# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NodeIDWithPose)))
  "Returns full string definition for message of type 'NodeIDWithPose"
  (cl:format cl:nil "# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NodeIDWithPose>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'str_ID))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NodeIDWithPose>))
  "Converts a ROS message object to a list"
  (cl:list 'NodeIDWithPose
    (cl:cons ':nodeID (nodeID msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':str_ID (str_ID msg))
    (cl:cons ':nodeID_loc (nodeID_loc msg))
))
