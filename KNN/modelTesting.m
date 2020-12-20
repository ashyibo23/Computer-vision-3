close all
clear all
warning off

% Loading training images
f=dir('training_images/*.jpg');
files={f.name};
for k=1:numel(files)
  img=imread(append('training_images/',files{k}));
  Im{k}=img;
end

% Setting image labels
y_true = [3 1;
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

y_pred = [];

for i=1:numel(Im)
    img = Im{i};
    [numA, numB] = count_lego2(img);
    y_pred = [y_pred;numA numB];
end

eB = reshape(y_pred(:,1)-y_true(:,1),1,[]);
eR = reshape(y_pred(:,2)-y_true(:,2),1,[]);
er = [abs(eB) abs(eR)];
accuracy = 1-sum(er)./sum(reshape(y_true,1,[]))
mse=1/length(er)*sum(er.^2)
