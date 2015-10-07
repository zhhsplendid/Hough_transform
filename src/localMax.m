function [centers, radius] = localMax(voteMatrix, threshold, fixRadius)
    centers = zeros(0, 2);
    localMaxMask = imregionalmax(voteMatrix);
    
    if nargin == 3 %We use fix radius, in this case, voteMatrix is 2D    
        [potentialRow, potentialCol] = find(localMaxMask == 1);
        for i = 1:length(potentialRow)
            if voteMatrix(potentialRow(i), potentialCol(i)) > threshold
                centers = [centers; potentialRow(i), potentialCol(i)];
            end
        end
        radius = ones(size(centers, 1), 1) * fixRadius;
    else %In this case, voteMatrix is 3D
        radius = zeros(0, 2);
        for j = 1:size(localMaxMask, 3)
            [potentialRow, potentialCol] = find(localMaxMask(:,:,j) == 1);
            for i = 1:length(potentialRow)
                if voteMatrix(potentialRow(i), potentialCol(i), j) > threshold
                    centers = [centers; potentialRow(i), potentialCol(i)];
                    radius = [radius; j];
                end
            end
        end
    end
end

