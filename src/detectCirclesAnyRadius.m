function [ centers, radius ] = detectCirclesAnyRadius( im, usegradient, fixRadius)
    
    intensity = rgb2gray(im);
    imEdge = edge(intensity, 'canny');
    THRESHOLD = 15;
    
    if usegradient
        %TODO
    else
        if nargin == 3
            voteMatrix = houghVoteMatrix(imEdge, fixRadius);
            [centers, radius] = localMax(voteMatrix, THRESHOLD, fixRadius);
            subplot(1, 3, 2);
            imshow(mat2gray(voteMatrix));
        else
            
        end
    end
    
    circles = addCircle(im, centers, radius);
    subplot(1, 3, 1);
    imshow(imEdge)
    
    subplot(1, 3, 3);
    imshow(circles);
    
    
end

