function [indices nameSuffixNbr] = ...
    getRawDataIndices(header, dataName, dataSuffix)
% Return all indices that match the dataName field (regex based)
% dataSuffix could be used to cover specific suffix (e.g. echoes0) 
if nargin <= 2 
    dataSuffix = '';
end
if length(dataSuffix > 0) && dataSuffix(1) ~= '.'
    dataSuffix = ['\.' dataSuffix]; 
end

patternStart = ['^(field\.)?'];
dataName = [dataName '([0-9]*)'];
patternEnd = ['\s*$'];
pattern = [patternStart dataName dataSuffix patternEnd];

indices = [];
nameSuffixNbr = [];
nbOfHeader = length(header);
for i = 1:nbOfHeader
    [tokens,matches] = regexp(header{i}, pattern, 'tokens', 'match');
    if length(matches) > 0
        indices(end+1) = i;
        if length(tokens) > 0 && length(tokens{1}{2}) > 0
            nameSuffixNbr(end+1) = str2num(tokens{1}{2});
        end
    end
end

end
