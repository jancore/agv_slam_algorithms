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

//-----------------------------------------------------------

class GraphSlamAgent {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.name = null;
      this.hostname = null;
      this.ip_addr = null;
      this.port = null;
      this.is_online = null;
      this.last_seen_time = null;
      this.topic_namespace = null;
      this.agent_ID = null;
    }
    else {
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = new std_msgs.msg.String();
      }
      if (initObj.hasOwnProperty('hostname')) {
        this.hostname = initObj.hostname
      }
      else {
        this.hostname = new std_msgs.msg.String();
      }
      if (initObj.hasOwnProperty('ip_addr')) {
        this.ip_addr = initObj.ip_addr
      }
      else {
        this.ip_addr = new std_msgs.msg.String();
      }
      if (initObj.hasOwnProperty('port')) {
        this.port = initObj.port
      }
      else {
        this.port = 0;
      }
      if (initObj.hasOwnProperty('is_online')) {
        this.is_online = initObj.is_online
      }
      else {
        this.is_online = new std_msgs.msg.Bool();
      }
      if (initObj.hasOwnProperty('last_seen_time')) {
        this.last_seen_time = initObj.last_seen_time
      }
      else {
        this.last_seen_time = new std_msgs.msg.Time();
      }
      if (initObj.hasOwnProperty('topic_namespace')) {
        this.topic_namespace = initObj.topic_namespace
      }
      else {
        this.topic_namespace = new std_msgs.msg.String();
      }
      if (initObj.hasOwnProperty('agent_ID')) {
        this.agent_ID = initObj.agent_ID
      }
      else {
        this.agent_ID = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GraphSlamAgent
    // Serialize message field [name]
    bufferOffset = std_msgs.msg.String.serialize(obj.name, buffer, bufferOffset);
    // Serialize message field [hostname]
    bufferOffset = std_msgs.msg.String.serialize(obj.hostname, buffer, bufferOffset);
    // Serialize message field [ip_addr]
    bufferOffset = std_msgs.msg.String.serialize(obj.ip_addr, buffer, bufferOffset);
    // Serialize message field [port]
    bufferOffset = _serializer.uint16(obj.port, buffer, bufferOffset);
    // Serialize message field [is_online]
    bufferOffset = std_msgs.msg.Bool.serialize(obj.is_online, buffer, bufferOffset);
    // Serialize message field [last_seen_time]
    bufferOffset = std_msgs.msg.Time.serialize(obj.last_seen_time, buffer, bufferOffset);
    // Serialize message field [topic_namespace]
    bufferOffset = std_msgs.msg.String.serialize(obj.topic_namespace, buffer, bufferOffset);
    // Serialize message field [agent_ID]
    bufferOffset = _serializer.int32(obj.agent_ID, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GraphSlamAgent
    let len;
    let data = new GraphSlamAgent(null);
    // Deserialize message field [name]
    data.name = std_msgs.msg.String.deserialize(buffer, bufferOffset);
    // Deserialize message field [hostname]
    data.hostname = std_msgs.msg.String.deserialize(buffer, bufferOffset);
    // Deserialize message field [ip_addr]
    data.ip_addr = std_msgs.msg.String.deserialize(buffer, bufferOffset);
    // Deserialize message field [port]
    data.port = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [is_online]
    data.is_online = std_msgs.msg.Bool.deserialize(buffer, bufferOffset);
    // Deserialize message field [last_seen_time]
    data.last_seen_time = std_msgs.msg.Time.deserialize(buffer, bufferOffset);
    // Deserialize message field [topic_namespace]
    data.topic_namespace = std_msgs.msg.String.deserialize(buffer, bufferOffset);
    // Deserialize message field [agent_ID]
    data.agent_ID = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.String.getMessageSize(object.name);
    length += std_msgs.msg.String.getMessageSize(object.hostname);
    length += std_msgs.msg.String.getMessageSize(object.ip_addr);
    length += std_msgs.msg.String.getMessageSize(object.topic_namespace);
    return length + 15;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/GraphSlamAgent';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6f5305e3be2b2f63220c0183a8af1288';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new GraphSlamAgent(null);
    if (msg.name !== undefined) {
      resolved.name = std_msgs.msg.String.Resolve(msg.name)
    }
    else {
      resolved.name = new std_msgs.msg.String()
    }

    if (msg.hostname !== undefined) {
      resolved.hostname = std_msgs.msg.String.Resolve(msg.hostname)
    }
    else {
      resolved.hostname = new std_msgs.msg.String()
    }

    if (msg.ip_addr !== undefined) {
      resolved.ip_addr = std_msgs.msg.String.Resolve(msg.ip_addr)
    }
    else {
      resolved.ip_addr = new std_msgs.msg.String()
    }

    if (msg.port !== undefined) {
      resolved.port = msg.port;
    }
    else {
      resolved.port = 0
    }

    if (msg.is_online !== undefined) {
      resolved.is_online = std_msgs.msg.Bool.Resolve(msg.is_online)
    }
    else {
      resolved.is_online = new std_msgs.msg.Bool()
    }

    if (msg.last_seen_time !== undefined) {
      resolved.last_seen_time = std_msgs.msg.Time.Resolve(msg.last_seen_time)
    }
    else {
      resolved.last_seen_time = new std_msgs.msg.Time()
    }

    if (msg.topic_namespace !== undefined) {
      resolved.topic_namespace = std_msgs.msg.String.Resolve(msg.topic_namespace)
    }
    else {
      resolved.topic_namespace = new std_msgs.msg.String()
    }

    if (msg.agent_ID !== undefined) {
      resolved.agent_ID = msg.agent_ID;
    }
    else {
      resolved.agent_ID = 0
    }

    return resolved;
    }
};

module.exports = GraphSlamAgent;
