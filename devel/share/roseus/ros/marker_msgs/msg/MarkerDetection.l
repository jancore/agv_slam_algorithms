;; Auto-generated. Do not edit!


(when (boundp 'marker_msgs::MarkerDetection)
  (if (not (find-package "MARKER_MSGS"))
    (make-package "MARKER_MSGS"))
  (shadow 'MarkerDetection (find-package "MARKER_MSGS")))
(unless (find-package "MARKER_MSGS::MARKERDETECTION")
  (make-package "MARKER_MSGS::MARKERDETECTION"))

(in-package "ROS")
;;//! \htmlinclude MarkerDetection.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marker_msgs::MarkerDetection
  :super ros::object
  :slots (_header _distance_min _distance_max _distance_max_id _view_direction _fov_horizontal _fov_vertical _type _markers ))

(defmethod marker_msgs::MarkerDetection
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:distance_min __distance_min) 0.0)
    ((:distance_max __distance_max) 0.0)
    ((:distance_max_id __distance_max_id) 0.0)
    ((:view_direction __view_direction) (instance geometry_msgs::Quaternion :init))
    ((:fov_horizontal __fov_horizontal) 0.0)
    ((:fov_vertical __fov_vertical) 0.0)
    ((:type __type) "")
    ((:markers __markers) (let (r) (dotimes (i 0) (push (instance marker_msgs::Marker :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _distance_min (float __distance_min))
   (setq _distance_max (float __distance_max))
   (setq _distance_max_id (float __distance_max_id))
   (setq _view_direction __view_direction)
   (setq _fov_horizontal (float __fov_horizontal))
   (setq _fov_vertical (float __fov_vertical))
   (setq _type (string __type))
   (setq _markers __markers)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:distance_min
   (&optional __distance_min)
   (if __distance_min (setq _distance_min __distance_min)) _distance_min)
  (:distance_max
   (&optional __distance_max)
   (if __distance_max (setq _distance_max __distance_max)) _distance_max)
  (:distance_max_id
   (&optional __distance_max_id)
   (if __distance_max_id (setq _distance_max_id __distance_max_id)) _distance_max_id)
  (:view_direction
   (&rest __view_direction)
   (if (keywordp (car __view_direction))
       (send* _view_direction __view_direction)
     (progn
       (if __view_direction (setq _view_direction (car __view_direction)))
       _view_direction)))
  (:fov_horizontal
   (&optional __fov_horizontal)
   (if __fov_horizontal (setq _fov_horizontal __fov_horizontal)) _fov_horizontal)
  (:fov_vertical
   (&optional __fov_vertical)
   (if __fov_vertical (setq _fov_vertical __fov_vertical)) _fov_vertical)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:markers
   (&rest __markers)
   (if (keywordp (car __markers))
       (send* _markers __markers)
     (progn
       (if __markers (setq _markers (car __markers)))
       _markers)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _distance_min
    4
    ;; float32 _distance_max
    4
    ;; float32 _distance_max_id
    4
    ;; geometry_msgs/Quaternion _view_direction
    (send _view_direction :serialization-length)
    ;; float32 _fov_horizontal
    4
    ;; float32 _fov_vertical
    4
    ;; string _type
    4 (length _type)
    ;; marker_msgs/Marker[] _markers
    (apply #'+ (send-all _markers :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _distance_min
       (sys::poke _distance_min (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _distance_max
       (sys::poke _distance_max (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _distance_max_id
       (sys::poke _distance_max_id (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Quaternion _view_direction
       (send _view_direction :serialize s)
     ;; float32 _fov_horizontal
       (sys::poke _fov_horizontal (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fov_vertical
       (sys::poke _fov_vertical (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; marker_msgs/Marker[] _markers
     (write-long (length _markers) s)
     (dolist (elem _markers)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _distance_min
     (setq _distance_min (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _distance_max
     (setq _distance_max (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _distance_max_id
     (setq _distance_max_id (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Quaternion _view_direction
     (send _view_direction :deserialize buf ptr-) (incf ptr- (send _view_direction :serialization-length))
   ;; float32 _fov_horizontal
     (setq _fov_horizontal (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fov_vertical
     (setq _fov_vertical (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; marker_msgs/Marker[] _markers
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _markers (let (r) (dotimes (i n) (push (instance marker_msgs::Marker :init) r)) r))
     (dolist (elem- _markers)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get marker_msgs::MarkerDetection :md5sum-) "b17d48b7aeec842456674ad3657d85fc")
(setf (get marker_msgs::MarkerDetection :datatype-) "marker_msgs/MarkerDetection")
(setf (get marker_msgs::MarkerDetection :definition-)
      "# This expresses a marker/fiducial detection
Header header                  # timestamp in the header is the acquisition time and frame

float32 distance_min           # distance minimum range value [m]
float32 distance_max           # distance maximum range value [m]
float32 distance_max_id        # distance maximum range value to detect id [m]

geometry_msgs/Quaternion view_direction       # view direction
float32 fov_horizontal                        # field of view horizontal [rad]
float32 fov_vertical                          # field of view vertical [rad]

string   type                  # marker type used (bch, artag, mip_36h12, stage, ...)
Marker[] markers               # detected markers
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
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

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

")



(provide :marker_msgs/MarkerDetection "b17d48b7aeec842456674ad3657d85fc")


