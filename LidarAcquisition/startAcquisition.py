#!/usr/bin/python
import os, sys, time

def initLogFile():
    currentDate = time.strftime("%Y-%m-%d")
    currentDateTime = time.strftime("%Y-%m-%d-%H-%M-%S")
    os.system("echo '######################################################' " + " >> ./logFiles/log_" + currentDate + ".txt")
    os.system("echo '#### " + currentDateTime + "' >> ./logFiles/log_" + currentDate + ".txt")
    os.system("echo '######################################################' " + " >> ./logFiles/log_" + currentDate + ".txt")

def runBackgroundCommand(command):
    commandPrefix = "nohup " # Prevent program hang-up
    #commandSuffix = " > /dev/null 2>&1&" # Prevent all command output
    currentDate = time.strftime("%Y-%m-%d")
    commandSuffix = " >> ./logFiles/log_" + currentDate + ".txt 2>&1&" # Write all output in a file

    os.system(commandPrefix + command + commandSuffix);

def showWarnings():
    print "Notes:"
    print "- Don't forget to give the SICK LMS200 serial permission (sudo chmod a+rw /dev/ttyUSB0)"
    print "- The Hokuyo UTM-30LX-EW seems to be whimsical/brittle on startup. Unplug and replug it"
    print ""

def startRosCore():
    print "Starting roscore..."
    runBackgroundCommand("roscore")
    time.sleep(10) # Let roscore start properly
    print ""

def startCamera():
    print "Starting the camera..."
    cameraCommand = "rosrun usb_cam usb_cam_node _video_device:='/dev/video0' "
    
    print cameraCommand
    runBackgroundCommand(cameraCommand)
    time.sleep(3)
    print ""

def startCameraTopicDrop():
    print "Starting the camera drop topic tool..."
    # Base topic rate is 30 Hz    
    dropNumerator = '299'
    dropDenominator = '300'
    cameraTopicDropCommand = "rosrun topic_tools drop /usb_cam/image_raw " + dropNumerator + " " + dropDenominator
    
    print cameraTopicDropCommand
    runBackgroundCommand(cameraTopicDropCommand)    
    time.sleep(3)
    print ""

def startVelodyne():
    print "Starting the Velodyne..."
    velodyneCommand = "roslaunch velodyne_pointcloud 32e_points_snow.launch "
    velodyneCommand = velodyneCommand + "calibration:=/home/cobra/Desktop/LidarAcquisition/configFiles/32db.yaml"
    
    print velodyneCommand
    runBackgroundCommand("rosrun tf static_transform_publisher name:=velotf 0 0 0 0 0 0 /base_link /velodyne 100")
    time.sleep(1)

    runBackgroundCommand(velodyneCommand)
    time.sleep(4)
    print ""

def addLaserTf():
    print "Adding a tf between /base_link and /laser"
    runBackgroundCommand("rosrun tf static_transform_publisher name:=lasertf 0 0 0 0 0 0 /base_link /laser 100 ")
    time.sleep(2)
    print "Adding a tf between /base_link and /laser151"
    runBackgroundCommand("rosrun tf static_transform_publisher name:=lasertf 0 0 0 0 0 3.1416 /base_link /laser151 500 ")
    time.sleep(2)
    print ""

def startHokuyo():
    print "Starting the Hokuyo UTM-30LX-EW..."
    hokuyoCommand = "rosrun urg_node urg_node "
    hokuyoCommand = hokuyoCommand + "_ip_address:='192.168.0.10' "
    hokuyoCommand = hokuyoCommand + "_min_ang:=-0.5 "
    hokuyoCommand = hokuyoCommand + "_max_ang:=0.5 "
    hokuyoCommand = hokuyoCommand + "_intensity:='true' " 
    hokuyoCommand = hokuyoCommand + "_skip:=1 "
    hokuyoCommand = hokuyoCommand + "_cluster:=1 "      
    
    print hokuyoCommand
    runBackgroundCommand(hokuyoCommand)
    time.sleep(4)
    print ""

def startLMS200():
    print "Starting the SICK LMS200..."
    lms200Command = "rosrun sicktoolbox_wrapper sicklms "
    lms200Command = lms200Command + "scan:=/lms200/scan "
    lms200Command = lms200Command + "diagnostics:=/lms200/diagnostics "
    lms200Command = lms200Command + "_port:='/dev/ttyUSB0' "
    lms200Command = lms200Command + "_baud:=38400 "       

    print lms200Command
    runBackgroundCommand(lms200Command)
    time.sleep(3)
    print ""

def startLMS151():
    print "Starting the SICK LMS151..."
    lms151Command = "rosrun lms1xx LMS1xx_node "
    lms151Command = lms151Command + "scan:=/lms151/scan "
    lms151Command = lms151Command + "_host:='192.168.1.14' "
    lms151Command = lms151Command + "_frame_id:='laser151' "    
    print lms151Command
    
    runBackgroundCommand(lms151Command)
    time.sleep(5)
    print ""

def startRecording():
    print "Starting the rosbag record..."
    topicToRecord = ""
    topicToRecord = "/usb_cam/image_raw_drop "
    topicToRecord = topicToRecord + "/lms151/scan "
    topicToRecord = topicToRecord + "/lms200/scan "
    topicToRecord = topicToRecord + "/velodyne_points "
    topicToRecord = topicToRecord + "/echoes "
    bagRecordCommand = "rosbag record -o ./bagFiles/data " + topicToRecord
    
    runBackgroundCommand(bagRecordCommand)
    time.sleep(2)
    print ""

def showTopics():
    print "Topics started : "
    os.system("rostopic list");
    print "Recording data (not all topics)"

def waitInputToStop():
    print ""
    while raw_input("Type 'stop' and press 'Enter' to stop acquisition: ") != 'stop':
        print "Wrong command !"

def stopAcquisition():
    os.system("pkill -SIGINT record")
    time.sleep(3)    
    os.system("rosnode kill -a")
    time.sleep(2)

    os.system("pkill -f lms151") # Didn't seem to close properly otherwise...
    os.system("pkill -f velodyne") # Didn't seem to close properly otherwise...

    os.system("pkill -SIGINT roscore")

def main():
    initLogFile()    

    showWarnings()

    startRosCore()

    startLMS151()
    startCamera()
    startCameraTopicDrop()    
    startVelodyne()
    addLaserTf()
    startHokuyo()
    startLMS200()
    

    startRecording()
    showTopics()

    waitInputToStop()
    stopAcquisition()

if __name__=="__main__":
   main()
