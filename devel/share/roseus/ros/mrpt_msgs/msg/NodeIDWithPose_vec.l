;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::NodeIDWithPose_vec)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'NodeIDWithPose_vec (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::NODEIDWITHPOSE_VEC")
  (make-package "MRPT_MSGS::NODEIDWITHPOSE_VEC"))

(in-package "ROS")
;;//! \htmlinclude NodeIDWithPose_vec.msg.html


(defclass mrpt_msgs::NodeIDWithPose_vec
  :super ros::object
  :slots (_vec ))

(defmethod mrpt_msgs::NodeIDWithPose_vec
  (:init
   (&key
    ((:vec __vec) (let (r) (dotimes (i 0) (push (instance mrpt_msgs::NodeIDWithPose :init) r)) r))
    )
   (send-super :init)
   (setq _vec __vec)
   self)
  (:vec
   (&rest __vec)
   (if (keywordp (car __vec))
       (send* _vec __vec)
     (progn
       (if __vec (setq _vec (car __vec)))
       _vec)))
  (:serialization-length
   ()
   (+
    ;; mrpt_msgs/NodeIDWithPose[] _vec
    (apply #'+ (send-all _vec :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; mrpt_msgs/NodeIDWithPose[] _vec
     (write-long (length _vec) s)
     (dolist (elem _vec)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; mrpt_msgs/NodeIDWithPose[] _vec
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vec (let (r) (dotimes (i n) (push (instance mrpt_msgs::NodeIDWithPose :init) r)) r))
     (dolist (elem- _vec)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get mrpt_msgs::NodeIDWithPose_vec :md5sum-) "f30000109eab9cc7bc6b44c3e86d9fac")
(setf (get mrpt_msgs::NodeIDWithPose_vec :datatype-) "mrpt_msgs/NodeIDWithPose_vec")
(setf (get mrpt_msgs::NodeIDWithPose_vec :definition-)
      "# Vector of NodeIDWithPose msgs

NodeIDWithPose[] vec


================================================================================
MSG: mrpt_msgs/NodeIDWithPose
# NodeID along with its corresponding 2D/3D pose estimation.
# Message also contains the following optional fields:
# - str_ID: string identifier of the robot agent that initially registered this node in
# its graph
# - nodeID_loc: ID of the current node in the graph it was initially registered in.
#
# note: Additional fields correspond to the fields of the
# mrpt::graphs::detail::TMRSlamNodeAnnotations struct
#
# Currently used in the mrpt_graphslam_2d ROS application.

uint64 nodeID
geometry_msgs/Pose pose

std_msgs/String str_ID
uint64 nodeID_loc

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: std_msgs/String
string data

")



(provide :mrpt_msgs/NodeIDWithPose_vec "f30000109eab9cc7bc6b44c3e86d9fac")


