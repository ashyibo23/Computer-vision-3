function [numA,numB] = segments_filtering(blueBin,redBin)

    lBlueBin = bwlabel(bwareaopen(blueBin,5000));
    lRedBin = bwlabel(bwareaopen(redBin,5000));
    
    blueRegs = regionprops(lBlueBin,'Area','Perimeter','Centroid', 'BoundingBox', 'Image', 'Orientation');
    blue_squareness = (min(sqrt([blueRegs.Area]),[blueRegs.Perimeter]/4)./(max(sqrt([blueRegs.Area]),[blueRegs.Perimeter]/4))).^2;
    b_idx = find((24000 <= [blueRegs.Area]) &([blueRegs.Area] <= 95000) & (0.25 <= blue_squareness));
    blueBlocks = ismember(lBlueBin,b_idx);
    blue_r = regionprops(blueBlocks,'Area');
    numA = size(blue_r,1);
%     figure;imshow(blueBlocks)
%     for cnt = 1:length(blueRegs)
%     text(blueRegs(cnt).Centroid(1),blueRegs(cnt).Centroid(2),num2str(squareness(cnt)),'FontSize',15,'color','red');
%     end

    redRegs = regionprops(lRedBin,'Area','Perimeter','Centroid', 'BoundingBox', 'Image', 'Orientation');
    red_squareness = (min(sqrt([redRegs.Area]),[redRegs.Perimeter]/4)./(max(sqrt([redRegs.Area]),[redRegs.Perimeter]/4))).^2;
    r_idx = find((33000 <= [redRegs.Area]) & ([redRegs.Area] <= 65000) & (0.20 <= red_squareness));
    redBlocks = ismember(lRedBin,r_idx);
    red_r = regionprops(redBlocks,'Area');
    numB = size(red_r,1);
%     figure;imshow(redBlocks)
%     for cnt = 1:length(redRegs)
%     text(redRegs(cnt).Centroid(1),redRegs(cnt).Centroid(2),num2str(red_squareness(cnt)),'FontSize',15,'color','red');
%     end
end