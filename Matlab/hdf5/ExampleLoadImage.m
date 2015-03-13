img = hdf5read('/home/smichaud/Desktop/image.hdf5', '/Camera/images');
img = permute(img, [3, 2, 1]);
img = double(img)/255;
imshow(img);