
function [validSt] = validStat(I, color)
    %lower bounds
    lower=100;
    
    %find bounding boxes
    stat=regionprops(I,'boundingbox');
    
    %measures the Feret properties of objects in an image 
    %to calcualte area roughly
    [~, minOut, maxOut]=fer(I);
    areas=zeros(1, size(stat,1));
    for i=1:numel(stat)
        area=minOut.MinDiameter(i)*maxOut.MaxDiameter(i);
        areas(1,i)=area;
    end
    
    %If bounding box is too small, it will be sliced 
    ValidAreas=[];
    st=[];
    for c=1:size(stat,1)
        s=stat(c).BoundingBox;
        if s(3:3)>lower && s(4:4)>lower
            st=[st; stat(c);];
            ValidAreas=[ValidAreas; areas(1,c)];
        end
    end
    
    %If it is for blue and it has more than 4 bounding boxes and smaller 
    %than certan limit, it will also be sliced
    if color == 0 && size(st, 1) > 3
        q=quantile(ValidAreas,4)*1.3;
        validSt=[];
        if color == 0
            for c=1:size(st,1)
                if ValidAreas(c) > q(1,1)
                    validSt=[validSt; st(c,1);];
                end
            end
        end
    else
        validSt=st;
    end
end