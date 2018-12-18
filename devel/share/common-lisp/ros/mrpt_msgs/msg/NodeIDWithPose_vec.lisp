; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude NodeIDWithPose_vec.msg.html

(cl:defclass <NodeIDWithPose_vec> (roslisp-msg-protocol:ros-message)
  ((vec
    :reader vec
    :initarg :vec
    :type (cl:vector mrpt_msgs-msg:NodeIDWithPose)
   :initform (cl:make-array 0 :element-type 'mrpt_msgs-msg:NodeIDWithPose :initial-element (cl:make-instance 'mrpt_msgs-msg:NodeIDWithPose))))
)

(cl:defclass NodeIDWithPose_vec (<NodeIDWithPose_vec>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NodeIDWithPose_vec>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NodeIDWithPose_vec)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<NodeIDWithPose_vec> is deprecated: use mrpt_msgs-msg:NodeIDWithPose_vec instead.")))

(cl:ensure-generic-function 'vec-val :lambda-list '(m))
(cl:defmethod vec-val ((m <NodeIDWithPose_vec>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:vec-val is deprecated.  Use mrpt_msgs-msg:vec instead.")
  (vec m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NodeIDWithPose_vec>) ostream)
  "Serializes a message object of type '<NodeIDWithPose_vec>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'vec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'vec))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NodeIDWithPose_vec>) istream)
  "Deserializes a message object of type '<NodeIDWithPose_vec>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'vec) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'vec)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'mrpt_msgs-msg:NodeIDWithPose))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NodeIDWithPose_vec>)))
  "Returns string type for a message object of type '<NodeIDWithPose_vec>"
  "mrpt_msgs/NodeIDWithPose_vec")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NodeIDWithPose_vec)))
  "Returns string type for a message object of type 'NodeIDWithPose_vec"
  "mrpt_msgs/NodeIDWithPose_vec")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NodeIDWithPose_vec>)))
  "Returns md5sum for a message object of type '<NodeIDWithPose_vec>"
  "f30000109eab9cc7bc6b44c3e86d9fac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NodeIDWithPose_vec)))
  "Returns md5sum for a message object of type 'NodeIDWithPose_vec"
  "f30000109eab9cc7bc6b44c3e86d9fac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NodeIDWithPose_vec>)))
  "Returns full string definition for message of type '<NodeIDWithPose_vec>"
  (cl:format cl:nil "# Vector of NodeIDWithPose msgs~%~%NodeIDWithPose[] vec~%~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose~%# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NodeIDWithPose_vec)))
  "Returns full string definition for message of type 'NodeIDWithPose_vec"
  (cl:format cl:nil "# Vector of NodeIDWithPose msgs~%~%NodeIDWithPose[] vec~%~%~%================================================================================~%MSG: mrpt_msgs/NodeIDWithPose~%# NodeID along with its corresponding 2D/3D pose estimation.~%# Message also contains the following optional fields:~%# - str_ID: string identifier of the robot agent that initially registered this node in~%# its graph~%# - nodeID_loc: ID of the current node in the graph it was initially registered in.~%#~%# note: Additional fields correspond to the fields of the~%# mrpt::graphs::detail::TMRSlamNodeAnnotations struct~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID~%geometry_msgs/Pose pose~%~%std_msgs/String str_ID~%uint64 nodeID_loc~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NodeIDWithPose_vec>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'vec) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NodeIDWithPose_vec>))
  "Converts a ROS message object to a list"
  (cl:list 'NodeIDWithPose_vec
    (cl:cons ':vec (vec msg))
))
