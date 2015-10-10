function [ centers, radius ] = detectCirclesAnyRadius( im, usegradient, fixRadius, THRESHOLD, FRACTION)
% This funtion detect circles with any radius. It can also be used to detect
% fix radius.

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

