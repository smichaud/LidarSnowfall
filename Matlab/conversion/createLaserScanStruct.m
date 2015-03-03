function dataStruct = createLaserScanStruct(header, data, echoesCount)
% Put the laser data (LMS151/200, Hokuyo) into a convenient structure:
% meta data: rangeMin, rangeMax, angleMin, angleMax, angleIncrement,
%            scanTime(seconds), timeIncrement(seconds)
% dataTime: (angleIndex, scanIndex, echoIndex) = timestamp
% dataRanges: (angleIndex, scanIndex, echoIndex) = range
% dataIntensities: (angleIndex, scanIndex, echoIndex) = intensity
if nargin < 3
    echoesCount = 1;
end

dataStruct = [];

timeIndex = getRawDataIndices(header, 'time');
dataStruct.dataTime = data(:,timeIndex)';

dataStruct.rangeMin = data(1,getRawDataIndices(header, 'range_min'));
dataStruct.rangeMax = data(1,getRawDataIndices(header, 'range_max'));

dataStruct.angleMin = data(1,getRawDataIndices(header, 'angle_min'));
dataStruct.angleMax = data(1,getRawDataIndices(header, 'angle_max'));
dataStruct.angleIncrement = ...
    data(1,getRawDataIndices(header, 'angle_increment'));

dataStruct.scanTime = data(1,getRawDataIndices(header, 'scan_time'));
dataStruct.timeIncrement = ...
    data(1,getRawDataIndices(header, 'time_increment'));


beamCount = round((dataStruct.angleMax-dataStruct.angleMin)/...
    dataStruct.angleIncrement)+1;
scanCount = length(dataStruct.dataTime);

containsIntensity = false;
if length(getRawDataIndices(header, 'intensities')) || ...
        length(getRawDataIndices(header, 'intensities', 'echoes0'))
    containsIntensity = true;
    dataStruct.dataIntensities = zeros(beamCount, scanCount, echoesCount);
end

suffix = '';
dataStruct.dataRanges = zeros(beamCount, scanCount, echoesCount);
for i=1:echoesCount
    if echoesCount > 1
        suffix = ['echoes' num2str(i-1)];
    end
    
    [rangeIndices suffixNbr]= ...
        getRawDataIndices(header, 'ranges', suffix);
    dataStruct.dataRanges(suffixNbr+1,:,i) = data(:,rangeIndices)';

    if containsIntensity
        [intensityIndices suffixNbr] = ...
            getRawDataIndices(header, 'intensities', suffix);
        dataStruct.dataIntensities(suffixNbr+1,:,i) = ...
            data(:,intensityIndices)';
    end
end

end
























