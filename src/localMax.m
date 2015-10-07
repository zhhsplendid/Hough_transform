function [centers, radius] = localMax(voteMatrix, threshold, fixRadius)
    
    if nargin == 3 %We use fix radius, in this case, voteMatrix is 2D
        [row, col] = size(voteMatrix);
        centers = zeros(0, 2);
        
        %localMaxMask = imregionalmax(voteMatrix);
        %[Potential_row, Potential_col] = find(localMaxMask == 1);
        for r = 1:row
            for c = 1:col
                peak = true;
                if r + 1 <= row && c + 1 <= col
                    if voteMatrix(r, c) < voteMatrix(r + 1, c + 1);
                        peak = false;
                    end
                end
                    
                if r + 1 <= row && c - 1 >= 1
                    if voteMatrix(r, c) < voteMatrix(r + 1, c - 1);
                        peak = false;
                    end
                end
                
                if r - 1 >= 1 && c + 1 <= col
                    if voteMatrix(r, c) < voteMatrix(r - 1, c + 1);
                        peak = false;
                    end
                end
                
                if r - 1 >= 1 && c - 1 >= 1
                    if voteMatrix(r, c) < voteMatrix(r - 1, c - 1);
                        peak = false;
                    end
                end
                
                if peak == true && voteMatrix(r, c) > threshold
                    centers = [centers; r, c];
                end
            end
        end
        radius = ones(size(centers, 1), 1) * fixRadius;
    else %In this case, voteMatrix is 3D
    
    end


end

