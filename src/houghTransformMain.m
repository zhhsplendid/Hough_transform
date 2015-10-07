function houghTransformMain( )
    
    eggImage = imread('egg.jpg');
    jupiterImage = imread('jupiter.jpg');
    
    [eggCenters, eggRadius] = detectCirclesAnyRadius(eggImage, 0, 5)
    %[jupiterCenters, juptierRadius] = detectCirclesAnyRadius(jupiterImage, 0, 5);
    
    %eggCircles = addCircle(eggImage, eggCenters, eggRadius);
    %imshow(eggCircles);
end

