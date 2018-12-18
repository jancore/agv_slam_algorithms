
(cl:in-package :asdf)

(defsystem "marker_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Fiducial" :depends-on ("_package_Fiducial"))
    (:file "_package_Fiducial" :depends-on ("_package"))
    (:file "FiducialDetection" :depends-on ("_package_FiducialDetection"))
    (:file "_package_FiducialDetection" :depends-on ("_package"))
    (:file "Marker" :depends-on ("_package_Marker"))
    (:file "_package_Marker" :depends-on ("_package"))
    (:file "MarkerDetection" :depends-on ("_package_MarkerDetection"))
    (:file "_package_MarkerDetection" :depends-on ("_package"))
    (:file "MarkerStamped" :depends-on ("_package_MarkerStamped"))
    (:file "_package_MarkerStamped" :depends-on ("_package"))
    (:file "MarkerWithCovariance" :depends-on ("_package_MarkerWithCovariance"))
    (:file "_package_MarkerWithCovariance" :depends-on ("_package"))
    (:file "MarkerWithCovarianceArray" :depends-on ("_package_MarkerWithCovarianceArray"))
    (:file "_package_MarkerWithCovarianceArray" :depends-on ("_package"))
    (:file "MarkerWithCovarianceStamped" :depends-on ("_package_MarkerWithCovarianceStamped"))
    (:file "_package_MarkerWithCovarianceStamped" :depends-on ("_package"))
  ))