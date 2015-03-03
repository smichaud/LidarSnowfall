#!/usr/bin/python
import os, sys, time

def main():
    commandPrefix = "nohup "
    commandSuffix = " > /dev/null 2>&1&" # Prevent all command output

    rvizConfigFile = "/home/cobra/Desktop/LidarAcquisition/configFiles/vizLiDARs.rviz"
    rvizCommand = "rosrun rviz rviz -d " + rvizConfigFile
    os.system(commandPrefix + rvizCommand + commandSuffix);
    
    time.sleep(2)
    
    imageViewCommand = "rosrun image_view image_view image:=/usb_cam/image_raw compressed"
    os.system(commandPrefix + imageViewCommand + commandSuffix);
    

if __name__=="__main__":
   main()
