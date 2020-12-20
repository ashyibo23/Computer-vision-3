function [num]=counter(I, bagDetector, colorNum)  
    %segmentation
    Ib=segm(I, colorNum);
    %find appropriate bounding boxes
    st=validStat(Ib, colorNum);
    
    %calculate area for each bounding box
    areas=zeros(1, size(st,1));
    ratb=zeros(1, size(st,1));
    for c=1:size(st,1)
        areas(1,c)=st(c:c).BoundingBox(3:3)*st(c:c).BoundingBox(4:4);
        if st(c:c).BoundingBox(3:3) < st(c:c).BoundingBox(4:4)
            ratb(1,c)=st(c:c).BoundingBox(3:3)/st(c:c).BoundingBox(4:4);
        else
            ratb(1,c)=st(c:c).BoundingBox(4:4)/st(c:c).BoundingBox(3:3);
        end
    end
    
    avg=sum(areas)/size(st,1);
    %There are different ranges for each
    if colorNum == 0
        range=[0.35 0.65];
    else
        bRange=0.8;
        range=0.55;
    end
    
    %detect too big bounding boxes, otherwise crop the image and apply the
    %bag of visual words 
    big=[];
    counter=0;
    bigRnage=[0.35 0.65];
    for c=1:size(st,1)
        Icrop = imcrop(Ib,[st(c:c).BoundingBox(1:1)-50 st(c:c).BoundingBox(2:2)-50 st(c:c).BoundingBox(3:3)+100 st(c:c).BoundingBox(4:4)+100]);
        IrgbCrop = imcrop(I,[st(c:c).BoundingBox(1:1)-50 st(c:c).BoundingBox(2:2)-50 st(c:c).BoundingBox(3:3)+100 st(c:c).BoundingBox(4:4)+100]);    
        [ratio, ~, ~]=fer(Icrop);
        if areas(1,c) > avg*(1.11.^size(st,1)) && bigRnage(1)<ratio && ratio<bigRnage(2)
            big=[big c];
        else
            if colorNum==0 %----------blue------------       
                [label, score]=predict(bagDetector,IrgbCrop);

                frontD=abs(score(1,1)-score(1,3));
                backD=abs(score(1,2)-score(1,3));
               
                if range(1)<ratio && ratio<range(2) && label~=3
                    counter=counter+1;
                elseif frontD > 0.35 && label~=3
                    counter=counter+1;
                elseif backD > 0.35 && label~=3
                    counter=counter+1;
                end
            else %----------red------------             
                [ratio, ~, ~]=fer(Icrop);
                if bRange<ratb(1,c) && range<ratio
                    [label, score]=predict(bagDetector,IrgbCrop);
                    frontD=abs(score(1,1)-score(1,4));
                    backD=abs(score(1,2)-score(1,4));
                    sideD=abs(score(1,3)-score(1,4));
                    if label ~= 4
                        counter=counter+1;
                    elseif frontD<0.1 && label==4 
                        counter=counter+1;
                    elseif backD<0.1 && label==4
                        counter=counter+1;
                    elseif sideD<0.1 && label==4
                        counter=counter+1;
                    end
                end
            end
        end
    end
    
    %operation for big bounding boxes
    largeCounter=0;
    bs=size(big,2);
    if bs~=0
        for i=1:bs
            b=st(big(1,i):big(1,i));
            IrgbCrop=imcrop(I,[b.BoundingBox(1:1)-50 b.BoundingBox(2:2)-50 b.BoundingBox(3:3)+100 b.BoundingBox(4:4)+100]);
            if colorNum==0
                largeCounter=largeCounter+largeCutBlue(IrgbCrop, bagDetector);
            else
                largeCounter=largeCounter+largeCutRed(IrgbCrop, bagDetector);
            end
        end
    end
    num=counter+largeCounter;
end