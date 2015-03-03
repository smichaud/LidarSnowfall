function convertLaserScanCSVToMatFile(laserScanCSV, varName)
% Input a ROS LaserScan csv and save the parsed structure in a .mat file
[filePath, fileName, fileExt] = fileparts(laserScanCSV);

if nargin < 2
    varName = fileName;
end

[laserScanData laserScanHeader] = parseRawCSV(laserScanCSV);
tmpStruct.(varName) = ...
    createLaserScanStruct(laserScanHeader, laserScanData);

save([filePath, '/', fileName, '.mat'], '-struct', 'tmpStruct');
end

