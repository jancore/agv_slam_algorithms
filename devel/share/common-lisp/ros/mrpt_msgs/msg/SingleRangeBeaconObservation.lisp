; Auto-generated. Do not edit!


(cl:in-package mrpt_msgs-msg)


;//! \htmlinclude SingleRangeBeaconObservation.msg.html

(cl:defclass <SingleRangeBeaconObservation> (roslisp-msg-protocol:ros-message)
  ((range
    :reader range
    :initarg :range
    :type cl:float
    :initform 0.0)
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0))
)

(cl:defclass SingleRangeBeaconObservation (<SingleRangeBeaconObservation>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SingleRangeBeaconObservation>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SingleRangeBeaconObservation)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mrpt_msgs-msg:<SingleRangeBeaconObservation> is deprecated: use mrpt_msgs-msg:SingleRangeBeaconObservation instead.")))

(cl:ensure-generic-function 'range-val :lambda-list '(m))
(cl:defmethod range-val ((m <SingleRangeBeaconObservation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:range-val is deprecated.  Use mrpt_msgs-msg:range instead.")
  (range m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <SingleRangeBeaconObservation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mrpt_msgs-msg:id-val is deprecated.  Use mrpt_msgs-msg:id instead.")
  (id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SingleRangeBeaconObservation>) ostream)
  "Serializes a message object of type '<SingleRangeBeaconObservation>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'range))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SingleRangeBeaconObservation>) istream)
  "Deserializes a message object of type '<SingleRangeBeaconObservation>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'range) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SingleRangeBeaconObservation>)))
  "Returns string type for a message object of type '<SingleRangeBeaconObservation>"
  "mrpt_msgs/SingleRangeBeaconObservation")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SingleRangeBeaconObservation)))
  "Returns string type for a message object of type 'SingleRangeBeaconObservation"
  "mrpt_msgs/SingleRangeBeaconObservation")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SingleRangeBeaconObservation>)))
  "Returns md5sum for a message object of type '<SingleRangeBeaconObservation>"
  "1a4ad6d0080f2888716c1b8c7a297f62")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SingleRangeBeaconObservation)))
  "Returns md5sum for a message object of type 'SingleRangeBeaconObservation"
  "1a4ad6d0080f2888716c1b8c7a297f62")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SingleRangeBeaconObservation>)))
  "Returns full string definition for message of type '<SingleRangeBeaconObservation>"
  (cl:format cl:nil "#int32 INVALID_LANDMARK_ID = -1~%~%~%float64  range    # Distance, in meters.~%int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SingleRangeBeaconObservation)))
  "Returns full string definition for message of type 'SingleRangeBeaconObservation"
  (cl:format cl:nil "#int32 INVALID_LANDMARK_ID = -1~%~%~%float64  range    # Distance, in meters.~%int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SingleRangeBeaconObservation>))
  (cl:+ 0
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SingleRangeBeaconObservation>))
  "Converts a ROS message object to a list"
  (cl:list 'SingleRangeBeaconObservation
    (cl:cons ':range (range msg))
    (cl:cons ':id (id msg))
))
