function showHdf5Hierarchy(group, indentation)

if nargin < 2
    indentation = '';
end

disp([indentation group.Name])

indentation = [indentation '  '];

datasetsCount = length(group.Datasets);
for datasetIndex = 1:datasetsCount;
    datasetName = group.Datasets(datasetIndex).Name;
    datasetSize = group.Datasets(datasetIndex).Dims;

    outputText = [indentation datasetName ' ' mat2str(datasetSize)];
    disp(outputText);
end

groupsCount = length(group.Groups);
for groupIndex = 1:groupsCount 
    showHdf5Hierarchy(group.Groups(groupIndex), indentation);
end

end

