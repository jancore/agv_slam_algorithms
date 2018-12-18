// Auto-generated. Do not edit!

// (in-package mrpt_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let GraphSlamAgent = require('./GraphSlamAgent.js');

//-----------------------------------------------------------

class GraphSlamAgents {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.list = null;
    }
    else {
      if (initObj.hasOwnProperty('list')) {
        this.list = initObj.list
      }
      else {
        this.list = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GraphSlamAgents
    // Serialize message field [list]
    // Serialize the length for message field [list]
    bufferOffset = _serializer.uint32(obj.list.length, buffer, bufferOffset);
    obj.list.forEach((val) => {
      bufferOffset = GraphSlamAgent.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GraphSlamAgents
    let len;
    let data = new GraphSlamAgents(null);
    // Deserialize message field [list]
    // Deserialize array length for message field [list]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.list = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.list[i] = GraphSlamAgent.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.list.forEach((val) => {
      length += GraphSlamAgent.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/GraphSlamAgents';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ac3446e50a170e19b88734cb8e7206bb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Defines vector of GraphSlamAgents.
    # Currently used in the mrpt_graphslam_2d ROS application.
    
    GraphSlamAgent[] list
    
    
    ================================================================================
    MSG: mrpt_msgs/GraphSlamAgent
    # Connection-related properties for a graphSLAM agent in a multi-robot
    # environment.
    #
    # Currently used in the mrpt_graphslam_2d ROS application.
    
    std_msgs/String name
    std_msgs/String hostname
    
    # IPv4 of the corresponding agent
    std_msgs/String ip_addr
    
    # Port that the the roscore of the corresponding agent is running under
    uint16 port
    
    # True if the SLAM Agent was last reported to be online
    std_msgs/Bool is_online
    
    # Timestamp that the SLAM Agent was last seen
    std_msgs/Time last_seen_time
    
    # ROS Topics namespace that the agent is running under
    # By definition this is going to be the same as the *name*
    # UPDATE: Previously the topics namespace was <name>_<agent_ID>. However since I'll be using the multimaster for communication, every node is going to have a different 
    std_msgs/String topic_namespace
    
    # this is the last field of the IPv4 address of the corresponding agent
    # e.g. IP=192.168.100.17
    # agent_ID = 17
    int32 agent_ID 
    
    ================================================================================
    MSG: std_msgs/String
    string data
    
    ================================================================================
    MSG: std_msgs/Bool
    bool data
    ================================================================================
    MSG: std_msgs/Time
    time data
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GraphSlamAgents(null);
    if (msg.list !== undefined) {
      resolved.list = new Array(msg.list.length);
      for (let i = 0; i < resolved.list.length; ++i) {
        resolved.list[i] = GraphSlamAgent.Resolve(msg.list[i]);
      }
    }
    else {
      resolved.list = []
    }

    return resolved;
    }
};

module.exports = GraphSlamAgents;
