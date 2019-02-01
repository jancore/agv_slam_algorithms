#!/usr/bin/env python
'''launcher_node ROS Node'''
import rospy
import roslaunch
from std_msgs.msg import String
from os.path import expanduser
msg = ""

def callback(data):
    '''launcher_node Callback Function'''
    global msg
    msg = data.data

def listener():
    '''launcher_node Subscriber'''

    rospy.init_node('launcher_node', anonymous=True)

    rospy.Subscriber("launcher", String, callback)
    rate = rospy.Rate(10)
    files = {'mapping': 'agv_mapping/launch/agv_mrpt_rbpf.launch',
            'localization': 'agv_localization/launch/agv_mrpt.launch'}
    directory = expanduser("~") + "/catkin_ws/src/"
    actualNode = ""
    isLaunched = False

    while not rospy.is_shutdown():
        words = msg.split('_', 1)
        if words[0] == "launch" and not isLaunched:
            isLaunched = True
            actualNode = words[1]
            uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
            roslaunch.configure_logging(uuid)
            launch = roslaunch.parent.ROSLaunchParent(uuid, [directory + files[actualNode]])

            try:
                launch.start()
            except:
                raise NameError("Error! Launch directory is wrong or not exist.", files[actualNode])
            
            rospy.loginfo("started" + actualNode)
        elif words[0] == "shutdown" and actualNode == words[1] and isLaunched:
            isLaunched = False
            actualNode = ""
            launch.shutdown()
        
        rate.sleep()

if __name__ == '__main__':
    try:
        listener()
    except rospy.ROSInterruptException:
        pass
    except NameError as err:
        print("Error in listener(): {0}".format(err))
