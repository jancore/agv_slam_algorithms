;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::GraphSlamAgents)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'GraphSlamAgents (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::GRAPHSLAMAGENTS")
  (make-package "MRPT_MSGS::GRAPHSLAMAGENTS"))

(in-package "ROS")
;;//! \htmlinclude GraphSlamAgents.msg.html


(defclass mrpt_msgs::GraphSlamAgents
  :super ros::object
  :slots (_list ))

(defmethod mrpt_msgs::GraphSlamAgents
  (:init
   (&key
    ((:list __list) (let (r) (dotimes (i 0) (push (instance mrpt_msgs::GraphSlamAgent :init) r)) r))
    )
   (send-super :init)
   (setq _list __list)
   self)
  (:list
   (&rest __list)
   (if (keywordp (car __list))
       (send* _list __list)
     (progn
       (if __list (setq _list (car __list)))
       _list)))
  (:serialization-length
   ()
   (+
    ;; mrpt_msgs/GraphSlamAgent[] _list
    (apply #'+ (send-all _list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; mrpt_msgs/GraphSlamAgent[] _list
     (write-long (length _list) s)
     (dolist (elem _list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; mrpt_msgs/GraphSlamAgent[] _list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _list (let (r) (dotimes (i n) (push (instance mrpt_msgs::GraphSlamAgent :init) r)) r))
     (dolist (elem- _list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get mrpt_msgs::GraphSlamAgents :md5sum-) "ac3446e50a170e19b88734cb8e7206bb")
(setf (get mrpt_msgs::GraphSlamAgents :datatype-) "mrpt_msgs/GraphSlamAgents")
(setf (get mrpt_msgs::GraphSlamAgents :definition-)
      "# Defines vector of GraphSlamAgents.
# Currently used in the mrpt_graphslam_2d ROS application.

GraphSlamAgent[] list


================================================================================
MSG: mrpt_msgs/GraphSlamAgent
# Connection-related properties for a graphSLAM agent in a multi-robot
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



(provide :mrpt_msgs/GraphSlamAgents "ac3446e50a170e19b88734cb8e7206bb")


