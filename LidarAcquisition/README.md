# LidarAcquisitioni

- Code to run the lab LiDARs with ros (SICK LMS200, SICK LMS151, Hokuyo UTM-30LX-EW, Velodyne HDL-32E)
- Used ROS Hydro
- This process sequence doesn't handle sparse data properly. It take the first header and assume all subsequent data is the same, causing misalignments.
  - rostopic echo -> csv file -> splitted files -> matlab file
  - There is a bag to hdf5 conversion node at : https://github.com/smichaud/RosDataConversion.git (catkin branch)
  

