;; Auto-generated. Do not edit!


(when (boundp 'marker_msgs::MarkerWithCovarianceStamped)
  (if (not (find-package "MARKER_MSGS"))
    (make-package "MARKER_MSGS"))
  (shadow 'MarkerWithCovarianceStamped (find-package "MARKER_MSGS")))
(unless (find-package "MARKER_MSGS::MARKERWITHCOVARIANCESTAMPED")
  (make-package "MARKER_MSGS::MARKERWITHCOVARIANCESTAMPED"))

(in-package "ROS")
;;//! \htmlinclude MarkerWithCovarianceStamped.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marker_msgs::MarkerWithCovarianceStamped
  :super ros::object
  :slots (_header _marker ))

(defmethod marker_msgs::MarkerWithCovarianceStamped
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:marker __marker) (instance marker_msgs::MarkerWithCovariance :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _marker __marker)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:marker
   (&rest __marker)
   (if (keywordp (car __marker))
       (send* _marker __marker)
     (progn
       (if __marker (setq _marker (car __marker)))
       _marker)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; marker_msgs/MarkerWithCovariance _marker
    (send _marker :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; marker_msgs/MarkerWithCovariance _marker
       (send _marker :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; marker_msgs/MarkerWithCovariance _marker
     (send _marker :deserialize buf ptr-) (incf ptr- (send _marker :serialization-length))
   ;;
   self)
  )

(setf (get marker_msgs::MarkerWithCovarianceStamped :md5sum-) "1c6b4e4db4f1f1f63303a467ab44aef6")
(setf (get marker_msgs::MarkerWithCovarianceStamped :datatype-) "marker_msgs/MarkerWithCovarianceStamped")
(setf (get marker_msgs::MarkerWithCovarianceStamped :definition-)
      "# This represents a marker with reference coordinate frame and timestamp and covariance matrix
Header header
MarkerWithCovariance marker
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id

================================================================================
MSG: marker_msgs/MarkerWithCovariance
# This expresses a marker in free space with uncertainty.

Marker marker

# Row-major representation of the 6x6 covariance matrix
# The orientation parameters use a fixed-axis representation.
# In order, the parameters are:
# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
float64[36] covariance

================================================================================
MSG: marker_msgs/Marker
# This expresses a marker/fiducial in a 3D space
int32[] ids                  # possible ids of the detected fiducial (empty if no id could be identified)
float64[] ids_confidence     # confidence of the possible ids in [0, 1]
geometry_msgs/Pose pose      # pose of the detected marker/fiducial

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



(provide :marker_msgs/MarkerWithCovarianceStamped "1c6b4e4db4f1f1f63303a467ab44aef6")


