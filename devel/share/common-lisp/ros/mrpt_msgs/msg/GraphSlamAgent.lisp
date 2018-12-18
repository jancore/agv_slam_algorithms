; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude GraphSlamAgent.msg.html

(cl:defclass <GraphSlamAgent> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (hostname
    :reader hostname
    :initarg :hostname
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (ip_addr
    :reader ip_addr
    :initarg :ip_addr
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (port
    :reader port
    :initarg :port
    :type cl:fixnum
    :initform 0)
   (is_online
    :reader is_online
    :initarg :is_online
    :type std_msgs-msg:Bool
    :initform (cl:make-instance 'std_msgs-msg:Bool))
   (last_seen_time
    :reader last_seen_time
    :initarg :last_seen_time
    :type std_msgs-msg:Time
    :initform (cl:make-instance 'std_msgs-msg:Time))
   (topic_namespace
    :reader topic_namespace
    :initarg :topic_namespace
    :type std_msgs-msg:String
    :initform (cl:make-instance 'std_msgs-msg:String))
   (agent_ID
    :reader agent_ID
    :initarg :agent_ID
    :type cl:integer
    :initform 0))
)

(cl:defclass GraphSlamAgent (<GraphSlamAgent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GraphSlamAgent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GraphSlamAgent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<GraphSlamAgent> is deprecated: use mrpt_msgs-msg:GraphSlamAgent instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:name-val is deprecated.  Use mrpt_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'hostname-val :lambda-list '(m))
(cl:defmethod hostname-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:hostname-val is deprecated.  Use mrpt_msgs-msg:hostname instead.")
  (hostname m))

(cl:ensure-generic-function 'ip_addr-val :lambda-list '(m))
(cl:defmethod ip_addr-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:ip_addr-val is deprecated.  Use mrpt_msgs-msg:ip_addr instead.")
  (ip_addr m))

(cl:ensure-generic-function 'port-val :lambda-list '(m))
(cl:defmethod port-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:port-val is deprecated.  Use mrpt_msgs-msg:port instead.")
  (port m))

(cl:ensure-generic-function 'is_online-val :lambda-list '(m))
(cl:defmethod is_online-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:is_online-val is deprecated.  Use mrpt_msgs-msg:is_online instead.")
  (is_online m))

(cl:ensure-generic-function 'last_seen_time-val :lambda-list '(m))
(cl:defmethod last_seen_time-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:last_seen_time-val is deprecated.  Use mrpt_msgs-msg:last_seen_time instead.")
  (last_seen_time m))

(cl:ensure-generic-function 'topic_namespace-val :lambda-list '(m))
(cl:defmethod topic_namespace-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:topic_namespace-val is deprecated.  Use mrpt_msgs-msg:topic_namespace instead.")
  (topic_namespace m))

(cl:ensure-generic-function 'agent_ID-val :lambda-list '(m))
(cl:defmethod agent_ID-val ((m <GraphSlamAgent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:agent_ID-val is deprecated.  Use mrpt_msgs-msg:agent_ID instead.")
  (agent_ID m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GraphSlamAgent>) ostream)
  "Serializes a message object of type '<GraphSlamAgent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'name) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'hostname) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ip_addr) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'port)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'port)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'is_online) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'last_seen_time) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'topic_namespace) ostream)
  (cl:let* ((signed (cl:slot-value msg 'agent_ID)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GraphSlamAgent>) istream)
  "Deserializes a message object of type '<GraphSlamAgent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'name) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'hostname) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ip_addr) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'port)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'port)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'is_online) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'last_seen_time) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'topic_namespace) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'agent_ID) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GraphSlamAgent>)))
  "Returns string type for a message object of type '<GraphSlamAgent>"
  "mrpt_msgs/GraphSlamAgent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphSlamAgent)))
  "Returns string type for a message object of type 'GraphSlamAgent"
  "mrpt_msgs/GraphSlamAgent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GraphSlamAgent>)))
  "Returns md5sum for a message object of type '<GraphSlamAgent>"
  "6f5305e3be2b2f63220c0183a8af1288")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GraphSlamAgent)))
  "Returns md5sum for a message object of type 'GraphSlamAgent"
  "6f5305e3be2b2f63220c0183a8af1288")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GraphSlamAgent>)))
  "Returns full string definition for message of type '<GraphSlamAgent>"
  (cl:format cl:nil "# Connection-related properties for a graphSLAM agent in a multi-robot~%# environment.~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%std_msgs/String name~%std_msgs/String hostname~%~%# IPv4 of the corresponding agent~%std_msgs/String ip_addr~%~%# Port that the the roscore of the corresponding agent is running under~%uint16 port~%~%# True if the SLAM Agent was last reported to be online~%std_msgs/Bool is_online~%~%# Timestamp that the SLAM Agent was last seen~%std_msgs/Time last_seen_time~%~%# ROS Topics namespace that the agent is running under~%# By definition this is going to be the same as the *name*~%# UPDATE: Previously the topics namespace was <name>_<agent_ID>. However since I'll be using the multimaster for communication, every node is going to have a different ~%std_msgs/String topic_namespace~%~%# this is the last field of the IPv4 address of the corresponding agent~%# e.g. IP=192.168.100.17~%# agent_ID = 17~%int32 agent_ID ~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%================================================================================~%MSG: std_msgs/Time~%time data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GraphSlamAgent)))
  "Returns full string definition for message of type 'GraphSlamAgent"
  (cl:format cl:nil "# Connection-related properties for a graphSLAM agent in a multi-robot~%# environment.~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%std_msgs/String name~%std_msgs/String hostname~%~%# IPv4 of the corresponding agent~%std_msgs/String ip_addr~%~%# Port that the the roscore of the corresponding agent is running under~%uint16 port~%~%# True if the SLAM Agent was last reported to be online~%std_msgs/Bool is_online~%~%# Timestamp that the SLAM Agent was last seen~%std_msgs/Time last_seen_time~%~%# ROS Topics namespace that the agent is running under~%# By definition this is going to be the same as the *name*~%# UPDATE: Previously the topics namespace was <name>_<agent_ID>. However since I'll be using the multimaster for communication, every node is going to have a different ~%std_msgs/String topic_namespace~%~%# this is the last field of the IPv4 address of the corresponding agent~%# e.g. IP=192.168.100.17~%# agent_ID = 17~%int32 agent_ID ~%~%================================================================================~%MSG: std_msgs/String~%string data~%~%================================================================================~%MSG: std_msgs/Bool~%bool data~%================================================================================~%MSG: std_msgs/Time~%time data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GraphSlamAgent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'hostname))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ip_addr))
     2
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'is_online))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'last_seen_time))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'topic_namespace))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GraphSlamAgent>))
  "Converts a ROS message object to a list"
  (cl:list 'GraphSlamAgent
    (cl:cons ':name (name msg))
    (cl:cons ':hostname (hostname msg))
    (cl:cons ':ip_addr (ip_addr msg))
    (cl:cons ':port (port msg))
    (cl:cons ':is_online (is_online msg))
    (cl:cons ':last_seen_time (last_seen_time msg))
    (cl:cons ':topic_namespace (topic_namespace msg))
    (cl:cons ':agent_ID (agent_ID msg))
))
