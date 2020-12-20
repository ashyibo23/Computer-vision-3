function [blueImg, redImg, blueBin, redBin] = color_segmentation(img)
    img = imadd(img,2);
    img=imresize(img,[1200 1600]); 
    blueRange = [0.58 0.7]; % Range of hue values considered 'blue'
    redRange1 = [0 0.068]; % Range of hue values considered 'red'
    redRange2 = [0.7 1];
    minSat = 0.5; % Minimum saturation value for 'colored' pixels to exclude bkgd noise
    %%%%%%%%%%%%%%%%%%%
    % Denoise with a gaussian blur
    imgfilt = imfilter(img, fspecial('gaussian', 10, 2));
    % Convert image to HSV format
    hsvImg = rgb2hsv(imgfilt);

    % Threshold hue to get only green pixels and saturation for only colored
    % pixels
    blueBin = hsvImg(:,:,1) > blueRange(1) & hsvImg(:,:,1) < blueRange(2) & hsvImg(:,:,2) > minSat;
    blueBin = bwmorph(blueBin, 'close'); % Morphological closing to take care of some of the noisy thresholding
    redBin1 = hsvImg(:,:,1) > redRange1(1) & hsvImg(:,:,1) < redRange1(2) &  hsvImg(:,:,2) > minSat;
    redBin2 = hsvImg(:,:,1) > redRange2(1) & hsvImg(:,:,1) < redRange2(2) & hsvImg(:,:,2) > minSat;
    redBin = imadd(redBin1,redBin2);
    redBin = bwmorph(redBin, 'close'); % Morphological closing to take care of some of the noisy thresholding
    blueMask = repmat(blueBin,[1 1 3]);
    redMask = repmat(redBin,[1 1 3]);
    blueImg = immultiply(img,blueMask);
    redImg = immultiply(img,redMask);
    
    % Plotting regions of interest (just for graphical visualization of the
    % data preprocessing) 
    % P.S: COMMENT THIS LINES BELOW BEFORE TESTING WITH VARIOUS IMAGES
    
    % plotRegions(img,blueBin);
    % plotRegions(img,redBin);
end
