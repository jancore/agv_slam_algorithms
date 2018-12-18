;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::SingleRangeBearingObservation)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'SingleRangeBearingObservation (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::SINGLERANGEBEARINGOBSERVATION")
  (make-package "MRPT_MSGS::SINGLERANGEBEARINGOBSERVATION"))

(in-package "ROS")
;;//! \htmlinclude SingleRangeBearingObservation.msg.html


(defclass mrpt_msgs::SingleRangeBearingObservation
  :super ros::object
  :slots (_range _yaw _pitch _id ))

(defmethod mrpt_msgs::SingleRangeBearingObservation
  (:init
   (&key
    ((:range __range) 0.0)
    ((:yaw __yaw) 0.0)
    ((:pitch __pitch) 0.0)
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _range (float __range))
   (setq _yaw (float __yaw))
   (setq _pitch (float __pitch))
   (setq _id (round __id))
   self)
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:pitch
   (&optional __pitch)
   (if __pitch (setq _pitch __pitch)) _pitch)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; float64 _range
    8
    ;; float64 _yaw
    8
    ;; float64 _pitch
    8
    ;; int32 _id
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _range
       (sys::poke _range (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pitch
       (sys::poke _pitch (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _id
       (write-long _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _range
     (setq _range (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pitch
     (setq _pitch (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get mrpt_msgs::SingleRangeBearingObservation :md5sum-) "76298eebeb670a2e009ca536cba1648b")
(setf (get mrpt_msgs::SingleRangeBearingObservation :datatype-) "mrpt_msgs/SingleRangeBearingObservation")
(setf (get mrpt_msgs::SingleRangeBearingObservation :definition-)
      "#int32 INVALID_LANDMARK_ID = -1


float64  range    # Distance, in meters.
float64  yaw      # Angle wrt +Z (rads)
float64  pitch    # Angle wrt +Y (rads)
int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)


")



(provide :mrpt_msgs/SingleRangeBearingObservation "76298eebeb670a2e009ca536cba1648b")


