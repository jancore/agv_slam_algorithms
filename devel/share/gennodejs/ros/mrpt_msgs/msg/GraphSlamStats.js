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

class GraphSlamStats {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.nodes_total = null;
      this.edges_total = null;
      this.edges_ICP2D = null;
      this.edges_ICP3D = null;
      this.edges_odom = null;
      this.loop_closures = null;
      this.slam_evaluation_metric = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('nodes_total')) {
        this.nodes_total = initObj.nodes_total
      }
      else {
        this.nodes_total = 0;
      }
      if (initObj.hasOwnProperty('edges_total')) {
        this.edges_total = initObj.edges_total
      }
      else {
        this.edges_total = 0;
      }
      if (initObj.hasOwnProperty('edges_ICP2D')) {
        this.edges_ICP2D = initObj.edges_ICP2D
      }
      else {
        this.edges_ICP2D = 0;
      }
      if (initObj.hasOwnProperty('edges_ICP3D')) {
        this.edges_ICP3D = initObj.edges_ICP3D
      }
      else {
        this.edges_ICP3D = 0;
      }
      if (initObj.hasOwnProperty('edges_odom')) {
        this.edges_odom = initObj.edges_odom
      }
      else {
        this.edges_odom = 0;
      }
      if (initObj.hasOwnProperty('loop_closures')) {
        this.loop_closures = initObj.loop_closures
      }
      else {
        this.loop_closures = 0;
      }
      if (initObj.hasOwnProperty('slam_evaluation_metric')) {
        this.slam_evaluation_metric = initObj.slam_evaluation_metric
      }
      else {
        this.slam_evaluation_metric = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GraphSlamStats
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [nodes_total]
    bufferOffset = _serializer.int32(obj.nodes_total, buffer, bufferOffset);
    // Serialize message field [edges_total]
    bufferOffset = _serializer.int32(obj.edges_total, buffer, bufferOffset);
    // Serialize message field [edges_ICP2D]
    bufferOffset = _serializer.int32(obj.edges_ICP2D, buffer, bufferOffset);
    // Serialize message field [edges_ICP3D]
    bufferOffset = _serializer.int32(obj.edges_ICP3D, buffer, bufferOffset);
    // Serialize message field [edges_odom]
    bufferOffset = _serializer.int32(obj.edges_odom, buffer, bufferOffset);
    // Serialize message field [loop_closures]
    bufferOffset = _serializer.int32(obj.loop_closures, buffer, bufferOffset);
    // Serialize message field [slam_evaluation_metric]
    bufferOffset = _arraySerializer.float64(obj.slam_evaluation_metric, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GraphSlamStats
    let len;
    let data = new GraphSlamStats(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [nodes_total]
    data.nodes_total = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [edges_total]
    data.edges_total = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [edges_ICP2D]
    data.edges_ICP2D = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [edges_ICP3D]
    data.edges_ICP3D = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [edges_odom]
    data.edges_odom = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [loop_closures]
    data.loop_closures = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [slam_evaluation_metric]
    data.slam_evaluation_metric = _arrayDeserializer.float64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 8 * object.slam_evaluation_metric.length;
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/GraphSlamStats';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'eacf2f0450892c9d53ce9dcaa0385298';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Statistics related to the execution of graphSLAM.
    # Message is utilized in the mrpt_graphslam ROS package
    
    # Time of message acquisition
    Header header
    
    # node-related stats
    int32 nodes_total
    
    # edge-related stats
    int32 edges_total
    int32 edges_ICP2D
    int32 edges_ICP3D
    int32 edges_odom
    int32 loop_closures
    
    # Evaluation metric of the SLAM process
    float64[] slam_evaluation_metric
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GraphSlamStats(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.nodes_total !== undefined) {
      resolved.nodes_total = msg.nodes_total;
    }
    else {
      resolved.nodes_total = 0
    }

    if (msg.edges_total !== undefined) {
      resolved.edges_total = msg.edges_total;
    }
    else {
      resolved.edges_total = 0
    }

    if (msg.edges_ICP2D !== undefined) {
      resolved.edges_ICP2D = msg.edges_ICP2D;
    }
    else {
      resolved.edges_ICP2D = 0
    }

    if (msg.edges_ICP3D !== undefined) {
      resolved.edges_ICP3D = msg.edges_ICP3D;
    }
    else {
      resolved.edges_ICP3D = 0
    }

    if (msg.edges_odom !== undefined) {
      resolved.edges_odom = msg.edges_odom;
    }
    else {
      resolved.edges_odom = 0
    }

    if (msg.loop_closures !== undefined) {
      resolved.loop_closures = msg.loop_closures;
    }
    else {
      resolved.loop_closures = 0
    }

    if (msg.slam_evaluation_metric !== undefined) {
      resolved.slam_evaluation_metric = msg.slam_evaluation_metric;
    }
    else {
      resolved.slam_evaluation_metric = []
    }

    return resolved;
    }
};

module.exports = GraphSlamStats;
