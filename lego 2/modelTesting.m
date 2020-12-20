close all
clear all
warning off

f=dir('training_images/*.jpg');
files={f.name};
expected_labels = [3 1;
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
img_labels = [];
              
for k=1:numel(files)
    img = imread(append('training_images/',files{k}));
    img = imresize(img,[1200 1600]); 
    [numA, numB] = countLego(img);
    img_labels = [img_labels; numA numB];
end

error = expected_labels - img_labels;
e = reshape(error,1,[]);
mse = (1/length(e))*sum(e.^2)
