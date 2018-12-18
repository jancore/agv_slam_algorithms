;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::GraphConstraint)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'GraphConstraint (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::GRAPHCONSTRAINT")
  (make-package "MRPT_MSGS::GRAPHCONSTRAINT"))

(in-package "ROS")
;;//! \htmlinclude GraphConstraint.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass mrpt_msgs::GraphConstraint
  :super ros::object
  :slots (_nodeID_from _nodeID_to _constraint ))

(defmethod mrpt_msgs::GraphConstraint
  (:init
   (&key
    ((:nodeID_from __nodeID_from) 0)
    ((:nodeID_to __nodeID_to) 0)
    ((:constraint __constraint) (instance geometry_msgs::PoseWithCovariance :init))
    )
   (send-super :init)
   (setq _nodeID_from (round __nodeID_from))
   (setq _nodeID_to (round __nodeID_to))
   (setq _constraint __constraint)
   self)
  (:nodeID_from
   (&optional __nodeID_from)
   (if __nodeID_from (setq _nodeID_from __nodeID_from)) _nodeID_from)
  (:nodeID_to
   (&optional __nodeID_to)
   (if __nodeID_to (setq _nodeID_to __nodeID_to)) _nodeID_to)
  (:constraint
   (&rest __constraint)
   (if (keywordp (car __constraint))
       (send* _constraint __constraint)
     (progn
       (if __constraint (setq _constraint (car __constraint)))
       _constraint)))
  (:serialization-length
   ()
   (+
    ;; uint64 _nodeID_from
    8
    ;; uint64 _nodeID_to
    8
    ;; geometry_msgs/PoseWithCovariance _constraint
    (send _constraint :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _nodeID_from
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _nodeID_from (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _nodeID_from) (= (length (_nodeID_from . bv)) 2)) ;; bignum
              (write-long (ash (elt (_nodeID_from . bv) 0) 0) s)
              (write-long (ash (elt (_nodeID_from . bv) 1) -1) s))
             ((and (class _nodeID_from) (= (length (_nodeID_from . bv)) 1)) ;; big1
              (write-long (elt (_nodeID_from . bv) 0) s)
              (write-long (if (>= _nodeID_from 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _nodeID_from s)(write-long (if (>= _nodeID_from 0) 0 #xffffffff) s)))
     ;; uint64 _nodeID_to
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _nodeID_to (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _nodeID_to) (= (length (_nodeID_to . bv)) 2)) ;; bignum
              (write-long (ash (elt (_nodeID_to . bv) 0) 0) s)
              (write-long (ash (elt (_nodeID_to . bv) 1) -1) s))
             ((and (class _nodeID_to) (= (length (_nodeID_to . bv)) 1)) ;; big1
              (write-long (elt (_nodeID_to . bv) 0) s)
              (write-long (if (>= _nodeID_to 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _nodeID_to s)(write-long (if (>= _nodeID_to 0) 0 #xffffffff) s)))
     ;; geometry_msgs/PoseWithCovariance _constraint
       (send _constraint :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _nodeID_from
     
#+(or :alpha :irix6 :x86_64)
      (setf _nodeID_from (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _nodeID_from (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; uint64 _nodeID_to
     
#+(or :alpha :irix6 :x86_64)
      (setf _nodeID_to (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _nodeID_to (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; geometry_msgs/PoseWithCovariance _constraint
     (send _constraint :deserialize buf ptr-) (incf ptr- (send _constraint :serialization-length))
   ;;
   self)
  )

(setf (get mrpt_msgs::GraphConstraint :md5sum-) "27a8223828dcd501cdc97873eecdd09e")
(setf (get mrpt_msgs::GraphConstraint :datatype-) "mrpt_msgs/GraphConstraint")
(setf (get mrpt_msgs::GraphConstraint :definition-)
      "# Graph constraint that connects 2 nodes
#
# Currently used in the mrpt_graphslam_2d ROS application.

uint64 nodeID_from
uint64 nodeID_to
geometry_msgs/PoseWithCovariance constraint

================================================================================
MSG: geometry_msgs/PoseWithCovariance
# This represents a pose in free space with uncertainty.

Pose pose

# Row-major representation of the 6x6 covariance matrix
# The orientation parameters use a fixed-axis representation.
# In order, the parameters are:
# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
float64[36] covariance

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

")



(provide :mrpt_msgs/GraphConstraint "27a8223828dcd501cdc97873eecdd09e")


