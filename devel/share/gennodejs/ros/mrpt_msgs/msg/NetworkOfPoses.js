// Auto-generated. Do not edit!

// (in-package mrpt_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let NodeIDWithPose_vec = require('./NodeIDWithPose_vec.js');
let GraphConstraint = require('./GraphConstraint.js');

//-----------------------------------------------------------

class NetworkOfPoses {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.root = null;
      this.nodes = null;
      this.constraints = null;
    }
    else {
      if (initObj.hasOwnProperty('root')) {
        this.root = initObj.root
      }
      else {
        this.root = 0;
      }
      if (initObj.hasOwnProperty('nodes')) {
        this.nodes = initObj.nodes
      }
      else {
        this.nodes = new NodeIDWithPose_vec();
      }
      if (initObj.hasOwnProperty('constraints')) {
        this.constraints = initObj.constraints
      }
      else {
        this.constraints = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NetworkOfPoses
    // Serialize message field [root]
    bufferOffset = _serializer.uint64(obj.root, buffer, bufferOffset);
    // Serialize message field [nodes]
    bufferOffset = NodeIDWithPose_vec.serialize(obj.nodes, buffer, bufferOffset);
    // Serialize message field [constraints]
    // Serialize the length for message field [constraints]
    bufferOffset = _serializer.uint32(obj.constraints.length, buffer, bufferOffset);
    obj.constraints.forEach((val) => {
      bufferOffset = GraphConstraint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NetworkOfPoses
    let len;
    let data = new NetworkOfPoses(null);
    // Deserialize message field [root]
    data.root = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [nodes]
    data.nodes = NodeIDWithPose_vec.deserialize(buffer, bufferOffset);
    // Deserialize message field [constraints]
    // Deserialize array length for message field [constraints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.constraints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.constraints[i] = GraphConstraint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += NodeIDWithPose_vec.getMessageSize(object.nodes);
    length += 360 * object.constraints.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/NetworkOfPoses';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2f7e17a78e81d376b3e999d635df4228';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Represents a 2D/3D Directed Graph of Constraints
    #
    # Graph consists of:
    # - NodeIDs with their corresponding poses
    # - Directed Constraints that connect 2 nodes with each other
    # - Root node marking the start of the graph
    
    uint64 root
    NodeIDWithPose_vec nodes
    GraphConstraint[] constraints
    
    ================================================================================
    MSG: mrpt_msgs/NodeIDWithPose_vec
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
    
    ================================================================================
    MSG: mrpt_msgs/GraphConstraint
    # Graph constraint that connects 2 nodes
    #
    # Currently used in the mrpt_graphslam_2d ROS application.
    
    uint64 nodeID_from
    uint64 nodeID_to
    geometry_msgs/PoseWithCovariance constraint
    
    ================================================================================
    MSG: geometry_msgs/PoseWithCovariance
    # This represents a pose in free space with uncertainty.
    
    Pose pose
    
    # Row-major representation of the 6x6 covariance matrix
    # The orientation parameters use a fixed-axis representation.
    # In order, the parameters are:
    # (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
    float64[36] covariance
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new NetworkOfPoses(null);
    if (msg.root !== undefined) {
      resolved.root = msg.root;
    }
    else {
      resolved.root = 0
    }

    if (msg.nodes !== undefined) {
      resolved.nodes = NodeIDWithPose_vec.Resolve(msg.nodes)
    }
    else {
      resolved.nodes = new NodeIDWithPose_vec()
    }

    if (msg.constraints !== undefined) {
      resolved.constraints = new Array(msg.constraints.length);
      for (let i = 0; i < resolved.constraints.length; ++i) {
        resolved.constraints[i] = GraphConstraint.Resolve(msg.constraints[i]);
      }
    }
    else {
      resolved.constraints = []
    }

    return resolved;
    }
};

module.exports = NetworkOfPoses;
