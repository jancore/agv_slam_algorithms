// Auto-generated. Do not edit!

// (in-package mrpt_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let SingleRangeBearingObservation = require('./SingleRangeBearingObservation.js');
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ObservationRangeBearing {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.sensor_pose_on_robot = null;
      this.min_sensor_distance = null;
      this.max_sensor_distance = null;
      this.sensor_std_range = null;
      this.sensor_std_yaw = null;
      this.sensor_std_pitch = null;
      this.sensed_data = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('sensor_pose_on_robot')) {
        this.sensor_pose_on_robot = initObj.sensor_pose_on_robot
      }
      else {
        this.sensor_pose_on_robot = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('min_sensor_distance')) {
        this.min_sensor_distance = initObj.min_sensor_distance
      }
      else {
        this.min_sensor_distance = 0.0;
      }
      if (initObj.hasOwnProperty('max_sensor_distance')) {
        this.max_sensor_distance = initObj.max_sensor_distance
      }
      else {
        this.max_sensor_distance = 0.0;
      }
      if (initObj.hasOwnProperty('sensor_std_range')) {
        this.sensor_std_range = initObj.sensor_std_range
      }
      else {
        this.sensor_std_range = 0.0;
      }
      if (initObj.hasOwnProperty('sensor_std_yaw')) {
        this.sensor_std_yaw = initObj.sensor_std_yaw
      }
      else {
        this.sensor_std_yaw = 0.0;
      }
      if (initObj.hasOwnProperty('sensor_std_pitch')) {
        this.sensor_std_pitch = initObj.sensor_std_pitch
      }
      else {
        this.sensor_std_pitch = 0.0;
      }
      if (initObj.hasOwnProperty('sensed_data')) {
        this.sensed_data = initObj.sensed_data
      }
      else {
        this.sensed_data = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ObservationRangeBearing
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [sensor_pose_on_robot]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.sensor_pose_on_robot, buffer, bufferOffset);
    // Serialize message field [min_sensor_distance]
    bufferOffset = _serializer.float64(obj.min_sensor_distance, buffer, bufferOffset);
    // Serialize message field [max_sensor_distance]
    bufferOffset = _serializer.float64(obj.max_sensor_distance, buffer, bufferOffset);
    // Serialize message field [sensor_std_range]
    bufferOffset = _serializer.float64(obj.sensor_std_range, buffer, bufferOffset);
    // Serialize message field [sensor_std_yaw]
    bufferOffset = _serializer.float64(obj.sensor_std_yaw, buffer, bufferOffset);
    // Serialize message field [sensor_std_pitch]
    bufferOffset = _serializer.float64(obj.sensor_std_pitch, buffer, bufferOffset);
    // Serialize message field [sensed_data]
    // Serialize the length for message field [sensed_data]
    bufferOffset = _serializer.uint32(obj.sensed_data.length, buffer, bufferOffset);
    obj.sensed_data.forEach((val) => {
      bufferOffset = SingleRangeBearingObservation.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ObservationRangeBearing
    let len;
    let data = new ObservationRangeBearing(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [sensor_pose_on_robot]
    data.sensor_pose_on_robot = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [min_sensor_distance]
    data.min_sensor_distance = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [max_sensor_distance]
    data.max_sensor_distance = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [sensor_std_range]
    data.sensor_std_range = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [sensor_std_yaw]
    data.sensor_std_yaw = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [sensor_std_pitch]
    data.sensor_std_pitch = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [sensed_data]
    // Deserialize array length for message field [sensed_data]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.sensed_data = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.sensed_data[i] = SingleRangeBearingObservation.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 28 * object.sensed_data.length;
    return length + 100;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/ObservationRangeBearing';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e1be50a05d6a766b374c80620f485049';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # This message holds an observation of one or more landmarks 
    #  detected by their range (distance) + bearing (2 or 3 angles) 
    #  from some sensor on the robot.
    
    # Time of sensor data acquisition, coordinate frame ID.
    Header header
    
    # The sensor pose on the robot coordinates frame.
    geometry_msgs/Pose sensor_pose_on_robot
    
    # Sensor characteristics:
    float64 min_sensor_distance   # In meters (m)
    float64 max_sensor_distance   # (m)
    
    # Typical sensor noise:
    float64 sensor_std_range      # (m)
    float64 sensor_std_yaw        # (rad)
    float64 sensor_std_pitch      # (pitch)
    
    # The vector of individual observations
    SingleRangeBearingObservation[] sensed_data
    
    
    
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
    
    ================================================================================
    MSG: mrpt_msgs/SingleRangeBearingObservation
    #int32 INVALID_LANDMARK_ID = -1
    
    
    float64  range    # Distance, in meters.
    float64  yaw      # Angle wrt +Z (rads)
    float64  pitch    # Angle wrt +Y (rads)
    int32    id       # Landmark ID (or INVALID_LANDMARK_ID if landmarks are not identified)
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ObservationRangeBearing(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.sensor_pose_on_robot !== undefined) {
      resolved.sensor_pose_on_robot = geometry_msgs.msg.Pose.Resolve(msg.sensor_pose_on_robot)
    }
    else {
      resolved.sensor_pose_on_robot = new geometry_msgs.msg.Pose()
    }

    if (msg.min_sensor_distance !== undefined) {
      resolved.min_sensor_distance = msg.min_sensor_distance;
    }
    else {
      resolved.min_sensor_distance = 0.0
    }

    if (msg.max_sensor_distance !== undefined) {
      resolved.max_sensor_distance = msg.max_sensor_distance;
    }
    else {
      resolved.max_sensor_distance = 0.0
    }

    if (msg.sensor_std_range !== undefined) {
      resolved.sensor_std_range = msg.sensor_std_range;
    }
    else {
      resolved.sensor_std_range = 0.0
    }

    if (msg.sensor_std_yaw !== undefined) {
      resolved.sensor_std_yaw = msg.sensor_std_yaw;
    }
    else {
      resolved.sensor_std_yaw = 0.0
    }

    if (msg.sensor_std_pitch !== undefined) {
      resolved.sensor_std_pitch = msg.sensor_std_pitch;
    }
    else {
      resolved.sensor_std_pitch = 0.0
    }

    if (msg.sensed_data !== undefined) {
      resolved.sensed_data = new Array(msg.sensed_data.length);
      for (let i = 0; i < resolved.sensed_data.length; ++i) {
        resolved.sensed_data[i] = SingleRangeBearingObservation.Resolve(msg.sensed_data[i]);
      }
    }
    else {
      resolved.sensed_data = []
    }

    return resolved;
    }
};

module.exports = ObservationRangeBearing;
