// Auto-generated. Do not edit!

// (in-package mrpt_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class GraphConstraint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.nodeID_from = null;
      this.nodeID_to = null;
      this.constraint = null;
    }
    else {
      if (initObj.hasOwnProperty('nodeID_from')) {
        this.nodeID_from = initObj.nodeID_from
      }
      else {
        this.nodeID_from = 0;
      }
      if (initObj.hasOwnProperty('nodeID_to')) {
        this.nodeID_to = initObj.nodeID_to
      }
      else {
        this.nodeID_to = 0;
      }
      if (initObj.hasOwnProperty('constraint')) {
        this.constraint = initObj.constraint
      }
      else {
        this.constraint = new geometry_msgs.msg.PoseWithCovariance();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GraphConstraint
    // Serialize message field [nodeID_from]
    bufferOffset = _serializer.uint64(obj.nodeID_from, buffer, bufferOffset);
    // Serialize message field [nodeID_to]
    bufferOffset = _serializer.uint64(obj.nodeID_to, buffer, bufferOffset);
    // Serialize message field [constraint]
    bufferOffset = geometry_msgs.msg.PoseWithCovariance.serialize(obj.constraint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GraphConstraint
    let len;
    let data = new GraphConstraint(null);
    // Deserialize message field [nodeID_from]
    data.nodeID_from = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [nodeID_to]
    data.nodeID_to = _deserializer.uint64(buffer, bufferOffset);
    // Deserialize message field [constraint]
    data.constraint = geometry_msgs.msg.PoseWithCovariance.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 360;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mrpt_msgs/GraphConstraint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '27a8223828dcd501cdc97873eecdd09e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GraphConstraint(null);
    if (msg.nodeID_from !== undefined) {
      resolved.nodeID_from = msg.nodeID_from;
    }
    else {
      resolved.nodeID_from = 0
    }

    if (msg.nodeID_to !== undefined) {
      resolved.nodeID_to = msg.nodeID_to;
    }
    else {
      resolved.nodeID_to = 0
    }

    if (msg.constraint !== undefined) {
      resolved.constraint = geometry_msgs.msg.PoseWithCovariance.Resolve(msg.constraint)
    }
    else {
      resolved.constraint = new geometry_msgs.msg.PoseWithCovariance()
    }

    return resolved;
    }
};

module.exports = GraphConstraint;
