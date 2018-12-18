// Auto-generated. Do not edit!

// (in-package marker_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class Fiducial {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ids = null;
      this.ids_confidence = null;
      this.object_points = null;
      this.image_points = null;
    }
    else {
      if (initObj.hasOwnProperty('ids')) {
        this.ids = initObj.ids
      }
      else {
        this.ids = [];
      }
      if (initObj.hasOwnProperty('ids_confidence')) {
        this.ids_confidence = initObj.ids_confidence
      }
      else {
        this.ids_confidence = [];
      }
      if (initObj.hasOwnProperty('object_points')) {
        this.object_points = initObj.object_points
      }
      else {
        this.object_points = [];
      }
      if (initObj.hasOwnProperty('image_points')) {
        this.image_points = initObj.image_points
      }
      else {
        this.image_points = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Fiducial
    // Serialize message field [ids]
    bufferOffset = _arraySerializer.int32(obj.ids, buffer, bufferOffset, null);
    // Serialize message field [ids_confidence]
    bufferOffset = _arraySerializer.float64(obj.ids_confidence, buffer, bufferOffset, null);
    // Serialize message field [object_points]
    // Serialize the length for message field [object_points]
    bufferOffset = _serializer.uint32(obj.object_points.length, buffer, bufferOffset);
    obj.object_points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [image_points]
    // Serialize the length for message field [image_points]
    bufferOffset = _serializer.uint32(obj.image_points.length, buffer, bufferOffset);
    obj.image_points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Fiducial
    let len;
    let data = new Fiducial(null);
    // Deserialize message field [ids]
    data.ids = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [ids_confidence]
    data.ids_confidence = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [object_points]
    // Deserialize array length for message field [object_points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.object_points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.object_points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [image_points]
    // Deserialize array length for message field [image_points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.image_points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.image_points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.ids.length;
    length += 8 * object.ids_confidence.length;
    length += 24 * object.object_points.length;
    length += 24 * object.image_points.length;
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'marker_msgs/Fiducial';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0771474f385b4ef416eeda4ba2143ce2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new Fiducial(null);
    if (msg.ids !== undefined) {
      resolved.ids = msg.ids;
    }
    else {
      resolved.ids = []
    }

    if (msg.ids_confidence !== undefined) {
      resolved.ids_confidence = msg.ids_confidence;
    }
    else {
      resolved.ids_confidence = []
    }

    if (msg.object_points !== undefined) {
      resolved.object_points = new Array(msg.object_points.length);
      for (let i = 0; i < resolved.object_points.length; ++i) {
        resolved.object_points[i] = geometry_msgs.msg.Point.Resolve(msg.object_points[i]);
      }
    }
    else {
      resolved.object_points = []
    }

    if (msg.image_points !== undefined) {
      resolved.image_points = new Array(msg.image_points.length);
      for (let i = 0; i < resolved.image_points.length; ++i) {
        resolved.image_points[i] = geometry_msgs.msg.Point.Resolve(msg.image_points[i]);
      }
    }
    else {
      resolved.image_points = []
    }

    return resolved;
    }
};

module.exports = Fiducial;
