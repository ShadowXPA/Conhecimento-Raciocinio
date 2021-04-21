function Main()
    clear;
    close all;

    a();
end

function a()
    files = dir('Trabalho_Pratico_CR_2020_21/Pasta1/*.jpg');
    numFiles = length(files);
    resolution = 21;
    
    images = zeros(21, 21, numFiles, 'uint8');
    for i = 1 : numFiles
        image = imread(strcat(files(i).folder, '\', files(i).name));
        image = imresize(image, [resolution resolution]);
        images(:,:,i) = image;
    end
end