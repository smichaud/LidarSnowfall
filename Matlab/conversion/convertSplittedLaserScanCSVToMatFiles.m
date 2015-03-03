function convertSplittedLaserScanCSVToMatFiles(directory)
% Load a directory of splitted csv files and save them in mat files
% Save variable is named 'laserScanData', user must manage it after

files = dir(directory);

header = [];
filesCount = length(files);
for i = 1:filesCount
    if ~files(i).isdir
        fileName = files(i).name;
        completeFilePath = [directory '/' fileName];
        
        if isempty(header)
            [data header] = parseRawCSV(completeFilePath);
                laserScanData = createLaserScanStruct(header, data);
        else
            data = csvread(completeFilePath);
            laserScanData = createLaserScanStruct(header, data);
        end
        save([directory, '/', fileName, '.mat'], 'laserScanData');
    end
end

end

