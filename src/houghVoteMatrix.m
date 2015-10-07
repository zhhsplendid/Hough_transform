function [ fixRadiusVotes ] = houghVoteMatrix(imEdge, radius, gradientDire)
    
    ANGLE_ITERATION = 36;
    THETA_MIN = 2 * pi / ANGLE_ITERATION;
    
    [row, col] = size(imEdge);
    fixRadiusVotes = zeros(row, col);
    
    if nargin == 2 % we don't use gradient directons
        for r = 1:row
            for c = 1:col
                if imEdge(r, c) == 1
                    for i = 0: ANGLE_ITERATION - 1
                        theta = THETA_MIN * i;
                        a = round(c - radius * cos(theta)); 
                        b = round(r + radius * sin(theta));
                        
                        if a >= 1 && a <= col && b >= 1 && b <= row
                            fixRadiusVotes(b, a) = fixRadiusVotes(b, a) + 1; 
                        end 
                    end
                end
            end
        end
    else % we use gradient directions
        for r = 1:row
            for c = 1:col
                if imEdge(r, c) == 1
                    for i = 1:2
                        theta = (-1)^i * gradientDire(r, c);
                        a = round(c - radius * cos(theta)); 
                        b = round(r + radius * sin(theta));
                        
                        if a >= 1 && a <= col && b >= 1 && b <= row
                            fixRadiusVotes(b, a) = fixRadiusVotes(b, a) + 1; 
                        end 
                    end
                end
            end
        end
        
    end
end

