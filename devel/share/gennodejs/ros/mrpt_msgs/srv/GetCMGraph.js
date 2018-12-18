// Auto-generated. Do not edit!

// (in-package mrpt_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let NetworkOfPoses = require('../msg/NetworkOfPoses.js');

//-----------------------------------------------------------

class GetCMGraphRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nodeIDs = null;
    }
    else {
      if (initObj.hasOwnProperty('nodeIDs')) {
        this.nodeIDs = initObj.nodeIDs
      }
      else {
        this.nodeIDs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetCMGraphRequest
    // Serialize message field [nodeIDs]
    bufferOffset = _arraySerializer.uint64(obj.nodeIDs, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetCMGraphRequest
    let len;
    let data = new GetCMGraphRequest(null);
    // Deserialize message field [nodeIDs]
    data.nodeIDs = _arrayDeserializer.uint64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.nodeIDs.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'mrpt_msgs/GetCMGraphRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '5f27c6ad84ac86a19b3f9376555dd464';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    
    
    uint64[] nodeIDs
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetCMGraphRequest(null);
    if (msg.nodeIDs !== undefined) {
      resolved.nodeIDs = msg.nodeIDs;
    }
    else {
      resolved.nodeIDs = []
    }

    return resolved;
    }
};

class GetCMGraphResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.cm_graph = null;
    }
    else {
      if (initObj.hasOwnProperty('cm_graph')) {
        this.cm_graph = initObj.cm_graph
      }
      else {
        this.cm_graph = new NetworkOfPoses();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetCMGraphResponse
    // Serialize message field [cm_graph]
    bufferOffset = NetworkOfPoses.serialize(obj.cm_graph, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetCMGraphResponse
    let len;
    let data = new GetCMGraphResponse(null);
    // Deserialize message field [cm_graph]
    data.cm_graph = NetworkOfPoses.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += NetworkOfPoses.getMessageSize(object.cm_graph);
    return length;
  }

  static datatype() {
    // Returns string type for a service object
    return 'mrpt_msgs/GetCMGraphResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bbabb31f01a04e85d128509e707fbf64';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    mrpt_msgs/NetworkOfPoses cm_graph
    
    
    ================================================================================
    MSG: mrpt_msgs/NetworkOfPoses
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
    const resolved = new GetCMGraphResponse(null);
    if (msg.cm_graph !== undefined) {
      resolved.cm_graph = NetworkOfPoses.Resolve(msg.cm_graph)
    }
    else {
      resolved.cm_graph = new NetworkOfPoses()
    }

    return resolved;
    }
};

module.exports = {
  Request: GetCMGraphRequest,
  Response: GetCMGraphResponse,
  md5sum() { return '42fe1c3f75b229167d9c830777c38406'; },
  datatype() { return 'mrpt_msgs/GetCMGraph'; }
};
