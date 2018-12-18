;; Auto-generated. Do not edit!


(when (boundp 'marker_msgs::Fiducial)
  (if (not (find-package "MARKER_MSGS"))
    (make-package "MARKER_MSGS"))
  (shadow 'Fiducial (find-package "MARKER_MSGS")))
(unless (find-package "MARKER_MSGS::FIDUCIAL")
  (make-package "MARKER_MSGS::FIDUCIAL"))

(in-package "ROS")
;;//! \htmlinclude Fiducial.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass marker_msgs::Fiducial
  :super ros::object
  :slots (_ids _ids_confidence _object_points _image_points ))

(defmethod marker_msgs::Fiducial
  (:init
   (&key
    ((:ids __ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:ids_confidence __ids_confidence) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:object_points __object_points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:image_points __image_points) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    )
   (send-super :init)
   (setq _ids __ids)
   (setq _ids_confidence __ids_confidence)
   (setq _object_points __object_points)
   (setq _image_points __image_points)
   self)
  (:ids
   (&optional __ids)
   (if __ids (setq _ids __ids)) _ids)
  (:ids_confidence
   (&optional __ids_confidence)
   (if __ids_confidence (setq _ids_confidence __ids_confidence)) _ids_confidence)
  (:object_points
   (&rest __object_points)
   (if (keywordp (car __object_points))
       (send* _object_points __object_points)
     (progn
       (if __object_points (setq _object_points (car __object_points)))
       _object_points)))
  (:image_points
   (&rest __image_points)
   (if (keywordp (car __image_points))
       (send* _image_points __image_points)
     (progn
       (if __image_points (setq _image_points (car __image_points)))
       _image_points)))
  (:serialization-length
   ()
   (+
    ;; int32[] _ids
    (* 4    (length _ids)) 4
    ;; float64[] _ids_confidence
    (* 8    (length _ids_confidence)) 4
    ;; geometry_msgs/Point[] _object_points
    (apply #'+ (send-all _object_points :serialization-length)) 4
    ;; geometry_msgs/Point[] _image_points
    (apply #'+ (send-all _image_points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _ids
     (write-long (length _ids) s)
     (dotimes (i (length _ids))
       (write-long (elt _ids i) s)
       )
     ;; float64[] _ids_confidence
     (write-long (length _ids_confidence) s)
     (dotimes (i (length _ids_confidence))
       (sys::poke (elt _ids_confidence i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; geometry_msgs/Point[] _object_points
     (write-long (length _object_points) s)
     (dolist (elem _object_points)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[] _image_points
     (write-long (length _image_points) s)
     (dolist (elem _image_points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _ids i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; float64[] _ids_confidence
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ids_confidence (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _ids_confidence i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; geometry_msgs/Point[] _object_points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _object_points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _object_points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point[] _image_points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _image_points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _image_points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get marker_msgs::Fiducial :md5sum-) "0771474f385b4ef416eeda4ba2143ce2")
(setf (get marker_msgs::Fiducial :datatype-) "marker_msgs/Fiducial")
(setf (get marker_msgs::Fiducial :definition-)
      "# This expresses a known detected fiducial in image space
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



(provide :marker_msgs/Fiducial "0771474f385b4ef416eeda4ba2143ce2")


