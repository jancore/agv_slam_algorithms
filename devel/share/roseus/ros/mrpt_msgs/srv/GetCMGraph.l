;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::GetCMGraph)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'GetCMGraph (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::GETCMGRAPH")
  (make-package "MRPT_MSGS::GETCMGRAPH"))
(unless (find-package "MRPT_MSGS::GETCMGRAPHREQUEST")
  (make-package "MRPT_MSGS::GETCMGRAPHREQUEST"))
(unless (find-package "MRPT_MSGS::GETCMGRAPHRESPONSE")
  (make-package "MRPT_MSGS::GETCMGRAPHRESPONSE"))

(in-package "ROS")





(defclass mrpt_msgs::GetCMGraphRequest
  :super ros::object
  :slots (_nodeIDs ))

(defmethod mrpt_msgs::GetCMGraphRequest
  (:init
   (&key
    ((:nodeIDs __nodeIDs) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _nodeIDs __nodeIDs)
   self)
  (:nodeIDs
   (&optional __nodeIDs)
   (if __nodeIDs (setq _nodeIDs __nodeIDs)) _nodeIDs)
  (:serialization-length
   ()
   (+
    ;; uint64[] _nodeIDs
    (* 8    (length _nodeIDs)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64[] _nodeIDs
     (write-long (length _nodeIDs) s)
     (dotimes (i (length _nodeIDs))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _nodeIDs i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _nodeIDs i)) (= (length ((elt _nodeIDs i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _nodeIDs i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _nodeIDs i) . bv) 1) -1) s))
             ((and (class (elt _nodeIDs i)) (= (length ((elt _nodeIDs i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _nodeIDs i) . bv) 0) s)
              (write-long (if (>= (elt _nodeIDs i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _nodeIDs i) s)(write-long (if (>= (elt _nodeIDs i) 0) 0 #xffffffff) s)))
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64[] _nodeIDs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _nodeIDs (instantiate integer-vector n))
     (dotimes (i n)
     
#+(or :alpha :irix6 :x86_64)
      (setf (elt _nodeIDs i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _nodeIDs i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;;
   self)
  )

(defclass mrpt_msgs::GetCMGraphResponse
  :super ros::object
  :slots (_cm_graph ))

(defmethod mrpt_msgs::GetCMGraphResponse
  (:init
   (&key
    ((:cm_graph __cm_graph) (instance mrpt_msgs::NetworkOfPoses :init))
    )
   (send-super :init)
   (setq _cm_graph __cm_graph)
   self)
  (:cm_graph
   (&rest __cm_graph)
   (if (keywordp (car __cm_graph))
       (send* _cm_graph __cm_graph)
     (progn
       (if __cm_graph (setq _cm_graph (car __cm_graph)))
       _cm_graph)))
  (:serialization-length
   ()
   (+
    ;; mrpt_msgs/NetworkOfPoses _cm_graph
    (send _cm_graph :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; mrpt_msgs/NetworkOfPoses _cm_graph
       (send _cm_graph :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; mrpt_msgs/NetworkOfPoses _cm_graph
     (send _cm_graph :deserialize buf ptr-) (incf ptr- (send _cm_graph :serialization-length))
   ;;
   self)
  )

(defclass mrpt_msgs::GetCMGraph
  :super ros::object
  :slots ())

(setf (get mrpt_msgs::GetCMGraph :md5sum-) "42fe1c3f75b229167d9c830777c38406")
(setf (get mrpt_msgs::GetCMGraph :datatype-) "mrpt_msgs/GetCMGraph")
(setf (get mrpt_msgs::GetCMGraph :request) mrpt_msgs::GetCMGraphRequest)
(setf (get mrpt_msgs::GetCMGraph :response) mrpt_msgs::GetCMGraphResponse)

(defmethod mrpt_msgs::GetCMGraphRequest
  (:response () (instance mrpt_msgs::GetCMGraphResponse :init)))

(setf (get mrpt_msgs::GetCMGraphRequest :md5sum-) "42fe1c3f75b229167d9c830777c38406")
(setf (get mrpt_msgs::GetCMGraphRequest :datatype-) "mrpt_msgs/GetCMGraphRequest")
(setf (get mrpt_msgs::GetCMGraphRequest :definition-)
      "



uint64[] nodeIDs
---
mrpt_msgs/NetworkOfPoses cm_graph


================================================================================
MSG: mrpt_msgs/NetworkOfPoses
# Represents a 2D/3D Directed Graph of Constraints
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

(setf (get mrpt_msgs::GetCMGraphResponse :md5sum-) "42fe1c3f75b229167d9c830777c38406")
(setf (get mrpt_msgs::GetCMGraphResponse :datatype-) "mrpt_msgs/GetCMGraphResponse")
(setf (get mrpt_msgs::GetCMGraphResponse :definition-)
      "



uint64[] nodeIDs
---
mrpt_msgs/NetworkOfPoses cm_graph


================================================================================
MSG: mrpt_msgs/NetworkOfPoses
# Represents a 2D/3D Directed Graph of Constraints
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



(provide :mrpt_msgs/GetCMGraph "42fe1c3f75b229167d9c830777c38406")


