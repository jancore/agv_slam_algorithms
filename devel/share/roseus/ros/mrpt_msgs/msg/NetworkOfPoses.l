;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::NetworkOfPoses)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'NetworkOfPoses (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::NETWORKOFPOSES")
  (make-package "MRPT_MSGS::NETWORKOFPOSES"))

(in-package "ROS")
;;//! \htmlinclude NetworkOfPoses.msg.html


(defclass mrpt_msgs::NetworkOfPoses
  :super ros::object
  :slots (_root _nodes _constraints ))

(defmethod mrpt_msgs::NetworkOfPoses
  (:init
   (&key
    ((:root __root) 0)
    ((:nodes __nodes) (instance mrpt_msgs::NodeIDWithPose_vec :init))
    ((:constraints __constraints) (let (r) (dotimes (i 0) (push (instance mrpt_msgs::GraphConstraint :init) r)) r))
    )
   (send-super :init)
   (setq _root (round __root))
   (setq _nodes __nodes)
   (setq _constraints __constraints)
   self)
  (:root
   (&optional __root)
   (if __root (setq _root __root)) _root)
  (:nodes
   (&rest __nodes)
   (if (keywordp (car __nodes))
       (send* _nodes __nodes)
     (progn
       (if __nodes (setq _nodes (car __nodes)))
       _nodes)))
  (:constraints
   (&rest __constraints)
   (if (keywordp (car __constraints))
       (send* _constraints __constraints)
     (progn
       (if __constraints (setq _constraints (car __constraints)))
       _constraints)))
  (:serialization-length
   ()
   (+
    ;; uint64 _root
    8
    ;; mrpt_msgs/NodeIDWithPose_vec _nodes
    (send _nodes :serialization-length)
    ;; mrpt_msgs/GraphConstraint[] _constraints
    (apply #'+ (send-all _constraints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _root
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _root (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _root) (= (length (_root . bv)) 2)) ;; bignum
              (write-long (ash (elt (_root . bv) 0) 0) s)
              (write-long (ash (elt (_root . bv) 1) -1) s))
             ((and (class _root) (= (length (_root . bv)) 1)) ;; big1
              (write-long (elt (_root . bv) 0) s)
              (write-long (if (>= _root 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _root s)(write-long (if (>= _root 0) 0 #xffffffff) s)))
     ;; mrpt_msgs/NodeIDWithPose_vec _nodes
       (send _nodes :serialize s)
     ;; mrpt_msgs/GraphConstraint[] _constraints
     (write-long (length _constraints) s)
     (dolist (elem _constraints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _root
     
#+(or :alpha :irix6 :x86_64)
      (setf _root (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _root (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; mrpt_msgs/NodeIDWithPose_vec _nodes
     (send _nodes :deserialize buf ptr-) (incf ptr- (send _nodes :serialization-length))
   ;; mrpt_msgs/GraphConstraint[] _constraints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _constraints (let (r) (dotimes (i n) (push (instance mrpt_msgs::GraphConstraint :init) r)) r))
     (dolist (elem- _constraints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get mrpt_msgs::NetworkOfPoses :md5sum-) "2f7e17a78e81d376b3e999d635df4228")
(setf (get mrpt_msgs::NetworkOfPoses :datatype-) "mrpt_msgs/NetworkOfPoses")
(setf (get mrpt_msgs::NetworkOfPoses :definition-)
      "# Represents a 2D/3D Directed Graph of Constraints
#
# Graph consists of:
# - NodeIDs with their corresponding poses
# - Directed Constraints that connect 2 nodes with each other
# - Root node marking the start of the graph

uint64 root
NodeIDWithPose_vec nodes
GraphConstraint[] constraints

================================================================================
MSG: mrpt_msgs/NodeIDWithPose_vec
# Vector of NodeIDWithPose msgs

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

================================================================================
MSG: mrpt_msgs/GraphConstraint
# Graph constraint that connects 2 nodes
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

")



(provide :mrpt_msgs/NetworkOfPoses "2f7e17a78e81d376b3e999d635df4228")


