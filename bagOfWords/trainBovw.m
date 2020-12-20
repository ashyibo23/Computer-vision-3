
function []=trainBovw()
    %----blue----
    %get images from folders
    imbr=imageDatastore('bluerot');
    imbbs=imageDatastore('blue_backrot');
    imdbor=imageDatastore('blue_othersrot');
    
    %make the truth label
    lb=zeros(1,size(imbr.Files,1));
    lbb=ones(1,size(imbbs.Files,1));
    lbo=ones(1,size(imdbor.Files,1));
    lbo(:,:)=2;
    
    imbr.Labels=lb;
    imbbs.Labels=lbb;
    imdbor.Labels=lbo;
    
    %combine all images and lables
    blueclatimds=imageDatastore(cat(1, imbr.Files, imbbs.Files, imdbor.Files));
    blueclatimds.Labels=[lb lbb lbo];
    
    %train the model
    bluebag=bagOfFeatures(blueclatimds);
    blueCategoryClassifier = trainImageCategoryClassifier(blueclatimds,bluebag);
    save('rgbbc.mat','blueCategoryClassifier');
    confMatrix = evaluate(blueCategoryClassifier,blueclatimds);
    mean(diag(confMatrix));
    
    
    %----red----
    %get images from folders
    imr=imageDatastore('redrot');
    imrb=imageDatastore('red_backrot');
    imro=imageDatastore('red_othersrot');
    
    %make the truth label
    lb=zeros(1,size(imr.Files,1));
    lbb=ones(1,size(imrb.Files,1));
    lbo=ones(1,size(imro.Files,1));
    lbo(:,:)=2;
    
    imr.Labels=lb;
    imrb.Labels=lbb;
    imro.Labels=lbo;
    
    %combine all images and lables
    redclatimds=imageDatastore(cat(1, imr.Files, imrb.Files, imro.Files));
    redclatimds.Labels=[lb lbb lbo];
    
    %train the model
    redBag=bagOfFeatures(redclatimds);
    redCategoryClassifier = trainImageCategoryClassifier(redclatimds,redBag);
    save('redBag.mat','redCategoryClassifier');
    confMatrix = evaluate(redCategoryClassifier,redclatimds);
    mean(diag(confMatrix));
end