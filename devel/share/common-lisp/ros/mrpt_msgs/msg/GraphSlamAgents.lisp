; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude GraphSlamAgents.msg.html

(cl:defclass <GraphSlamAgents> (roslisp-msg-protocol:ros-message)
  ((list
    :reader list
    :initarg :list
    :type (cl:vector mrpt_msgs-msg:GraphSlamAgent)
   :initform (cl:make-array 0 :element-type 'mrpt_msgs-msg:GraphSlamAgent :initial-element (cl:make-instance 'mrpt_msgs-msg:GraphSlamAgent))))
)

(cl:defclass GraphSlamAgents (<GraphSlamAgents>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GraphSlamAgents>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GraphSlamAgents)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<GraphSlamAgents> is deprecated: use mrpt_msgs-msg:GraphSlamAgents instead.")))

(cl:ensure-generic-function 'list-val :lambda-list '(m))
(cl:defmethod list-val ((m <GraphSlamAgents>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:list-val is deprecated.  Use mrpt_msgs-msg:list instead.")
  (list m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GraphSlamAgents>) ostream)
  "Serializes a message object of type '<GraphSlamAgents>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'list))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'list))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GraphSlamAgents>) istream)
  "Deserializes a message object of type '<GraphSlamAgents>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'list) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'list)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'mrpt_msgs-msg:GraphSlamAgent))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GraphSlamAgents>)))
  "Returns string type for a message object of type '<GraphSlamAgents>"
  "mrpt_msgs/GraphSlamAgents")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphSlamAgents)))
  "Returns string type for a message object of type 'GraphSlamAgents"
  "mrpt_msgs/GraphSlamAgents")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GraphSlamAgents>)))
  "Returns md5sum for a message object of type '<GraphSlamAgents>"
  "ac3446e50a170e19b88734cb8e7206bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GraphSlamAgents)))
  "Returns md5sum for a message object of type 'GraphSlamAgents"
  "ac3446e50a170e19b88734cb8e7206bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GraphSlamAgents>)))
  "Returns full string definition for message of type '<GraphSlamAgents>"
  (cl:format cl:nil "# Defines vector of GraphSlamAgents.~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%GraphSlamAgent[] list~%~%~%================================================================================~%MSG: mrpt_msgs/GraphSlamAgent~%# Connection-related properties for a graphSLAM agent in a multi-robot~%# environment.~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%std_msgs/String name~%std_msgs/String hostname~%~%# IPv4 of the corresponding agent~%std_msgs/String ip_addr~%~%# Port that the the roscore of the corresponding agent is running under~%uint16 port~%~%# True if the SLAM Agent was last reported to be online~%std_msgs/Bool is_online~%~%# Timestamp that the SLAM Agent was last seen~%std_msgs/Time last_seen_time~%~%# ROS Topics namespace that the agent is running under~%# By definition this is going to be the same as the *name*~%# UPDATE: Previously the topics namespace was <name>_<agent_ID>. However since I'll be using the multimaster for communication, every node is going to have a different ~%std_msgs/String topic_namespace~%~%# this is the last field of the IPv4 address of the corresponding agent~%# e.g. IP=192.168.100.17~%# agent_ID = 17~%int32 agent_ID ~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%================================================================================~%MSG: std_msgs/Time~%time data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GraphSlamAgents)))
  "Returns full string definition for message of type 'GraphSlamAgents"
  (cl:format cl:nil "# Defines vector of GraphSlamAgents.~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%GraphSlamAgent[] list~%~%~%================================================================================~%MSG: mrpt_msgs/GraphSlamAgent~%# Connection-related properties for a graphSLAM agent in a multi-robot~%# environment.~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%std_msgs/String name~%std_msgs/String hostname~%~%# IPv4 of the corresponding agent~%std_msgs/String ip_addr~%~%# Port that the the roscore of the corresponding agent is running under~%uint16 port~%~%# True if the SLAM Agent was last reported to be online~%std_msgs/Bool is_online~%~%# Timestamp that the SLAM Agent was last seen~%std_msgs/Time last_seen_time~%~%# ROS Topics namespace that the agent is running under~%# By definition this is going to be the same as the *name*~%# UPDATE: Previously the topics namespace was <name>_<agent_ID>. However since I'll be using the multimaster for communication, every node is going to have a different ~%std_msgs/String topic_namespace~%~%# this is the last field of the IPv4 address of the corresponding agent~%# e.g. IP=192.168.100.17~%# agent_ID = 17~%int32 agent_ID ~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%================================================================================~%MSG: std_msgs/Time~%time data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GraphSlamAgents>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'list) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GraphSlamAgents>))
  "Converts a ROS message object to a list"
  (cl:list 'GraphSlamAgents
    (cl:cons ':list (list msg))
))
