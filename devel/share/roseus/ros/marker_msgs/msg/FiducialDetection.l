;; Auto-generated. Do not edit!


(when (boundp 'marker_msgs::FiducialDetection)
  (if (not (find-package "MARKER_MSGS"))
    (make-package "MARKER_MSGS"))
  (shadow 'FiducialDetection (find-package "MARKER_MSGS")))
(unless (find-package "MARKER_MSGS::FIDUCIALDETECTION")
  (make-package "MARKER_MSGS::FIDUCIALDETECTION"))

(in-package "ROS")
;;//! \htmlinclude FiducialDetection.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass marker_msgs::FiducialDetection
  :super ros::object
  :slots (_header _camera_d _camera_k _type _fiducial ))

(defmethod marker_msgs::FiducialDetection
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:camera_d __camera_d) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:camera_k __camera_k) (make-array 9 :initial-element 0.0 :element-type :float))
    ((:type __type) "")
    ((:fiducial __fiducial) (let (r) (dotimes (i 0) (push (instance marker_msgs::Fiducial :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _camera_d __camera_d)
   (setq _camera_k __camera_k)
   (setq _type (string __type))
   (setq _fiducial __fiducial)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:camera_d
   (&optional __camera_d)
   (if __camera_d (setq _camera_d __camera_d)) _camera_d)
  (:camera_k
   (&optional __camera_k)
   (if __camera_k (setq _camera_k __camera_k)) _camera_k)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:fiducial
   (&rest __fiducial)
   (if (keywordp (car __fiducial))
       (send* _fiducial __fiducial)
     (progn
       (if __fiducial (setq _fiducial (car __fiducial)))
       _fiducial)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float64[] _camera_d
    (* 8    (length _camera_d)) 4
    ;; float64[9] _camera_k
    (* 8    9)
    ;; string _type
    4 (length _type)
    ;; marker_msgs/Fiducial[] _fiducial
    (apply #'+ (send-all _fiducial :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float64[] _camera_d
     (write-long (length _camera_d) s)
     (dotimes (i (length _camera_d))
       (sys::poke (elt _camera_d i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; float64[9] _camera_k
     (dotimes (i 9)
       (sys::poke (elt _camera_k i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; marker_msgs/Fiducial[] _fiducial
     (write-long (length _fiducial) s)
     (dolist (elem _fiducial)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float64[] _camera_d
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _camera_d (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _camera_d i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; float64[9] _camera_k
   (dotimes (i (length _camera_k))
     (setf (elt _camera_k i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; marker_msgs/Fiducial[] _fiducial
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _fiducial (let (r) (dotimes (i n) (push (instance marker_msgs::Fiducial :init) r)) r))
     (dolist (elem- _fiducial)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get marker_msgs::FiducialDetection :md5sum-) "2ebb116fbde270de5551b0dc65e5f333")
(setf (get marker_msgs::FiducialDetection :datatype-) "marker_msgs/FiducialDetection")
(setf (get marker_msgs::FiducialDetection :definition-)
      "# This expresses a marker/fiducial detection
Header header                  # timestamp in the header is the acquisition time and frame

# The distortion parameters, size depending on the distortion model.
# For \"plumb_bob\", the 5 parameters are: (k1, k2, t1, t2, k3).
float64[] camera_d

# Intrinsic camera matrix for the raw (distorted) images.
#     [fx  0 cx]
# K = [ 0 fy cy]
#     [ 0  0  1]
# Projects 3D points in the camera coordinate frame to 2D pixel
# coordinates using the focal lengths (fx, fy) and principal point
# (cx, cy).
float64[9]  camera_k # 3x3 row-major matrix

string   type                  # marker type used (bch, artag, mip_36h12, stage, ...)
Fiducial[] fiducial            # detected markers
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
MSG: marker_msgs/Fiducial
# This expresses a known detected fiducial in image space
int32[] ids                         # possible ids of the detected fiducial (empty if no id could be identified)
float64[] ids_confidence            # confidence of the possible ids in [0, 1]
geometry_msgs/Point[] object_points # Array of object points in the object coordinate space.
geometry_msgs/Point[] image_points  # Array of corresponding image points. Point.z is not used.
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :marker_msgs/FiducialDetection "2ebb116fbde270de5551b0dc65e5f333")


