# LidarSnowfall
- Scripts required for the characterization of the LiDAR during snowfall.
- Note that conversion shell/matlab scripts were based on "rostopic echo -p".
  - rostopic echo -> csv file -> splitted files -> matlab file
- This ROS command doesn't handle sparse data properly. It take the first header and assume all subsequent data is the same, causing misalignments.
- I will create specific ros node to convert data from the bag file directly to HDF5 files. HDF5 files prevent data loss (no transition in a text format) and are handled by matlab.
