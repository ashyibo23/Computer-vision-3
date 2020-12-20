
function [numA,numB]=count_lego(I)
    I=imresize(I, [1200 1600]);
    blueBag=load('blueBag.mat');
    blueBagDetector=blueBag.blueCategoryClassifier;
    numA=counter(I, blueBagDetector, 0);
    
    redBag=load('redBag.mat');
    redBagDetector=redBag.redCategoryClassifier;
    numB=counter(I, redBagDetector, 1);
end
