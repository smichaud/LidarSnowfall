% hdf5tools from
% http://www.mathworks.com/matlabcentral/fileexchange/17172-hdf5tools
addpath('./hdf5tools/');

hdf5File = '/home/smichaud/Desktop/test.hdf5';

hdf5FileInfo = hdf5info(hdf5File);
rootGroup = hdf5FileInfo.GroupHierarchy;

showHdf5Hierarchy(rootGroup)

loadGroupDataset = true;
if loadGroupDataset
    groupIndex = 1;
    datasetIndex = 1;
    
    datasetName = rootGroup.Groups(groupIndex).Datasets(datasetIndex).Name;
    datasetSize = rootGroup.Groups(groupIndex).Datasets(datasetIndex).Dims;
    datasetRank = rootGroup.Groups(groupIndex).Datasets(datasetIndex).Rank;

    start = zeros(1, datasetRank);
    count = [datasetSize]; % Useful for partial reading
    stride = ones(1, datasetRank); % Useful for subsampling
    data = h5varget(hdf5File, datasetName, start, count, stride);
end

showImagesExample = true;
if showImagesExample
    images = hdf5read(hdf5File, '/Camera/images');
    images = permute(images, [4, 3, 2, 1]);
    images = double(images)/255;
    
    figure;
    hold on;
    imagesCount = size(images, 4);
    for i = 1:imagesCount        
        imshow(images(:,:,:,i));
        pause(1);
    end
end