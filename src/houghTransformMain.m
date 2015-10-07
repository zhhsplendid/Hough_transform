function houghTransformMain( )
    
    eggImage = imread('egg.jpg');
    jupiterImage = imread('jupiter.jpg');
    
    %[eggCenters, eggRadius] = detectCirclesAnyRadius(eggImage, 1);
    %eggCircles = addCircle(eggImage, eggCenters, eggRadius);
    %imshow(eggCircles);
    
    [jupiterCenters, juptierRadius] = detectCirclesAnyRadius(jupiterImage, 0, 5);
    jupiterCircles = addCircle(jupiterImage, jupiterCenters, juptierRadius);
    imshow(jupiterCircles);
    
    
end

