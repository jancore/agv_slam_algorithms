;; Auto-generated. Do not edit!


(when (boundp 'marker_msgs::MarkerWithCovariance)
  (if (not (find-package "MARKER_MSGS"))
    (make-package "MARKER_MSGS"))
  (shadow 'MarkerWithCovariance (find-package "MARKER_MSGS")))
(unless (find-package "MARKER_MSGS::MARKERWITHCOVARIANCE")
  (make-package "MARKER_MSGS::MARKERWITHCOVARIANCE"))

(in-package "ROS")
;;//! \htmlinclude MarkerWithCovariance.msg.html


(defclass marker_msgs::MarkerWithCovariance
  :super ros::object
  :slots (_marker _covariance ))

(defmethod marker_msgs::MarkerWithCovariance
  (:init
   (&key
    ((:marker __marker) (instance marker_msgs::Marker :init))
    ((:covariance __covariance) (make-array 36 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _marker __marker)
   (setq _covariance __covariance)
   self)
  (:marker
   (&rest __marker)
   (if (keywordp (car __marker))
       (send* _marker __marker)
     (progn
       (if __marker (setq _marker (car __marker)))
       _marker)))
  (:covariance
   (&optional __covariance)
   (if __covariance (setq _covariance __covariance)) _covariance)
  (:serialization-length
   ()
   (+
    ;; marker_msgs/Marker _marker
    (send _marker :serialization-length)
    ;; float64[36] _covariance
    (* 8    36)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; marker_msgs/Marker _marker
       (send _marker :serialize s)
     ;; float64[36] _covariance
     (dotimes (i 36)
       (sys::poke (elt _covariance i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; marker_msgs/Marker _marker
     (send _marker :deserialize buf ptr-) (incf ptr- (send _marker :serialization-length))
   ;; float64[36] _covariance
   (dotimes (i (length _covariance))
     (setf (elt _covariance i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     )
   ;;
   self)
  )

(setf (get marker_msgs::MarkerWithCovariance :md5sum-) "ace241bc4ec8f4b399c13e05763be31a")
(setf (get marker_msgs::MarkerWithCovariance :datatype-) "marker_msgs/MarkerWithCovariance")
(setf (get marker_msgs::MarkerWithCovariance :definition-)
      "# This expresses a marker in free space with uncertainty.

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



(provide :marker_msgs/MarkerWithCovariance "ace241bc4ec8f4b399c13e05763be31a")


