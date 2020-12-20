function [blueClassifier,redClassifier] = trainKNNClassifiers()
    
    % Loading training images
    f=dir('training_images/*.jpg');
    files={f.name};
    for k=1:numel(files)
      img=imread(append('training_images/',files{k}));
      Im{k}=imresize(img,[1200 1600]); 
    end
    
    % Setting image labels
    img_labels = [3 1;
                  4 1;
                  4 2;
                  2 1;
                  3 0;
                  1 3;
                  1 0;
                  3 2;
                  1 0;
                  2 0;
                  2 3;
                  1 0];

    blueData = [];
    redData = [];
    
    % Preprocessing images to classification: Segment by blue and red
    % colors and reshaping them to append to blueData and redData arrays
    
    for i=1:numel(Im)
        img = Im{i};
        [blueBin,redBin,blueImg,redImg] = color_segmentation(img);
        blueData = [blueData; im2gray(reshape(blueImg,1,[]))];
        redData = [redData; im2gray(reshape(redImg,1,[]))];
   
    end

    % Initializing and training different K-nearest neighbor classifiers:
    % This, to evaluate each segmentated data with two different
    % classifiers

    blueClassifier = fitcknn(blueData,img_labels(:,1));
    redClassifier = fitcknn(redData,img_labels(:,2));
    
end

