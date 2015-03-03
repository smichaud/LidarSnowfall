function convertSplittedPointCloudCSVToMatFiles(directory)
% Load a directory of splitted csv files and save them in mat files
% Save variable is named 'pointCloudData', user must manage it after

files = dir(directory);

pointCloudData = [];
pointCloudData.minScanAngle = -0.5; %rad
pointCloudData.maxScanAngle = 0.5; %rad
pointCloudData.ringAngles = ...
    [-30.67, -29.33, -28, -26.66, -25.33, -24., -22.67, -21.33, -20, ...
     -18.67, -17.33, -16, -14.67, -13.33, -12, -10.67, -9.33, -8, ...
     -6.66, -5.33, -4, -2.67, -1.33, 0, 1.33, 2.67, 4, 5.33, 6.67, 8, ...
     9.33, 10.67];

filesCount = length(files);
for i = 1:filesCount
    if ~files(i).isdir
        fileName = files(i).name;
        completeFilePath = [directory '/' fileName];

        pointCloudData.data = csvread(completeFilePath);  
            
        save([directory, '/', fileName, '.mat'], 'pointCloudData');
    end
end

end

