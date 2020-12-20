function [numA,numB] = count_lego(I)
    I  = imresize(I,[1200 1600]);
    warning off;
    [blueImg,redImg,blueBin,redBin] = color_segmentation(I);
    [numA,numB] = segments_filtering(blueBin,redBin);    
end

%[numA,numB] = count_lego(imread('train08.jpg'))
%[numA,numB] = count_lego(imread('training_images/train02.jpg'))
