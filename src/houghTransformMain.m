function houghTransformMain( )
% Main function calls detect circle function and show the circle detected
% The circles in image will be shown by red curves.

    eggImage = imread('egg.jpg');
    jupiterImage = imread('jupiter.jpg');
    coinsImage = imread('coins.jpg');
    
    radius = 5;
    [eggCenters, eggRadius] = detectCirclesAnyRadius(eggImage, 0, radius, 12, 1/3);
    eggCircles = addCircle(eggImage, eggCenters, eggRadius);
    figure;
    imshow(eggCircles);
    title(['Detect circle in egg.jpg, radius = ', num2str(radius)]);
    
    radius = 110;
    [jupiterCenters, juptierRadius] = detectCirclesAnyRadius(jupiterImage, 1, radius);
    jupiterCircles = addCircle(jupiterImage, jupiterCenters, juptierRadius);
    figure;
    imshow(jupiterCircles);
    title(['Detect circle in juptier.jpg, radius = ', num2str(radius)]);
    
    radius = 24;
    [coinsCenters, coinsRadius] = detectCirclesAnyRadius(coinsImage, 0, radius, 40, 0.4);
    coinsCircles = addCircle(coinsImage, coinsCenters, coinsRadius);
    figure;
    imshow(coinsCircles);
    title(['Detect circles in coins.jpg, radius = ', num2str(radius)]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Extra points: Detect any radius                           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [coinsCenters, coinsRadius] = detectCirclesAnyRadius(coinsImage, 0, 0, 40, 0.4);
    coinsCircles = addCircle(coinsImage, coinsCenters, coinsRadius);
    figure;
    imshow(coinsCircles);
    title(['Detect circles in coins.jpg with any radius']);
    
    [eggCenters, eggRadius] = detectCirclesAnyRadius(eggImage, 0, 0, 10, 0.4);
    eggCircles = addCircle(eggImage, eggCenters, eggRadius);
    figure;
    imshow(eggCircles);
    title(['Detect circle in egg.jpg with any radius']);
    
    
    [jupiterCenters, juptierRadius] = detectCirclesAnyRadius(jupiterImage, 1, 0, 4, 0.24);
    jupiterCircles = addCircle(jupiterImage, jupiterCenters, juptierRadius);
    figure;
    imshow(jupiterCircles);
    title(['Detect circle in juptier.jpg with any radius']);
    
end

