function [numA,numB] = count_lego(img)
    [blueImg,redImg,blueBin,redBin] = color_segmentation(img);
    [numA,numB] = segments_filtering(blueBin,redBin); 
    %img = imresize(img,[1200 1600]);
    %warning off
    
    % THIS FUNCTION CAN INITIALIZE AND TRAIN THE CLASSIFIERS OR LOAD THE
    % TRAINED CLASSIFIERS STORES IN THE FILE 'trainedClassifiers.mat'.
    % TO USE ONE OR OTHER OPTION, UNCOMMENT THE ONE YOU WNAT TO USE AND
    % COMMENT THE OTHER ONE
    
    % Initializing and training K-nearest neighbor classifier
    % [blueClassifier, redClassifier] = trainKNNClassifiers();
    
    % Loading trained K-nearest neighbor classifier
    %load('trainedClassifiers.mat');
        
    % Segment images by color blue and red
    %[blueImg,redImg] = color_segmentation(img);
    
    % Preparing blue and red images data to evaluate in classifiers
    %blueImgData = im2gray(reshape(blueImg,1,[]));
    %redImgData = im2gray(reshape(redImg,1,[]));
    
    % Evaluating images in trained classifiers
    %numA = predict(blueClassifier,blueImgData);
    %numB = predict(redClassifier,redImgData);    
end

%[numA,numB] = count_lego(imread('train01.jpg'))
%[numA,numB] = count_lego(imread('training_images/train01.jpg'))
