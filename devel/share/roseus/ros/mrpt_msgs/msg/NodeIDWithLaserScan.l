;; Auto-generated. Do not edit!


(when (boundp 'mrpt_msgs::NodeIDWithLaserScan)
  (if (not (find-package "MRPT_MSGS"))
    (make-package "MRPT_MSGS"))
  (shadow 'NodeIDWithLaserScan (find-package "MRPT_MSGS")))
(unless (find-package "MRPT_MSGS::NODEIDWITHLASERSCAN")
  (make-package "MRPT_MSGS::NODEIDWITHLASERSCAN"))

(in-package "ROS")
;;//! \htmlinclude NodeIDWithLaserScan.msg.html
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass mrpt_msgs::NodeIDWithLaserScan
  :super ros::object
  :slots (_nodeID _scan ))

(defmethod mrpt_msgs::NodeIDWithLaserScan
  (:init
   (&key
    ((:nodeID __nodeID) 0)
    ((:scan __scan) (instance sensor_msgs::LaserScan :init))
    )
   (send-super :init)
   (setq _nodeID (round __nodeID))
   (setq _scan __scan)
   self)
  (:nodeID
   (&optional __nodeID)
   (if __nodeID (setq _nodeID __nodeID)) _nodeID)
  (:scan
   (&rest __scan)
   (if (keywordp (car __scan))
       (send* _scan __scan)
     (progn
       (if __scan (setq _scan (car __scan)))
       _scan)))
  (:serialization-length
   ()
   (+
    ;; uint64 _nodeID
    8
    ;; sensor_msgs/LaserScan _scan
    (send _scan :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint64 _nodeID
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _nodeID (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _nodeID) (= (length (_nodeID . bv)) 2)) ;; bignum
              (write-long (ash (elt (_nodeID . bv) 0) 0) s)
              (write-long (ash (elt (_nodeID . bv) 1) -1) s))
             ((and (class _nodeID) (= (length (_nodeID . bv)) 1)) ;; big1
              (write-long (elt (_nodeID . bv) 0) s)
              (write-long (if (>= _nodeID 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _nodeID s)(write-long (if (>= _nodeID 0) 0 #xffffffff) s)))
     ;; sensor_msgs/LaserScan _scan
       (send _scan :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint64 _nodeID
     
#+(or :alpha :irix6 :x86_64)
      (setf _nodeID (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _nodeID (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; sensor_msgs/LaserScan _scan
     (send _scan :deserialize buf ptr-) (incf ptr- (send _scan :serialization-length))
   ;;
   self)
  )

(setf (get mrpt_msgs::NodeIDWithLaserScan :md5sum-) "135d436b647c8470f71b2c97722a4352")
(setf (get mrpt_msgs::NodeIDWithLaserScan :datatype-) "mrpt_msgs/NodeIDWithLaserScan")
(setf (get mrpt_msgs::NodeIDWithLaserScan :definition-)
      "# NodeID along with the associated LaserScan
#
# Currently used in the mrpt_graphslam_2d ROS application.

uint64 nodeID
sensor_msgs/LaserScan scan

================================================================================
MSG: sensor_msgs/LaserScan
# Single scan from a planar laser range-finder
#
# If you have another ranging device with different behavior (e.g. a sonar
# array), please find or create a different message, since applications
# will make fairly laser-specific assumptions about this data

Header header            # timestamp in the header is the acquisition time of 
                         # the first ray in the scan.
                         #
                         # in frame frame_id, angles are measured around 
                         # the positive Z axis (counterclockwise, if Z is up)
                         # with zero angle being forward along the x axis
                         
float32 angle_min        # start angle of the scan [rad]
float32 angle_max        # end angle of the scan [rad]
float32 angle_increment  # angular distance between measurements [rad]

float32 time_increment   # time between measurements [seconds] - if your scanner
                         # is moving, this will be used in interpolating position
                         # of 3d points
float32 scan_time        # time between scans [seconds]

float32 range_min        # minimum range value [m]
float32 range_max        # maximum range value [m]

float32[] ranges         # range data [m] (Note: values < range_min or > range_max should be discarded)
float32[] intensities    # intensity data [device-specific units].  If your
                         # device does not provide intensities, please leave
                         # the array empty.

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

")



(provide :mrpt_msgs/NodeIDWithLaserScan "135d436b647c8470f71b2c97722a4352")


