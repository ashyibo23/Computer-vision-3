
function [counter] = largeCutBlue(Irgb, bagDetector)

    counter=0;
    %Assumming larger region have not contains 2x4 block, the score should 
    %be great enough.
    [label, scores]=predict(bagDetector,Irgb);
    frontD=abs(scores(1,1)-scores(1,3));
    backD=abs(scores(1,2)-scores(1,3));
    if label~=3 && frontD > 0.25 
        counter=counter+1;
    elseif label~=3 && backD > 0.25
        counter=counter+1;
    end
end