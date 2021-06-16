function [imageInput, imageTarget] = GetImages(dirName, filter, reverse)
if (~exist('reverse', 'var'))
    reverse = 0;
end

numImageTypes = 10;

files = dir(dirName);
numFiles = length(files);

numFilesPerType = numFiles / numImageTypes;

fileNames = strings(1, numFiles);
for i = 1 : numFiles
    fileNames(i) = files(i).name;
end

% SORT FILES
num = cellfun(@(x) sscanf(x, filter), fileNames);
[~, sortindex] = sort(num);
fileNames2 = fileNames(sortindex);

if (reverse == 1)
    fileNames2 = fliplr(fileNames2);
end
resolution = 21;
imageInput = zeros(resolution * resolution, numFiles);
imageTarget = zeros(numImageTypes, numFiles);
for i = 1 : numFiles
    image = imread(strcat(files(i).folder, '\', fileNames2(i)));
    if (size(image, 3) > 1)
        image = rgb2gray(image);
    end
    image = imresize(image, [resolution resolution]);
    imageInput(:,i) = image(:);
    j = floor((i - 1) / numFilesPerType) + 1;
    imageTarget(j, i) = 1;
end
end
