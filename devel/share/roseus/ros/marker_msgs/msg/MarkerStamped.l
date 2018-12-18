;; Auto-generated. Do not edit!


(when (boundp 'marker_msgs::MarkerStamped)
  (if (not (find-package "MARKER_MSGS"))
    (make-package "MARKER_MSGS"))
  (shadow 'MarkerStamped (find-package "MARKER_MSGS")))
(unless (find-package "MARKER_MSGS::MARKERSTAMPED")
  (make-package "MARKER_MSGS::MARKERSTAMPED"))

(in-package "ROS")
;;//! \htmlinclude MarkerStamped.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marker_msgs::MarkerStamped
  :super ros::object
  :slots (_header _marker ))

(defmethod marker_msgs::MarkerStamped
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:marker __marker) (instance marker_msgs::Marker :init))
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
    ;; marker_msgs/Marker _marker
    (send _marker :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; marker_msgs/Marker _marker
       (send _marker :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; marker_msgs/Marker _marker
     (send _marker :deserialize buf ptr-) (incf ptr- (send _marker :serialization-length))
   ;;
   self)
  )

(setf (get marker_msgs::MarkerStamped :md5sum-) "4c1e18caf6e07b546965f552c7f69fcf")
(setf (get marker_msgs::MarkerStamped :datatype-) "marker_msgs/MarkerStamped")
(setf (get marker_msgs::MarkerStamped :definition-)
      "# An marker with reference coordinate frame and timestamp
Header header
Marker marker
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



(provide :marker_msgs/MarkerStamped "4c1e18caf6e07b546965f552c7f69fcf")


