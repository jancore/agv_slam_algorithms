; Auto-generated. Do not edit!


(cl:in-package marker_msgs-msg)


;//! \htmlinclude MarkerWithCovariance.msg.html

(cl:defclass <MarkerWithCovariance> (roslisp-msg-protocol:ros-message)
  ((marker
    :reader marker
    :initarg :marker
    :type marker_msgs-msg:Marker
    :initform (cl:make-instance 'marker_msgs-msg:Marker))
   (covariance
    :reader covariance
    :initarg :covariance
    :type (cl:vector cl:float)
   :initform (cl:make-array 36 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass MarkerWithCovariance (<MarkerWithCovariance>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerWithCovariance>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerWithCovariance)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marker_msgs-msg:<MarkerWithCovariance> is deprecated: use marker_msgs-msg:MarkerWithCovariance instead.")))

(cl:ensure-generic-function 'marker-val :lambda-list '(m))
(cl:defmethod marker-val ((m <MarkerWithCovariance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:marker-val is deprecated.  Use marker_msgs-msg:marker instead.")
  (marker m))

(cl:ensure-generic-function 'covariance-val :lambda-list '(m))
(cl:defmethod covariance-val ((m <MarkerWithCovariance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:covariance-val is deprecated.  Use marker_msgs-msg:covariance instead.")
  (covariance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerWithCovariance>) ostream)
  "Serializes a message object of type '<MarkerWithCovariance>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'marker) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'covariance))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerWithCovariance>) istream)
  "Deserializes a message object of type '<MarkerWithCovariance>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'marker) istream)
  (cl:setf (cl:slot-value msg 'covariance) (cl:make-array 36))
  (cl:let ((vals (cl:slot-value msg 'covariance)))
    (cl:dotimes (i 36)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerWithCovariance>)))
  "Returns string type for a message object of type '<MarkerWithCovariance>"
  "marker_msgs/MarkerWithCovariance")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerWithCovariance)))
  "Returns string type for a message object of type 'MarkerWithCovariance"
  "marker_msgs/MarkerWithCovariance")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerWithCovariance>)))
  "Returns md5sum for a message object of type '<MarkerWithCovariance>"
  "ace241bc4ec8f4b399c13e05763be31a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerWithCovariance)))
  "Returns md5sum for a message object of type 'MarkerWithCovariance"
  "ace241bc4ec8f4b399c13e05763be31a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerWithCovariance>)))
  "Returns full string definition for message of type '<MarkerWithCovariance>"
  (cl:format cl:nil "# This expresses a marker in free space with uncertainty.~%~%Marker marker~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerWithCovariance)))
  "Returns full string definition for message of type 'MarkerWithCovariance"
  (cl:format cl:nil "# This expresses a marker in free space with uncertainty.~%~%Marker marker~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerWithCovariance>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'marker))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'covariance) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerWithCovariance>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerWithCovariance
    (cl:cons ':marker (marker msg))
    (cl:cons ':covariance (covariance msg))
))
