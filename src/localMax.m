function [centers, radius] = localMax(voteMatrix, threshold, fraction, imEdge, fixRadius) % 
% This function find local max of voteMatrix, then it check those local max points
% 1. have higher vote value than threshold 
% 2. The piexls in potential circle was marked as edges in edge detect. The
% fraction of marked shouldn't less than input fraction
% 
% @return 
%   centers is N * 2 indicates points for circle centers
%   radius is N * 1 indicates radius of those circles
% @call
%   [centers, radius] = localMax(voteMatrix, threshold, fraction, imEdge, fixRadius)
%   fixRadius: is a number indicates radius of all circles
%   imEdge: is a binary image of edge detect
%   fraction: we need potential circle has at least fraction of pixels were detected as edges
%   threshold: only those candidates with higher than threshold votes can be chosen as circle.
%   voteMatrix: in this case is 2D matrix. The vote accmulator matrix.   
%
%   [centers, radius] = localMax(voteMatrix, threshold, fraction, imEdge)
%   imEdge is a binary image of edge detect
%   fraction: we need potential circle has at least fraction of pixels were detected as edges
%   threshold, only those candidates with higher than threshold votes can be chosen as circle.
%   voteMatrix in this case is 3D vote accmulator matrix. The 3rd dimension for different voting redius. 

    centers = zeros(0, 2);
    localMaxMask = imregionalmax(voteMatrix);
    [row, col] = size(imEdge);
    if nargin == 5 %We use fix radius, in this case, voteMatrix is 2D    
        [potentialRow, potentialCol] = find(localMaxMask == 1);
        ANGLE_ITERATION = 4 + 4 * fixRadius;
        THETA_MIN = 2 * pi / ANGLE_ITERATION;
        for i = 1:length(potentialRow)
            if voteMatrix(potentialRow(i), potentialCol(i)) > threshold
                y = indexToPosition(potentialRow(i));
                x = indexToPosition(potentialCol(i));
                voteCount = 0;
                theta = THETA_MIN * (0: ANGLE_ITERATION - 1);
                a = round(y + sin(theta) * fixRadius);
                b = round(x + cos(theta) * fixRadius);
                
                for k = 1:length(a);    
                    if a(k) >= 1 && a(k) <= row && b(k) >= 1 && b(k) <= col && imEdge(a(k), b(k)) == 1
                        voteCount = voteCount + 1;
                    end
                end
                if voteCount / ANGLE_ITERATION > fraction
                    centers = [centers; y, x];
                end
            end
        end
        radius = ones(size(centers, 1), 1) * fixRadius;
    elseif nargin == 4 %Without fix radius. In this case, voteMatrix is 3D
        radius = zeros(0, 1);
        for j = 1:size(localMaxMask, 3)
            %ANGLE_ITERATION = min(4 + 4 * j, 40);
            ANGLE_ITERATION = 4 + 4 * j;
            THETA_MIN = 2 * pi / ANGLE_ITERATION;
            [potentialRow, potentialCol] = find(localMaxMask(:,:,j) == 1);
            for i = 1:length(potentialRow)
                if voteMatrix(potentialRow(i), potentialCol(i), j) > threshold
                    y = indexToPosition(potentialRow(i));
                    x = indexToPosition(potentialCol(i));
                    voteCount = 0;
                    theta = THETA_MIN * (0: ANGLE_ITERATION - 1);
                    a = round(y + sin(theta) * j);
                    b = round(x + cos(theta) * j);
                
                    for k = 1:length(a);    
                        if a(k) >= 1 && a(k) <= row && b(k) >= 1 && b(k) <= col && imEdge(a(k), b(k)) == 1
                            voteCount = voteCount + 1;
                        end
                    end
                    if voteCount / ANGLE_ITERATION > fraction
                        centers = [centers; y, x];
                        radius = [radius; j];
                    end
                end
            end
        end
    end
end

