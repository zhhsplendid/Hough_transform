function [ outImage ] = addCircle( inputImage, centers, radius)
    ANGLE_ITERATION = 36;
    THETA_MIN = 2 * pi / ANGLE_ITERATION;  
    CIRCLE_COLOR = [0, 0, 255];
    
    outImage = inputImage;
    [row, col] = size(inputImage);
    
    numberCircles = size(centers, 1);
    for n = 1: numberCircles
        for i = 0: ANGLE_ITERATION - 1
            theta = THETA_MIN * i;
            r = round(centers(n, 1) + radius(n) * sin(theta));
            c = round(centers(n, 2) + radius(n) * cos(theta));
            if r >= 1 && r <= row && c >= 1 && c <= col
                outImage(r, c, :) = CIRCLE_COLOR;
            end
        end
    end
end

