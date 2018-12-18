; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-srv)


;//! \htmlinclude GetCMGraph-request.msg.html

(cl:defclass <GetCMGraph-request> (roslisp-msg-protocol:ros-message)
  ((nodeIDs
    :reader nodeIDs
    :initarg :nodeIDs
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass GetCMGraph-request (<GetCMGraph-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetCMGraph-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetCMGraph-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-srv:<GetCMGraph-request> is deprecated: use mrpt_msgs-srv:GetCMGraph-request instead.")))

(cl:ensure-generic-function 'nodeIDs-val :lambda-list '(m))
(cl:defmethod nodeIDs-val ((m <GetCMGraph-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-srv:nodeIDs-val is deprecated.  Use mrpt_msgs-srv:nodeIDs instead.")
  (nodeIDs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetCMGraph-request>) ostream)
  "Serializes a message object of type '<GetCMGraph-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'nodeIDs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) ele) ostream))
   (cl:slot-value msg 'nodeIDs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetCMGraph-request>) istream)
  "Deserializes a message object of type '<GetCMGraph-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'nodeIDs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'nodeIDs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetCMGraph-request>)))
  "Returns string type for a service object of type '<GetCMGraph-request>"
  "mrpt_msgs/GetCMGraphRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetCMGraph-request)))
  "Returns string type for a service object of type 'GetCMGraph-request"
  "mrpt_msgs/GetCMGraphRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetCMGraph-request>)))
  "Returns md5sum for a message object of type '<GetCMGraph-request>"
  "42fe1c3f75b229167d9c830777c38406")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetCMGraph-request)))
  "Returns md5sum for a message object of type 'GetCMGraph-request"
  "42fe1c3f75b229167d9c830777c38406")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetCMGraph-request>)))
  "Returns full string definition for message of type '<GetCMGraph-request>"
  (cl:format cl:nil "~%~%~%~%uint64[] nodeIDs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetCMGraph-request)))
  "Returns full string definition for message of type 'GetCMGraph-request"
  (cl:format cl:nil "~%~%~%~%uint64[] nodeIDs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetCMGraph-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'nodeIDs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetCMGraph-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetCMGraph-request
    (cl:cons ':nodeIDs (nodeIDs msg))
))
;//! \htmlinclude GetCMGraph-response.msg.html

(cl:defclass <GetCMGraph-response> (roslisp-msg-protocol:ros-message)
  ((cm_graph
    :reader cm_graph
    :initarg :cm_graph
    :type mrpt_msgs-msg:NetworkOfPoses
    :initform (cl:make-instance 'mrpt_msgs-msg:NetworkOfPoses)))
)

(cl:defclass GetCMGraph-response (<GetCMGraph-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetCMGraph-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetCMGraph-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-srv:<GetCMGraph-response> is deprecated: use mrpt_msgs-srv:GetCMGraph-response instead.")))

(cl:ensure-generic-function 'cm_graph-val :lambda-list '(m))
(cl:defmethod cm_graph-val ((m <GetCMGraph-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-srv:cm_graph-val is deprecated.  Use mrpt_msgs-srv:cm_graph instead.")
  (cm_graph m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetCMGraph-response>) ostream)
  "Serializes a message object of type '<GetCMGraph-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cm_graph) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetCMGraph-response>) istream)
  "Deserializes a message object of type '<GetCMGraph-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cm_graph) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetCMGraph-response>)))
  "Returns string type for a service object of type '<GetCMGraph-response>"
  "mrpt_msgs/GetCMGraphResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetCMGraph-response)))
  "Returns string type for a service object of type 'GetCMGraph-response"
  "mrpt_msgs/GetCMGraphResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetCMGraph-response>)))
  "Returns md5sum for a message object of type '<GetCMGraph-response>"
  "42fe1c3f75b229167d9c830777c38406")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetCMGraph-response)))
  "Returns md5sum for a message object of type 'GetCMGraph-response"
  "42fe1c3f75b229167d9c830777c38406")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetCMGraph-response>)))
  "Returns full string definition for message of type '<GetCMGraph-response>"
  (cl:format cl:nil "mrpt_msgs/NetworkOfPoses cm_graph~%~%~%================================================================================~%MSG: mrpt_msgs/NetworkOfPoses~%# Represents a 2D/3D Directed Graph of Constraints~%#~%# Graph consists of:~%# - NodeIDs with their corresponding poses~%# - Directed Constraints that connect 2 nodes with each other~%# - Root node marking the start of the graph~%~%uint64 root~%NodeIDWithPose_vec nodes~%GraphConstraint[] constraints~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose_vec~%# Vector of NodeIDWithPose msgs~%~%NodeIDWithPose[] vec~%~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose~%# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: mrpt_msgs/GraphConstraint~%# Graph constraint that connects 2 nodes~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID_from~%uint64 nodeID_to~%geometry_msgs/PoseWithCovariance constraint~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetCMGraph-response)))
  "Returns full string definition for message of type 'GetCMGraph-response"
  (cl:format cl:nil "mrpt_msgs/NetworkOfPoses cm_graph~%~%~%================================================================================~%MSG: mrpt_msgs/NetworkOfPoses~%# Represents a 2D/3D Directed Graph of Constraints~%#~%# Graph consists of:~%# - NodeIDs with their corresponding poses~%# - Directed Constraints that connect 2 nodes with each other~%# - Root node marking the start of the graph~%~%uint64 root~%NodeIDWithPose_vec nodes~%GraphConstraint[] constraints~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose_vec~%# Vector of NodeIDWithPose msgs~%~%NodeIDWithPose[] vec~%~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose~%# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: mrpt_msgs/GraphConstraint~%# Graph constraint that connects 2 nodes~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID_from~%uint64 nodeID_to~%geometry_msgs/PoseWithCovariance constraint~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetCMGraph-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cm_graph))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetCMGraph-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetCMGraph-response
    (cl:cons ':cm_graph (cm_graph msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetCMGraph)))
  'GetCMGraph-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetCMGraph)))
  'GetCMGraph-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetCMGraph)))
  "Returns string type for a service object of type '<GetCMGraph>"
  "mrpt_msgs/GetCMGraph")