
function [If]=segm(I, color)
    se = strel('disk',10);
    nhood=ones(5);
    
    Imgl=rgb2gray(I);
    
    %check the color for segmentation
    if color==0
        col=I(:,:,3);
        Isub=imsubtract(col, Imgl);
        Ib=imbinarize(Isub);
    else
        col=I(:,:,1);
        Isub=imsubtract(col, Imgl);
        Ib=imbinarize(Isub, 0.3);
    end

    %dilation
    Ib=imclose(Ib,se);
    Ib=imdilate(Ib,nhood);
    Ib=imfill(Ib,'holes');

    %Fill the hole that share the edge of picture
    h=size(Ib,1);
    w=size(Ib,2);
    Ib(1:1, :)=1;
    Ib = imfill(Ib,'holes');
    Ib(1:1, :)=0;
    Ib(h:h,:)=1;
    Ib = imfill(Ib,'holes');
    Ib(h:h, :)=0;
    Ib(:,w:w)=1;
    Ib = imfill(Ib,'holes');
    Ib(:,w:w)=0;
    Ib(:,1:1)=1;
    Ib = imfill(Ib,'holes');
    Ib(:,1:1)=0;

    %morphology
    Ib=imclose(Ib,se);
    Iba=bwareaopen(Ib,100);
    If=logical(Iba);
end