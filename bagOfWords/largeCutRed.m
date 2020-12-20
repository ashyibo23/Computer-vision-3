

function [counter] = largeCutRed(Irgb, bagDetector)
    counter=0;
    %Assumming larger region have not contains 2x2 block, the score should 
    %be great enough.
    [label, scores]=predict(bagDetector,Irgb);
    frontD=abs(scores(1,1)-scores(1,4));
    backD=abs(scores(1,2)-scores(1,4));
    sideD=abs(scores(1,3)-scores(1,4));
    if label~=4 && frontD > 0.35 
        counter=counter+1;
    elseif label~=4 && backD > 0.35
        counter=counter+1;
    elseif label~=4 && sideD > 0.35
        counter=counter+1;
    end
end