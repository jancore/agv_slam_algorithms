;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::SingleRangeBeaconObservation)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'SingleRangeBeaconObservation (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::SINGLERANGEBEACONOBSERVATION")
  (make-package "MRPT_MSGS::SINGLERANGEBEACONOBSERVATION"))

(in-package "ROS")
;;//! \htmlinclude SingleRangeBeaconObservation.msg.html


(defclass mrpt_msgs::SingleRangeBeaconObservation
  :super ros::object
  :slots (_range _id ))

(defmethod mrpt_msgs::SingleRangeBeaconObservation
  (:init
   (&key
    ((:range __range) 0.0)
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _range (float __range))
   (setq _id (round __id))
   self)
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; float64 _range
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
     ;; int32 _id
       (write-long _id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _range
     (setq _range (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get mrpt_msgs::SingleRangeBeaconObservation :md5sum-) "1a4ad6d0080f2888716c1b8c7a297f62")
(setf (get mrpt_msgs::SingleRangeBeaconObservation :datatype-) "mrpt_msgs/SingleRangeBeaconObservation")
(setf (get mrpt_msgs::SingleRangeBeaconObservation :definition-)
      "#int32 INVALID_LANDMARK_ID = -1


float64  range    # Distance, in meters.
int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)


")



(provide :mrpt_msgs/SingleRangeBeaconObservation "1a4ad6d0080f2888716c1b8c7a297f62")


