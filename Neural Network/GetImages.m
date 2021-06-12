function [images] = GetImages(dirName)
    files = dir(dirName);
    numFiles = length(files);
    resolution = 21;
    images = zeros(resolution, resolution, numFiles, 'uint8');
    for i = 1 : numFiles
        image = imread(strcat(files(i).folder, '\', files(i).name));
        image = imresize(image, [resolution resolution]);
        images(:,:,i) = image;
    end
end
