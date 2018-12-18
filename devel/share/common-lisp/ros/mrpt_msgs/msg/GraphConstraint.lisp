; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude GraphConstraint.msg.html

(cl:defclass <GraphConstraint> (roslisp-msg-protocol:ros-message)
  ((nodeID_from
    :reader nodeID_from
    :initarg :nodeID_from
    :type cl:integer
    :initform 0)
   (nodeID_to
    :reader nodeID_to
    :initarg :nodeID_to
    :type cl:integer
    :initform 0)
   (constraint
    :reader constraint
    :initarg :constraint
    :type geometry_msgs-msg:PoseWithCovariance
    :initform (cl:make-instance 'geometry_msgs-msg:PoseWithCovariance)))
)

(cl:defclass GraphConstraint (<GraphConstraint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GraphConstraint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GraphConstraint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<GraphConstraint> is deprecated: use mrpt_msgs-msg:GraphConstraint instead.")))

(cl:ensure-generic-function 'nodeID_from-val :lambda-list '(m))
(cl:defmethod nodeID_from-val ((m <GraphConstraint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:nodeID_from-val is deprecated.  Use mrpt_msgs-msg:nodeID_from instead.")
  (nodeID_from m))

(cl:ensure-generic-function 'nodeID_to-val :lambda-list '(m))
(cl:defmethod nodeID_to-val ((m <GraphConstraint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:nodeID_to-val is deprecated.  Use mrpt_msgs-msg:nodeID_to instead.")
  (nodeID_to m))

(cl:ensure-generic-function 'constraint-val :lambda-list '(m))
(cl:defmethod constraint-val ((m <GraphConstraint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:constraint-val is deprecated.  Use mrpt_msgs-msg:constraint instead.")
  (constraint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GraphConstraint>) ostream)
  "Serializes a message object of type '<GraphConstraint>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID_from)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID_to)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID_to)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'constraint) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GraphConstraint>) istream)
  "Deserializes a message object of type '<GraphConstraint>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID_from)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'nodeID_to)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'constraint) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GraphConstraint>)))
  "Returns string type for a message object of type '<GraphConstraint>"
  "mrpt_msgs/GraphConstraint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GraphConstraint)))
  "Returns string type for a message object of type 'GraphConstraint"
  "mrpt_msgs/GraphConstraint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GraphConstraint>)))
  "Returns md5sum for a message object of type '<GraphConstraint>"
  "27a8223828dcd501cdc97873eecdd09e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GraphConstraint)))
  "Returns md5sum for a message object of type 'GraphConstraint"
  "27a8223828dcd501cdc97873eecdd09e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GraphConstraint>)))
  "Returns full string definition for message of type '<GraphConstraint>"
  (cl:format cl:nil "# Graph constraint that connects 2 nodes~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID_from~%uint64 nodeID_to~%geometry_msgs/PoseWithCovariance constraint~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GraphConstraint)))
  "Returns full string definition for message of type 'GraphConstraint"
  (cl:format cl:nil "# Graph constraint that connects 2 nodes~%#~%# Currently used in the mrpt_graphslam_2d ROS application.~%~%uint64 nodeID_from~%uint64 nodeID_to~%geometry_msgs/PoseWithCovariance constraint~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GraphConstraint>))
  (cl:+ 0
     8
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'constraint))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GraphConstraint>))
  "Converts a ROS message object to a list"
  (cl:list 'GraphConstraint
    (cl:cons ':nodeID_from (nodeID_from msg))
    (cl:cons ':nodeID_to (nodeID_to msg))
    (cl:cons ':constraint (constraint msg))
))
