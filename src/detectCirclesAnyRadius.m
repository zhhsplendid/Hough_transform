function [ centers, radius ] = detectCirclesAnyRadius( im, usegradient, fixRadius)
    
    intensity = double(rgb2gray(im));
    imEdge = edge(intensity, 'canny');
    THRESHOLD = 20; %At least THRESHOLD votes in a pixel can a pixel be a center
    MIN_RADIUS = 2;
    
    if usegradient
        %TODO detect gradient
        xGradient = imfilter(intensity, [-1, 1] );
        yGradient = imfilter(intensity, [-1, 1]');
        
        gradientDirections = atan2(yGradient, xGradient);
        
        if nargin == 3
            voteMatrix = houghVoteMatrix(imEdge, fixRadius, gradientDirections);
            [centers, radius] = localMax(voteMatrix, THRESHOLD, fixRadius);
        else
            [row, col] = size(imEdge);
            MAX_RADIUS = min(row, col) / 2;
            voteMatrix = zeros(row, col, MAX_RADIUS);
            for r = MIN_RADIUS: MAX_RADIUS
                voteMatrix(:,:,r) = houghVoteMatrix(imEdge, r, gradientDirections);
            end
            [centers, radius] = localMax(voteMatrix, THRESHOLD);
        end
    else
        if nargin == 3
            voteMatrix = houghVoteMatrix(imEdge, fixRadius);
            [centers, radius] = localMax(voteMatrix, THRESHOLD, fixRadius);
        else
            [row, col] = size(imEdge);
            MAX_RADIUS = min(row, col) / 2;
            voteMatrix = zeros(row, col, MAX_RADIUS);
            for r = MIN_RADIUS: MAX_RADIUS
                voteMatrix(:,:,r) = houghVoteMatrix(imEdge, r);
            end
            [centers, radius] = localMax(voteMatrix, THRESHOLD);
        end
    end
    
    %circles = addCircle(im, centers, radius);
    %subplot(1, 3, 1);
    %imshow(imEdge)
    
    %subplot(1, 3, 3);
    %imshow(circles);
    
    
end

