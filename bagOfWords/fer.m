
function [ratios, minOut, maxOut] = fer(I)
    %measures the minimum Feret properties of objects
    [minOut,~] = bwferet(I,'MinFeretProperties');
    %measures the maximum Feret properties of objects
    [maxOut,~] = bwferet(I,'MaxFeretProperties');
    
    %measures the ratio
    ratios=minOut.MinDiameter(1) / maxOut.MaxDiameter(1);
end

