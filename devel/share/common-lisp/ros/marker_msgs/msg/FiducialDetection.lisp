; Auto-generated. Do not edit!


(cl:in-package marker_msgs-msg)


;//! \htmlinclude FiducialDetection.msg.html

(cl:defclass <FiducialDetection> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (camera_d
    :reader camera_d
    :initarg :camera_d
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (camera_k
    :reader camera_k
    :initarg :camera_k
    :type (cl:vector cl:float)
   :initform (cl:make-array 9 :element-type 'cl:float :initial-element 0.0))
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (fiducial
    :reader fiducial
    :initarg :fiducial
    :type (cl:vector marker_msgs-msg:Fiducial)
   :initform (cl:make-array 0 :element-type 'marker_msgs-msg:Fiducial :initial-element (cl:make-instance 'marker_msgs-msg:Fiducial))))
)

(cl:defclass FiducialDetection (<FiducialDetection>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FiducialDetection>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FiducialDetection)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name marker_msgs-msg:<FiducialDetection> is deprecated: use marker_msgs-msg:FiducialDetection instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <FiducialDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:header-val is deprecated.  Use marker_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'camera_d-val :lambda-list '(m))
(cl:defmethod camera_d-val ((m <FiducialDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:camera_d-val is deprecated.  Use marker_msgs-msg:camera_d instead.")
  (camera_d m))

(cl:ensure-generic-function 'camera_k-val :lambda-list '(m))
(cl:defmethod camera_k-val ((m <FiducialDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:camera_k-val is deprecated.  Use marker_msgs-msg:camera_k instead.")
  (camera_k m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <FiducialDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:type-val is deprecated.  Use marker_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'fiducial-val :lambda-list '(m))
(cl:defmethod fiducial-val ((m <FiducialDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader marker_msgs-msg:fiducial-val is deprecated.  Use marker_msgs-msg:fiducial instead.")
  (fiducial m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FiducialDetection>) ostream)
  "Serializes a message object of type '<FiducialDetection>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'camera_d))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'camera_d))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'camera_k))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'fiducial))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'fiducial))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FiducialDetection>) istream)
  "Deserializes a message object of type '<FiducialDetection>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'camera_d) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'camera_d)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
  (cl:setf (cl:slot-value msg 'camera_k) (cl:make-array 9))
  (cl:let ((vals (cl:slot-value msg 'camera_k)))
    (cl:dotimes (i 9)
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
  (cl:setf (cl:slot-value msg 'fiducial) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'fiducial)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'marker_msgs-msg:Fiducial))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FiducialDetection>)))
  "Returns string type for a message object of type '<FiducialDetection>"
  "marker_msgs/FiducialDetection")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FiducialDetection)))
  "Returns string type for a message object of type 'FiducialDetection"
  "marker_msgs/FiducialDetection")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FiducialDetection>)))
  "Returns md5sum for a message object of type '<FiducialDetection>"
  "2ebb116fbde270de5551b0dc65e5f333")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FiducialDetection)))
  "Returns md5sum for a message object of type 'FiducialDetection"
  "2ebb116fbde270de5551b0dc65e5f333")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FiducialDetection>)))
  "Returns full string definition for message of type '<FiducialDetection>"
  (cl:format cl:nil "# This expresses a marker/fiducial detection~%Header header                  # timestamp in the header is the acquisition time and frame~%~%# The distortion parameters, size depending on the distortion model.~%# For \"plumb_bob\", the 5 parameters are: (k1, k2, t1, t2, k3).~%float64[] camera_d~%~%# Intrinsic camera matrix for the raw (distorted) images.~%#     [fx  0 cx]~%# K = [ 0 fy cy]~%#     [ 0  0  1]~%# Projects 3D points in the camera coordinate frame to 2D pixel~%# coordinates using the focal lengths (fx, fy) and principal point~%# (cx, cy).~%float64[9]  camera_k # 3x3 row-major matrix~%~%string   type                  # marker type used (bch, artag, mip_36h12, stage, ...)~%Fiducial[] fiducial            # detected markers~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: marker_msgs/Fiducial~%# This expresses a known detected fiducial in image space~%int32[] ids                         # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence            # confidence of the possible ids in [0, 1]~%geometry_msgs/Point[] object_points # Array of object points in the object coordinate space.~%geometry_msgs/Point[] image_points  # Array of corresponding image points. Point.z is not used.~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FiducialDetection)))
  "Returns full string definition for message of type 'FiducialDetection"
  (cl:format cl:nil "# This expresses a marker/fiducial detection~%Header header                  # timestamp in the header is the acquisition time and frame~%~%# The distortion parameters, size depending on the distortion model.~%# For \"plumb_bob\", the 5 parameters are: (k1, k2, t1, t2, k3).~%float64[] camera_d~%~%# Intrinsic camera matrix for the raw (distorted) images.~%#     [fx  0 cx]~%# K = [ 0 fy cy]~%#     [ 0  0  1]~%# Projects 3D points in the camera coordinate frame to 2D pixel~%# coordinates using the focal lengths (fx, fy) and principal point~%# (cx, cy).~%float64[9]  camera_k # 3x3 row-major matrix~%~%string   type                  # marker type used (bch, artag, mip_36h12, stage, ...)~%Fiducial[] fiducial            # detected markers~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: marker_msgs/Fiducial~%# This expresses a known detected fiducial in image space~%int32[] ids                         # possible ids of the detected fiducial (empty if no id could be identified)~%float64[] ids_confidence            # confidence of the possible ids in [0, 1]~%geometry_msgs/Point[] object_points # Array of object points in the object coordinate space.~%geometry_msgs/Point[] image_points  # Array of corresponding image points. Point.z is not used.~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FiducialDetection>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'camera_d) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'camera_k) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'fiducial) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FiducialDetection>))
  "Converts a ROS message object to a list"
  (cl:list 'FiducialDetection
    (cl:cons ':header (header msg))
    (cl:cons ':camera_d (camera_d msg))
    (cl:cons ':camera_k (camera_k msg))
    (cl:cons ':type (type msg))
    (cl:cons ':fiducial (fiducial msg))
))
