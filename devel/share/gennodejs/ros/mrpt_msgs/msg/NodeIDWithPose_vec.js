// Auto-generated. Do not edit!

// (in-package mrpt_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let NodeIDWithPose = require('./NodeIDWithPose.js');

//-----------------------------------------------------------

class NodeIDWithPose_vec {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.vec = null;
    }
    else {
      if (initObj.hasOwnProperty('vec')) {
        this.vec = initObj.vec
      }
      else {
        this.vec = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NodeIDWithPose_vec
    // Serialize message field [vec]
    // Serialize the length for message field [vec]
    bufferOffset = _serializer.uint32(obj.vec.length, buffer, bufferOffset);
    obj.vec.forEach((val) => {
      bufferOffset = NodeIDWithPose.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NodeIDWithPose_vec
    let len;
    let data = new NodeIDWithPose_vec(null);
    // Deserialize message field [vec]
    // Deserialize array length for message field [vec]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.vec = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.vec[i] = NodeIDWithPose.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.vec.forEach((val) => {
      length += NodeIDWithPose.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/NodeIDWithPose_vec';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f30000109eab9cc7bc6b44c3e86d9fac';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Vector of NodeIDWithPose msgs
    
    NodeIDWithPose[] vec
    
    
    ================================================================================
    MSG: mrpt_msgs/NodeIDWithPose
    # NodeID along with its corresponding 2D/3D pose estimation.
    # Message also contains the following optional fields:
    # - str_ID: string identifier of the robot agent that initially registered this node in
    # its graph
    # - nodeID_loc: ID of the current node in the graph it was initially registered in.
    #
    # note: Additional fields correspond to the fields of the
    # mrpt::graphs::detail::TMRSlamNodeAnnotations struct
    #
    # Currently used in the mrpt_graphslam_2d ROS application.
    
    uint64 nodeID
    geometry_msgs/Pose pose
    
    std_msgs/String str_ID
    uint64 nodeID_loc
    
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
    MSG: std_msgs/String
    string data
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NodeIDWithPose_vec(null);
    if (msg.vec !== undefined) {
      resolved.vec = new Array(msg.vec.length);
      for (let i = 0; i < resolved.vec.length; ++i) {
        resolved.vec[i] = NodeIDWithPose.Resolve(msg.vec[i]);
      }
    }
    else {
      resolved.vec = []
    }

    return resolved;
    }
};

module.exports = NodeIDWithPose_vec;
