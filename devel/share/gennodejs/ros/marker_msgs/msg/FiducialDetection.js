// Auto-generated. Do not edit!

// (in-package marker_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Fiducial = require('./Fiducial.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class FiducialDetection {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.camera_d = null;
      this.camera_k = null;
      this.type = null;
      this.fiducial = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('camera_d')) {
        this.camera_d = initObj.camera_d
      }
      else {
        this.camera_d = [];
      }
      if (initObj.hasOwnProperty('camera_k')) {
        this.camera_k = initObj.camera_k
      }
      else {
        this.camera_k = new Array(9).fill(0);
      }
      if (initObj.hasOwnProperty('type')) {
        this.type = initObj.type
      }
      else {
        this.type = '';
      }
      if (initObj.hasOwnProperty('fiducial')) {
        this.fiducial = initObj.fiducial
      }
      else {
        this.fiducial = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FiducialDetection
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [camera_d]
    bufferOffset = _arraySerializer.float64(obj.camera_d, buffer, bufferOffset, null);
    // Check that the constant length array field [camera_k] has the right length
    if (obj.camera_k.length !== 9) {
      throw new Error('Unable to serialize array field camera_k - length must be 9')
    }
    // Serialize message field [camera_k]
    bufferOffset = _arraySerializer.float64(obj.camera_k, buffer, bufferOffset, 9);
    // Serialize message field [type]
    bufferOffset = _serializer.string(obj.type, buffer, bufferOffset);
    // Serialize message field [fiducial]
    // Serialize the length for message field [fiducial]
    bufferOffset = _serializer.uint32(obj.fiducial.length, buffer, bufferOffset);
    obj.fiducial.forEach((val) => {
      bufferOffset = Fiducial.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FiducialDetection
    let len;
    let data = new FiducialDetection(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [camera_d]
    data.camera_d = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [camera_k]
    data.camera_k = _arrayDeserializer.float64(buffer, bufferOffset, 9)
    // Deserialize message field [type]
    data.type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [fiducial]
    // Deserialize array length for message field [fiducial]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.fiducial = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.fiducial[i] = Fiducial.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 8 * object.camera_d.length;
    length += object.type.length;
    object.fiducial.forEach((val) => {
      length += Fiducial.getMessageSize(val);
    });
    return length + 84;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marker_msgs/FiducialDetection';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2ebb116fbde270de5551b0dc65e5f333';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # This expresses a marker/fiducial detection
    Header header                  # timestamp in the header is the acquisition time and frame
    
    # The distortion parameters, size depending on the distortion model.
    # For "plumb_bob", the 5 parameters are: (k1, k2, t1, t2, k3).
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FiducialDetection(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.camera_d !== undefined) {
      resolved.camera_d = msg.camera_d;
    }
    else {
      resolved.camera_d = []
    }

    if (msg.camera_k !== undefined) {
      resolved.camera_k = msg.camera_k;
    }
    else {
      resolved.camera_k = new Array(9).fill(0)
    }

    if (msg.type !== undefined) {
      resolved.type = msg.type;
    }
    else {
      resolved.type = ''
    }

    if (msg.fiducial !== undefined) {
      resolved.fiducial = new Array(msg.fiducial.length);
      for (let i = 0; i < resolved.fiducial.length; ++i) {
        resolved.fiducial[i] = Fiducial.Resolve(msg.fiducial[i]);
      }
    }
    else {
      resolved.fiducial = []
    }

    return resolved;
    }
};

module.exports = FiducialDetection;
