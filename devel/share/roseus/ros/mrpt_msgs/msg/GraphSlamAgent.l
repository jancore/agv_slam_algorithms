;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::GraphSlamAgent)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'GraphSlamAgent (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::GRAPHSLAMAGENT")
  (make-package "MRPT_MSGS::GRAPHSLAMAGENT"))

(in-package "ROS")
;;//! \htmlinclude GraphSlamAgent.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mrpt_msgs::GraphSlamAgent
  :super ros::object
  :slots (_name _hostname _ip_addr _port _is_online _last_seen_time _topic_namespace _agent_ID ))

(defmethod mrpt_msgs::GraphSlamAgent
  (:init
   (&key
    ((:name __name) (instance std_msgs::String :init))
    ((:hostname __hostname) (instance std_msgs::String :init))
    ((:ip_addr __ip_addr) (instance std_msgs::String :init))
    ((:port __port) 0)
    ((:is_online __is_online) (instance std_msgs::Bool :init))
    ((:last_seen_time __last_seen_time) (instance std_msgs::Time :init))
    ((:topic_namespace __topic_namespace) (instance std_msgs::String :init))
    ((:agent_ID __agent_ID) 0)
    )
   (send-super :init)
   (setq _name __name)
   (setq _hostname __hostname)
   (setq _ip_addr __ip_addr)
   (setq _port (round __port))
   (setq _is_online __is_online)
   (setq _last_seen_time __last_seen_time)
   (setq _topic_namespace __topic_namespace)
   (setq _agent_ID (round __agent_ID))
   self)
  (:name
   (&rest __name)
   (if (keywordp (car __name))
       (send* _name __name)
     (progn
       (if __name (setq _name (car __name)))
       _name)))
  (:hostname
   (&rest __hostname)
   (if (keywordp (car __hostname))
       (send* _hostname __hostname)
     (progn
       (if __hostname (setq _hostname (car __hostname)))
       _hostname)))
  (:ip_addr
   (&rest __ip_addr)
   (if (keywordp (car __ip_addr))
       (send* _ip_addr __ip_addr)
     (progn
       (if __ip_addr (setq _ip_addr (car __ip_addr)))
       _ip_addr)))
  (:port
   (&optional __port)
   (if __port (setq _port __port)) _port)
  (:is_online
   (&rest __is_online)
   (if (keywordp (car __is_online))
       (send* _is_online __is_online)
     (progn
       (if __is_online (setq _is_online (car __is_online)))
       _is_online)))
  (:last_seen_time
   (&rest __last_seen_time)
   (if (keywordp (car __last_seen_time))
       (send* _last_seen_time __last_seen_time)
     (progn
       (if __last_seen_time (setq _last_seen_time (car __last_seen_time)))
       _last_seen_time)))
  (:topic_namespace
   (&rest __topic_namespace)
   (if (keywordp (car __topic_namespace))
       (send* _topic_namespace __topic_namespace)
     (progn
       (if __topic_namespace (setq _topic_namespace (car __topic_namespace)))
       _topic_namespace)))
  (:agent_ID
   (&optional __agent_ID)
   (if __agent_ID (setq _agent_ID __agent_ID)) _agent_ID)
  (:serialization-length
   ()
   (+
    ;; std_msgs/String _name
    (send _name :serialization-length)
    ;; std_msgs/String _hostname
    (send _hostname :serialization-length)
    ;; std_msgs/String _ip_addr
    (send _ip_addr :serialization-length)
    ;; uint16 _port
    2
    ;; std_msgs/Bool _is_online
    (send _is_online :serialization-length)
    ;; std_msgs/Time _last_seen_time
    (send _last_seen_time :serialization-length)
    ;; std_msgs/String _topic_namespace
    (send _topic_namespace :serialization-length)
    ;; int32 _agent_ID
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/String _name
       (send _name :serialize s)
     ;; std_msgs/String _hostname
       (send _hostname :serialize s)
     ;; std_msgs/String _ip_addr
       (send _ip_addr :serialize s)
     ;; uint16 _port
       (write-word _port s)
     ;; std_msgs/Bool _is_online
       (send _is_online :serialize s)
     ;; std_msgs/Time _last_seen_time
       (send _last_seen_time :serialize s)
     ;; std_msgs/String _topic_namespace
       (send _topic_namespace :serialize s)
     ;; int32 _agent_ID
       (write-long _agent_ID s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/String _name
     (send _name :deserialize buf ptr-) (incf ptr- (send _name :serialization-length))
   ;; std_msgs/String _hostname
     (send _hostname :deserialize buf ptr-) (incf ptr- (send _hostname :serialization-length))
   ;; std_msgs/String _ip_addr
     (send _ip_addr :deserialize buf ptr-) (incf ptr- (send _ip_addr :serialization-length))
   ;; uint16 _port
     (setq _port (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; std_msgs/Bool _is_online
     (send _is_online :deserialize buf ptr-) (incf ptr- (send _is_online :serialization-length))
   ;; std_msgs/Time _last_seen_time
     (send _last_seen_time :deserialize buf ptr-) (incf ptr- (send _last_seen_time :serialization-length))
   ;; std_msgs/String _topic_namespace
     (send _topic_namespace :deserialize buf ptr-) (incf ptr- (send _topic_namespace :serialization-length))
   ;; int32 _agent_ID
     (setq _agent_ID (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get mrpt_msgs::GraphSlamAgent :md5sum-) "6f5305e3be2b2f63220c0183a8af1288")
(setf (get mrpt_msgs::GraphSlamAgent :datatype-) "mrpt_msgs/GraphSlamAgent")
(setf (get mrpt_msgs::GraphSlamAgent :definition-)
      "# Connection-related properties for a graphSLAM agent in a multi-robot
# environment.
#
# Currently used in the mrpt_graphslam_2d ROS application.

std_msgs/String name
std_msgs/String hostname

# IPv4 of the corresponding agent
std_msgs/String ip_addr

# Port that the the roscore of the corresponding agent is running under
uint16 port

# True if the SLAM Agent was last reported to be online
std_msgs/Bool is_online

# Timestamp that the SLAM Agent was last seen
std_msgs/Time last_seen_time

# ROS Topics namespace that the agent is running under
# By definition this is going to be the same as the *name*
# UPDATE: Previously the topics namespace was <name>_<agent_ID>. However since I'll be using the multimaster for communication, every node is going to have a different 
std_msgs/String topic_namespace

# this is the last field of the IPv4 address of the corresponding agent
# e.g. IP=192.168.100.17
# agent_ID = 17
int32 agent_ID 

================================================================================
MSG: std_msgs/String
string data

================================================================================
MSG: std_msgs/Bool
bool data
================================================================================
MSG: std_msgs/Time
time data

")



(provide :mrpt_msgs/GraphSlamAgent "6f5305e3be2b2f63220c0183a8af1288")


