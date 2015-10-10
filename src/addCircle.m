function [ outImage ] = addCircle( inputImage, centers, radius)
% This function just add curves to show circles we detected in the
% input image.
%
% @input
%   radius: N * 1 matrix indicates radiuses of circles
%   centers: N * 2 matrix indicates centers of circles
%   inputImage: original input RGB image
% @return
%   outImage: the image we add circles on input image.

    CIRCLE_COLOR = [255, 0, 0]; %RGB color of curve. Here we use red color
    
    outImage = inputImage;
    [row, col, channel] = size(inputImage);
    
    numberCircles = size(centers, 1);
    for n = 1: numberCircles
        ANGLE_ITERATION = 4 + radius(n) * 4;
        THETA_MIN = 2 * pi / ANGLE_ITERATION;  
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

