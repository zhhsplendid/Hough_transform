function [centers] = detectCircles(im, radius, usegradient)
% Hough Transform circle detector that takes an input
% image and a fixed radius, and returns the centers of any detected
% circles of about that size.
%@para
% im is the input image, radius specifies the size of circle we are looking for, and
% usegradient is a flag that allows the user to optionally exploit the gradient direction measured at
% the edge points. The output centers is an N x 2 matrix in which each row lists the x,y position of
% a detected circle’s center.

% Simply call detectCirclesAnyRadius.m with fix radius
    
    [centers, radiuses] = detectCirclesAnyRadius( im, radius, usegradient);

end

