// Auto-generated. Do not edit!

// (in-package marker_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Marker = require('./Marker.js');
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MarkerDetection {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.distance_min = null;
      this.distance_max = null;
      this.distance_max_id = null;
      this.view_direction = null;
      this.fov_horizontal = null;
      this.fov_vertical = null;
      this.type = null;
      this.markers = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('distance_min')) {
        this.distance_min = initObj.distance_min
      }
      else {
        this.distance_min = 0.0;
      }
      if (initObj.hasOwnProperty('distance_max')) {
        this.distance_max = initObj.distance_max
      }
      else {
        this.distance_max = 0.0;
      }
      if (initObj.hasOwnProperty('distance_max_id')) {
        this.distance_max_id = initObj.distance_max_id
      }
      else {
        this.distance_max_id = 0.0;
      }
      if (initObj.hasOwnProperty('view_direction')) {
        this.view_direction = initObj.view_direction
      }
      else {
        this.view_direction = new geometry_msgs.msg.Quaternion();
      }
      if (initObj.hasOwnProperty('fov_horizontal')) {
        this.fov_horizontal = initObj.fov_horizontal
      }
      else {
        this.fov_horizontal = 0.0;
      }
      if (initObj.hasOwnProperty('fov_vertical')) {
        this.fov_vertical = initObj.fov_vertical
      }
      else {
        this.fov_vertical = 0.0;
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = '';
      }
      if (initObj.hasOwnProperty('markers')) {
        this.markers = initObj.markers
      }
      else {
        this.markers = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MarkerDetection
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [distance_min]
    bufferOffset = _serializer.float32(obj.distance_min, buffer, bufferOffset);
    // Serialize message field [distance_max]
    bufferOffset = _serializer.float32(obj.distance_max, buffer, bufferOffset);
    // Serialize message field [distance_max_id]
    bufferOffset = _serializer.float32(obj.distance_max_id, buffer, bufferOffset);
    // Serialize message field [view_direction]
    bufferOffset = geometry_msgs.msg.Quaternion.serialize(obj.view_direction, buffer, bufferOffset);
    // Serialize message field [fov_horizontal]
    bufferOffset = _serializer.float32(obj.fov_horizontal, buffer, bufferOffset);
    // Serialize message field [fov_vertical]
    bufferOffset = _serializer.float32(obj.fov_vertical, buffer, bufferOffset);
    // Serialize message field [type]
    bufferOffset = _serializer.string(obj.type, buffer, bufferOffset);
    // Serialize message field [markers]
    // Serialize the length for message field [markers]
    bufferOffset = _serializer.uint32(obj.markers.length, buffer, bufferOffset);
    obj.markers.forEach((val) => {
      bufferOffset = Marker.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MarkerDetection
    let len;
    let data = new MarkerDetection(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [distance_min]
    data.distance_min = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distance_max]
    data.distance_max = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [distance_max_id]
    data.distance_max_id = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [view_direction]
    data.view_direction = geometry_msgs.msg.Quaternion.deserialize(buffer, bufferOffset);
    // Deserialize message field [fov_horizontal]
    data.fov_horizontal = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fov_vertical]
    data.fov_vertical = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [type]
    data.type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [markers]
    // Deserialize array length for message field [markers]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.markers = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.markers[i] = Marker.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.type.length;
    object.markers.forEach((val) => {
      length += Marker.getMessageSize(val);
    });
    return length + 60;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marker_msgs/MarkerDetection';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b17d48b7aeec842456674ad3657d85fc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # This expresses a marker/fiducial detection
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MarkerDetection(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.distance_min !== undefined) {
      resolved.distance_min = msg.distance_min;
    }
    else {
      resolved.distance_min = 0.0
    }

    if (msg.distance_max !== undefined) {
      resolved.distance_max = msg.distance_max;
    }
    else {
      resolved.distance_max = 0.0
    }

    if (msg.distance_max_id !== undefined) {
      resolved.distance_max_id = msg.distance_max_id;
    }
    else {
      resolved.distance_max_id = 0.0
    }

    if (msg.view_direction !== undefined) {
      resolved.view_direction = geometry_msgs.msg.Quaternion.Resolve(msg.view_direction)
    }
    else {
      resolved.view_direction = new geometry_msgs.msg.Quaternion()
    }

    if (msg.fov_horizontal !== undefined) {
      resolved.fov_horizontal = msg.fov_horizontal;
    }
    else {
      resolved.fov_horizontal = 0.0
    }

    if (msg.fov_vertical !== undefined) {
      resolved.fov_vertical = msg.fov_vertical;
    }
    else {
      resolved.fov_vertical = 0.0
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = ''
    }

    if (msg.markers !== undefined) {
      resolved.markers = new Array(msg.markers.length);
      for (let i = 0; i < resolved.markers.length; ++i) {
        resolved.markers[i] = Marker.Resolve(msg.markers[i]);
      }
    }
    else {
      resolved.markers = []
    }

    return resolved;
    }
};

module.exports = MarkerDetection;
