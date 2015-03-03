function dataStruct = createPointCloudStruct(header, data)
% Put the point cloud data (Velodyne) into a convenient structure:
% See the commented ROS message description below for more details
% Really hardcoded for now
% Field0: x, offset 0, FLOAT32
% Field1: y, offset 4, FLOAT32
% Field2: z, offset 8, FLOAT32
% Field3: intensity, offset 16, 
% Field4: ring, 20, UINT16
% dataRanges: 
% dataIntensities:

dataStruct = [];

timeIndex = getRawDataIndices(header, 'time');
dataStruct.dataTime = data(:,timeIndex)';

% dataStruct.height = data(getRawDataIndices(header, 'height'));
% dataStruct.width = data(getRawDataIndices(header, 'width'));
% dataStruct.isBigendian = data(getRawDataIndices(header, 'is_bigendian'));
% dataStruct.pointStep = data(getRawDataIndices(header, 'point_step'));
% dataStruct.rowStep = data(getRawDataIndices(header, 'row_step'));

% dataStruct.width = data(1,getRawDataIndices(header, 'fields'));
% 
% 
% [rangeIndices suffixNbr]= ...
%     getRawDataIndices(header, 'ranges', suffix);
% dataStruct.dataRanges(suffixNbr+1,:,i) = data(:,rangeIndices)';
% 
% [intensityIndices suffixNbr] = ...
%     getRawDataIndices(header, 'intensities', suffix);
% dataStruct.dataIntensities(suffixNbr+1,:,i) = ...
%     data(:,intensityIndices)';

end

% http://docs.ros.org/api/sensor_msgs/html/msg/PointCloud2.html
% ===== sensor_msgs/PointCloud2 Message
% # This message holds a collection of N-dimensional points, which may
% # contain additional information such as normals, intensity, etc. The
% # point data is stored as a binary blob, its layout described by the
% # contents of the "fields" array.
% 
% # The point cloud data may be organized 2d (image-like) or 1d
% # (unordered). Point clouds organized as 2d images may be produced by
% # camera depth sensors such as stereo or time-of-flight.
% 
% # Time of sensor data acquisition, and the coordinate frame ID (for 3d
% # points).
% Header header
% 
% # 2D structure of the point cloud. If the cloud is unordered, height is
% # 1 and width is the length of the point cloud.
% uint32 height
% uint32 width
% 
% # Describes the channels and their layout in the binary data blob.
% PointField[] fields
% 
% bool    is_bigendian # Is this data bigendian?
% uint32  point_step   # Length of a point in bytes
% uint32  row_step     # Length of a row in bytes
% uint8[] data         # Actual point data, size is (row_step*height)
% 
% bool is_dense        # True if there are no invalid points

% http://docs.ros.org/api/sensor_msgs/html/msg/PointField.html
% ===== sensor_msgs/PointField Message
% # This message holds the description of one point entry in the
% # PointCloud2 message format.
% uint8 INT8    = 1
% uint8 UINT8   = 2
% uint8 INT16   = 3
% uint8 UINT16  = 4
% uint8 INT32   = 5
% uint8 UINT32  = 6
% uint8 FLOAT32 = 7
% uint8 FLOAT64 = 8
% 
% string name      # Name of field
% uint32 offset    # Offset from start of point struct
% uint8  datatype  # Datatype enumeration, see above
% uint32 count     # How many elements in the field