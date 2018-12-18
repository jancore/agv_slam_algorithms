; Auto-generated. Do not edit!


(cl:in-package marker_msgs-msg)


;//! \htmlinclude MarkerDetection.msg.html

(cl:defclass <MarkerDetection> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (distance_min
    :reader distance_min
    :initarg :distance_min
    :type cl:float
    :initform 0.0)
   (distance_max
    :reader distance_max
    :initarg :distance_max
    :type cl:float
    :initform 0.0)
   (distance_max_id
    :reader distance_max_id
    :initarg :distance_max_id
    :type cl:float
    :initform 0.0)
   (view_direction
    :reader view_direction
    :initarg :view_direction
    :type geometry_msgs-msg:Quaternion
    :initform (cl:make-instance 'geometry_msgs-msg:Quaternion))
   (fov_horizontal
    :reader fov_horizontal
    :initarg :fov_horizontal
    :type cl:float
    :initform 0.0)
   (fov_vertical
    :reader fov_vertical
    :initarg :fov_vertical
    :type cl:float
    :initform 0.0)
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (markers
    :reader markers
    :initarg :markers
    :type (cl:vector marker_msgs-msg:Marker)
   :initform (cl:make-array 0 :element-type 'marker_msgs-msg:Marker :initial-element (cl:make-instance 'marker_msgs-msg:Marker))))
)

(cl:defclass MarkerDetection (<MarkerDetection>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerDetection>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerDetection)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marker_msgs-msg:<MarkerDetection> is deprecated: use marker_msgs-msg:MarkerDetection instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:header-val is deprecated.  Use marker_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'distance_min-val :lambda-list '(m))
(cl:defmethod distance_min-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:distance_min-val is deprecated.  Use marker_msgs-msg:distance_min instead.")
  (distance_min m))

(cl:ensure-generic-function 'distance_max-val :lambda-list '(m))
(cl:defmethod distance_max-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:distance_max-val is deprecated.  Use marker_msgs-msg:distance_max instead.")
  (distance_max m))

(cl:ensure-generic-function 'distance_max_id-val :lambda-list '(m))
(cl:defmethod distance_max_id-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:distance_max_id-val is deprecated.  Use marker_msgs-msg:distance_max_id instead.")
  (distance_max_id m))

(cl:ensure-generic-function 'view_direction-val :lambda-list '(m))
(cl:defmethod view_direction-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:view_direction-val is deprecated.  Use marker_msgs-msg:view_direction instead.")
  (view_direction m))

(cl:ensure-generic-function 'fov_horizontal-val :lambda-list '(m))
(cl:defmethod fov_horizontal-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:fov_horizontal-val is deprecated.  Use marker_msgs-msg:fov_horizontal instead.")
  (fov_horizontal m))

(cl:ensure-generic-function 'fov_vertical-val :lambda-list '(m))
(cl:defmethod fov_vertical-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:fov_vertical-val is deprecated.  Use marker_msgs-msg:fov_vertical instead.")
  (fov_vertical m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:type-val is deprecated.  Use marker_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'markers-val :lambda-list '(m))
(cl:defmethod markers-val ((m <MarkerDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:markers-val is deprecated.  Use marker_msgs-msg:markers instead.")
  (markers m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerDetection>) ostream)
  "Serializes a message object of type '<MarkerDetection>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance_min))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance_max))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance_max_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'view_direction) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fov_horizontal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fov_vertical))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'markers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'markers))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerDetection>) istream)
  "Deserializes a message object of type '<MarkerDetection>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_min) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_max) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_max_id) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'view_direction) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fov_horizontal) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fov_vertical) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'markers) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'markers)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'marker_msgs-msg:Marker))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerDetection>)))
  "Returns string type for a message object of type '<MarkerDetection>"
  "marker_msgs/MarkerDetection")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerDetection)))
  "Returns string type for a message object of type 'MarkerDetection"
  "marker_msgs/MarkerDetection")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerDetection>)))
  "Returns md5sum for a message object of type '<MarkerDetection>"
  "b17d48b7aeec842456674ad3657d85fc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerDetection)))
  "Returns md5sum for a message object of type 'MarkerDetection"
  "b17d48b7aeec842456674ad3657d85fc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerDetection>)))
  "Returns full string definition for message of type '<MarkerDetection>"
  (cl:format cl:nil "# This expresses a marker/fiducial detection~%Header header                  # timestamp in the header is the acquisition time and frame~%~%float32 distance_min           # distance minimum range value [m]~%float32 distance_max           # distance maximum range value [m]~%float32 distance_max_id        # distance maximum range value to detect id [m]~%~%geometry_msgs/Quaternion view_direction       # view direction~%float32 fov_horizontal                        # field of view horizontal [rad]~%float32 fov_vertical                          # field of view vertical [rad]~%~%string   type                  # marker type used (bch, artag, mip_36h12, stage, ...)~%Marker[] markers               # detected markers~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerDetection)))
  "Returns full string definition for message of type 'MarkerDetection"
  (cl:format cl:nil "# This expresses a marker/fiducial detection~%Header header                  # timestamp in the header is the acquisition time and frame~%~%float32 distance_min           # distance minimum range value [m]~%float32 distance_max           # distance maximum range value [m]~%float32 distance_max_id        # distance maximum range value to detect id [m]~%~%geometry_msgs/Quaternion view_direction       # view direction~%float32 fov_horizontal                        # field of view horizontal [rad]~%float32 fov_vertical                          # field of view vertical [rad]~%~%string   type                  # marker type used (bch, artag, mip_36h12, stage, ...)~%Marker[] markers               # detected markers~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: marker_msgs/Marker~%# This expresses a marker/fiducial in a 3D space~%int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence     # confidence of the possible ids in [0, 1]~%geometry_msgs/Pose pose      # pose of the detected marker/fiducial~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerDetection>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'view_direction))
     4
     4
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'markers) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerDetection>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerDetection
    (cl:cons ':header (header msg))
    (cl:cons ':distance_min (distance_min msg))
    (cl:cons ':distance_max (distance_max msg))
    (cl:cons ':distance_max_id (distance_max_id msg))
    (cl:cons ':view_direction (view_direction msg))
    (cl:cons ':fov_horizontal (fov_horizontal msg))
    (cl:cons ':fov_vertical (fov_vertical msg))
    (cl:cons ':type (type msg))
    (cl:cons ':markers (markers msg))
))
