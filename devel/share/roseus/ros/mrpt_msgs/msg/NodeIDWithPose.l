;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::NodeIDWithPose)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'NodeIDWithPose (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::NODEIDWITHPOSE")
  (make-package "MRPT_MSGS::NODEIDWITHPOSE"))

(in-package "ROS")
;;//! \htmlinclude NodeIDWithPose.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mrpt_msgs::NodeIDWithPose
  :super ros::object
  :slots (_nodeID _pose _str_ID _nodeID_loc ))

(defmethod mrpt_msgs::NodeIDWithPose
  (:init
   (&key
    ((:nodeID __nodeID) 0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:str_ID __str_ID) (instance std_msgs::String :init))
    ((:nodeID_loc __nodeID_loc) 0)
    )
   (send-super :init)
   (setq _nodeID (round __nodeID))
   (setq _pose __pose)
   (setq _str_ID __str_ID)
   (setq _nodeID_loc (round __nodeID_loc))
   self)
  (:nodeID
   (&optional __nodeID)
   (if __nodeID (setq _nodeID __nodeID)) _nodeID)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:str_ID
   (&rest __str_ID)
   (if (keywordp (car __str_ID))
       (send* _str_ID __str_ID)
     (progn
       (if __str_ID (setq _str_ID (car __str_ID)))
       _str_ID)))
  (:nodeID_loc
   (&optional __nodeID_loc)
   (if __nodeID_loc (setq _nodeID_loc __nodeID_loc)) _nodeID_loc)
  (:serialization-length
   ()
   (+
    ;; uint64 _nodeID
    8
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; std_msgs/String _str_ID
    (send _str_ID :serialization-length)
    ;; uint64 _nodeID_loc
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _nodeID
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _nodeID (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _nodeID) (= (length (_nodeID . bv)) 2)) ;; bignum
              (write-long (ash (elt (_nodeID . bv) 0) 0) s)
              (write-long (ash (elt (_nodeID . bv) 1) -1) s))
             ((and (class _nodeID) (= (length (_nodeID . bv)) 1)) ;; big1
              (write-long (elt (_nodeID . bv) 0) s)
              (write-long (if (>= _nodeID 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _nodeID s)(write-long (if (>= _nodeID 0) 0 #xffffffff) s)))
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; std_msgs/String _str_ID
       (send _str_ID :serialize s)
     ;; uint64 _nodeID_loc
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _nodeID_loc (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _nodeID_loc) (= (length (_nodeID_loc . bv)) 2)) ;; bignum
              (write-long (ash (elt (_nodeID_loc . bv) 0) 0) s)
              (write-long (ash (elt (_nodeID_loc . bv) 1) -1) s))
             ((and (class _nodeID_loc) (= (length (_nodeID_loc . bv)) 1)) ;; big1
              (write-long (elt (_nodeID_loc . bv) 0) s)
              (write-long (if (>= _nodeID_loc 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _nodeID_loc s)(write-long (if (>= _nodeID_loc 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _nodeID
     
#+(or :alpha :irix6 :x86_64)
      (setf _nodeID (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _nodeID (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; std_msgs/String _str_ID
     (send _str_ID :deserialize buf ptr-) (incf ptr- (send _str_ID :serialization-length))
   ;; uint64 _nodeID_loc
     
#+(or :alpha :irix6 :x86_64)
      (setf _nodeID_loc (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _nodeID_loc (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get mrpt_msgs::NodeIDWithPose :md5sum-) "87c8db37a689c10a5c5dc1aa39838320")
(setf (get mrpt_msgs::NodeIDWithPose :datatype-) "mrpt_msgs/NodeIDWithPose")
(setf (get mrpt_msgs::NodeIDWithPose :definition-)
      "# NodeID along with its corresponding 2D/3D pose estimation.
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



(provide :mrpt_msgs/NodeIDWithPose "87c8db37a689c10a5c5dc1aa39838320")


