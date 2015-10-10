function [ centers, radius ] = detectCirclesAnyRadius( im, usegradient, fixRadius, THRESHOLD, FRACTION)
% This funtion detect circles with any radius. It can also be used to detect
% fix radius. The function firstly does edge detect, then vote by hough
% transform, last find local max and check those local max points satisfy
% certain conditions (local max and checking are both done by calling function
% localMax.m. See the function for detail checking condition)
%
% @return
%   centers: N * 2 matrix indicates the centers of circles
%   radius: N * 1 matrix indicates the radiuses of circles
% @call
%   [ centers, radius ] = detectCirclesAnyRadius( im, usegradient, fixRadius, THRESHOLD, FRACTION)
%   FRACTION: we need potential circle has at least fraction of pixels were detected as edges
%   THRESHOLD: only those candidates with higher than threshold votes can be chosen as circle.
%   fixRadius: the number for fix radius. If it equals 0, we detect circles with any radius.
%   usegradient: optional flag for whether use gradient direction
%   im: input RGB image.
%
%[centers, radius ] = detectCirclesAnyRadius( im, usegradient, fixRadius)
%   With out input of FRACTION and THRESHOLD, we use default number
%   if usegradient
%       THRESHOLD = 4; 
%       FRACTION = 0.24;
%   else
%       THRESHOLD = 12;
%       FRACTION = 1/3;
%   end

    intensity = double(rgb2gray(im));
    imEdge = edge(intensity, 'canny');
    
    if nargin < 4
        if usegradient
            THRESHOLD = 4; 
            FRACTION = 0.24;
        else
            THRESHOLD = 12;
            FRACTION = 1/3;
        end
    end
    MIN_RADIUS = 2;
    
    if usegradient
        %TODO detect gradient
        xGradient = imfilter(intensity, [-1, 1] );
        yGradient = imfilter(intensity, [-1, 1]');
        gradientDirections = atan2(yGradient, xGradient);
        
        if fixRadius ~= 0
            voteMatrix = houghVoteMatrix(imEdge, fixRadius, gradientDirections);
            [centers, radius] = localMax(voteMatrix, THRESHOLD, FRACTION, imEdge, fixRadius);
        else
            [row, col] = size(imEdge);
            MAX_RADIUS = floor(min(row, col) / 2);
            voteMatrix = zeros(row, col, MAX_RADIUS);
            for r = MIN_RADIUS: MAX_RADIUS
                voteMatrix(:,:,r) = houghVoteMatrix(imEdge, r, gradientDirections);
            end
            [centers, radius] = localMax(voteMatrix, THRESHOLD, FRACTION, imEdge);
        end
    else
        if fixRadius ~= 0
            voteMatrix = houghVoteMatrix(imEdge, fixRadius);
            imwrite(mat2gray(voteMatrix), 'hough_accumulator_array.jpg');
            [centers, radius] = localMax(voteMatrix, THRESHOLD, FRACTION, imEdge, fixRadius);
        else
            [row, col] = size(imEdge);
            MAX_RADIUS = floor(min(row, col) / 2);
            voteMatrix = zeros(row, col, MAX_RADIUS);
            for r = MIN_RADIUS: MAX_RADIUS
                
                voteMatrix(:,:,r) = houghVoteMatrix(imEdge, r);
            end
            [centers, radius] = localMax(voteMatrix, THRESHOLD, FRACTION, imEdge);
        end
    end
end

