;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::GraphSlamStats)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'GraphSlamStats (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::GRAPHSLAMSTATS")
  (make-package "MRPT_MSGS::GRAPHSLAMSTATS"))

(in-package "ROS")
;;//! \htmlinclude GraphSlamStats.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mrpt_msgs::GraphSlamStats
  :super ros::object
  :slots (_header _nodes_total _edges_total _edges_ICP2D _edges_ICP3D _edges_odom _loop_closures _slam_evaluation_metric ))

(defmethod mrpt_msgs::GraphSlamStats
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:nodes_total __nodes_total) 0)
    ((:edges_total __edges_total) 0)
    ((:edges_ICP2D __edges_ICP2D) 0)
    ((:edges_ICP3D __edges_ICP3D) 0)
    ((:edges_odom __edges_odom) 0)
    ((:loop_closures __loop_closures) 0)
    ((:slam_evaluation_metric __slam_evaluation_metric) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _header __header)
   (setq _nodes_total (round __nodes_total))
   (setq _edges_total (round __edges_total))
   (setq _edges_ICP2D (round __edges_ICP2D))
   (setq _edges_ICP3D (round __edges_ICP3D))
   (setq _edges_odom (round __edges_odom))
   (setq _loop_closures (round __loop_closures))
   (setq _slam_evaluation_metric __slam_evaluation_metric)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:nodes_total
   (&optional __nodes_total)
   (if __nodes_total (setq _nodes_total __nodes_total)) _nodes_total)
  (:edges_total
   (&optional __edges_total)
   (if __edges_total (setq _edges_total __edges_total)) _edges_total)
  (:edges_ICP2D
   (&optional __edges_ICP2D)
   (if __edges_ICP2D (setq _edges_ICP2D __edges_ICP2D)) _edges_ICP2D)
  (:edges_ICP3D
   (&optional __edges_ICP3D)
   (if __edges_ICP3D (setq _edges_ICP3D __edges_ICP3D)) _edges_ICP3D)
  (:edges_odom
   (&optional __edges_odom)
   (if __edges_odom (setq _edges_odom __edges_odom)) _edges_odom)
  (:loop_closures
   (&optional __loop_closures)
   (if __loop_closures (setq _loop_closures __loop_closures)) _loop_closures)
  (:slam_evaluation_metric
   (&optional __slam_evaluation_metric)
   (if __slam_evaluation_metric (setq _slam_evaluation_metric __slam_evaluation_metric)) _slam_evaluation_metric)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _nodes_total
    4
    ;; int32 _edges_total
    4
    ;; int32 _edges_ICP2D
    4
    ;; int32 _edges_ICP3D
    4
    ;; int32 _edges_odom
    4
    ;; int32 _loop_closures
    4
    ;; float64[] _slam_evaluation_metric
    (* 8    (length _slam_evaluation_metric)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _nodes_total
       (write-long _nodes_total s)
     ;; int32 _edges_total
       (write-long _edges_total s)
     ;; int32 _edges_ICP2D
       (write-long _edges_ICP2D s)
     ;; int32 _edges_ICP3D
       (write-long _edges_ICP3D s)
     ;; int32 _edges_odom
       (write-long _edges_odom s)
     ;; int32 _loop_closures
       (write-long _loop_closures s)
     ;; float64[] _slam_evaluation_metric
     (write-long (length _slam_evaluation_metric) s)
     (dotimes (i (length _slam_evaluation_metric))
       (sys::poke (elt _slam_evaluation_metric i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _nodes_total
     (setq _nodes_total (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _edges_total
     (setq _edges_total (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _edges_ICP2D
     (setq _edges_ICP2D (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _edges_ICP3D
     (setq _edges_ICP3D (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _edges_odom
     (setq _edges_odom (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _loop_closures
     (setq _loop_closures (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64[] _slam_evaluation_metric
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _slam_evaluation_metric (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _slam_evaluation_metric i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(setf (get mrpt_msgs::GraphSlamStats :md5sum-) "eacf2f0450892c9d53ce9dcaa0385298")
(setf (get mrpt_msgs::GraphSlamStats :datatype-) "mrpt_msgs/GraphSlamStats")
(setf (get mrpt_msgs::GraphSlamStats :definition-)
      "# Statistics related to the execution of graphSLAM.
# Message is utilized in the mrpt_graphslam ROS package

# Time of message acquisition
Header header

# node-related stats
int32 nodes_total

# edge-related stats
int32 edges_total
int32 edges_ICP2D
int32 edges_ICP3D
int32 edges_odom
int32 loop_closures

# Evaluation metric of the SLAM process
float64[] slam_evaluation_metric

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

")



(provide :mrpt_msgs/GraphSlamStats "eacf2f0450892c9d53ce9dcaa0385298")


