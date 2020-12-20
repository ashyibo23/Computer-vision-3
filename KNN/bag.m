
% Loading blue block dataset
blue_imds = imageDatastore('dataset/blue','IncludeSubfolders',true,'LabelSource','foldernames');

% Loading red block dataset
red_imds = imageDatastore('dataset/red','IncludeSubfolders',true,'LabelSource','foldernames');

% Tables with labels and images with that specific label
blue_tbl = countEachLabel(blue_imds);
red_tbl = countEachLabel(red_imds);

% Partitioning the data between the training and test images to evaluate
% the performance
[bluetrainingSet, bluevalidationSet] = splitEachLabel(blue_imds, 0.6, 'randomize');
[redtrainingSet, redvalidationSet] = splitEachLabel(red_imds, 0.6, 'randomize');

% Initialing bag of features
blueBag = bagOfFeatures(bluetrainingSet);
redBag = bagOfFeatures(redtrainingSet);

% Training classifiers from bag of features
blueClassifier = trainImageCategoryClassifier(bluetrainingSet, blueBag);
redClassifier = trainImageCategoryClassifier(redtrainingSet, redBag);

% Evaluating training dataset
blueConfMatrix = evaluate(blueClassifier, bluetrainingSet)
redConfMatrix = evaluate(redClassifier, redtrainingSet)

% Evaluating test dataset
blueEvConfMatrix = evaluate(blueClassifier, bluevalidationSet)
redEvConfMatrix = evaluate(redClassifier, redvalidationSet)