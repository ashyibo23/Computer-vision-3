function plotRegions(img,segments)
    minRegionsize = 8000; % Min size for a single block
    % Use regionprops to filter based on area, return location of specific blocks
    regs = regionprops(segments, 'Area', 'Centroid', 'BoundingBox', 'Centroid', 'Image', 'Orientation');
    
    regs(vertcat(regs.Area) < minRegionsize) = [];

    % Display image with bounding boxes overlaid (blue)
    figure()
    image(img);
    axis image
    hold on
    for k = 1:length(regs)
        plot(regs(k).Centroid(1), regs(k).Centroid(2), 'cx');

        boundBox = repmat(regs(k).BoundingBox(1:2), 5, 1) + ...
            [0 0; ...
            regs(k).BoundingBox(3) 0;...
            regs(k).BoundingBox(3) regs(k).BoundingBox(4);...
            0 regs(k).BoundingBox(4);...
            0 0];    
        plot(boundBox(:,1), boundBox(:,2), 'r');
    end
    hold off
end