// Auto-generated. Do not edit!

// (in-package mrpt_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class NodeIDWithPose {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nodeID = null;
      this.pose = null;
      this.str_ID = null;
      this.nodeID_loc = null;
    }
    else {
      if (initObj.hasOwnProperty('nodeID')) {
        this.nodeID = initObj.nodeID
      }
      else {
        this.nodeID = 0;
      }
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('str_ID')) {
        this.str_ID = initObj.str_ID
      }
      else {
        this.str_ID = new std_msgs.msg.String();
      }
      if (initObj.hasOwnProperty('nodeID_loc')) {
        this.nodeID_loc = initObj.nodeID_loc
      }
      else {
        this.nodeID_loc = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NodeIDWithPose
    // Serialize message field [nodeID]
    bufferOffset = _serializer.uint64(obj.nodeID, buffer, bufferOffset);
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [str_ID]
    bufferOffset = std_msgs.msg.String.serialize(obj.str_ID, buffer, bufferOffset);
    // Serialize message field [nodeID_loc]
    bufferOffset = _serializer.uint64(obj.nodeID_loc, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NodeIDWithPose
    let len;
    let data = new NodeIDWithPose(null);
    // Deserialize message field [nodeID]
    data.nodeID = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [str_ID]
    data.str_ID = std_msgs.msg.String.deserialize(buffer, bufferOffset);
    // Deserialize message field [nodeID_loc]
    data.nodeID_loc = _deserializer.uint64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.String.getMessageSize(object.str_ID);
    return length + 72;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/NodeIDWithPose';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '87c8db37a689c10a5c5dc1aa39838320';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new NodeIDWithPose(null);
    if (msg.nodeID !== undefined) {
      resolved.nodeID = msg.nodeID;
    }
    else {
      resolved.nodeID = 0
    }

    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.str_ID !== undefined) {
      resolved.str_ID = std_msgs.msg.String.Resolve(msg.str_ID)
    }
    else {
      resolved.str_ID = new std_msgs.msg.String()
    }

    if (msg.nodeID_loc !== undefined) {
      resolved.nodeID_loc = msg.nodeID_loc;
    }
    else {
      resolved.nodeID_loc = 0
    }

    return resolved;
    }
};

module.exports = NodeIDWithPose;
