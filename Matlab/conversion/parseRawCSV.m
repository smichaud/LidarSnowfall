function [ data, header ] = parseRawCSV(filename)
fileID = fopen(filename);
header = fgets(fileID);
header = header(2:end);
fclose(fileID);
header = strsplit(header,',');

startingRow = 1; % Ignore header (Zero-based)
startingCol = 0;
data = csvread(filename, startingRow, startingCol);

end

