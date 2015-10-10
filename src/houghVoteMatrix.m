function [ fixRadiusVotes ] = houghVoteMatrix(imEdge, radius, gradientDire)
% This function compute hough vote matrix with fix radius
% @return
%   fixRadiusVotes: the vote accmulator matrix
% @call
%   [ fixRadiusVotes ] = houghVoteMatrix(imEdge, radius, gradientDire)
%   gradientDire: a r * c matrix indicates directions of every pixel in image
%   radius: the fix radius
%   imEdge: is a binary image of edge detect

    %ANGLE_ITERATION = min(4 + 4 * radius, 40);
    ANGLE_ITERATION = 4 + 4 * radius;
    THETA_MIN = 2 * pi / ANGLE_ITERATION;
    
    [row, col] = size(imEdge);
    fixRadiusVotes = zeros(voteIndex(row), voteIndex(col));
    
    if nargin == 2 % we don't use gradient directons
        theta = THETA_MIN * (0: ANGLE_ITERATION - 1);
        [searchRows, searchCols] = find(imEdge == 1);
        for s = 1:length(searchRows)
            r = searchRows(s);
            c = searchCols(s);
            
            a = round(c - radius * cos(theta)); 
            b = round(r + radius * sin(theta));
            
            inImageIndex = find((a >= 1) & (a <= col) & (b >= 1) & (b <= row));
            for i = 1:length(inImageIndex)
                y = b(inImageIndex(i));
                x = a(inImageIndex(i));
                fixRadiusVotes(voteIndex(y), voteIndex(x)) = fixRadiusVotes(voteIndex(y), voteIndex(x)) + 1;
            end
        end
    else % we use gradient directions
        [searchRows, searchCols] = find(imEdge == 1);
        for s = 1:length(searchRows)
            r = searchRows(s);
            c = searchCols(s);
            for i = 1:2
                theta = (-1)^i * gradientDire(r, c);
                a = round(c - radius * cos(theta)); 
                b = round(r + radius * sin(theta));
                        
                if a >= 1 && a <= col && b >= 1 && b <= row
                    fixRadiusVotes(voteIndex(b), voteIndex(a)) = fixRadiusVotes(voteIndex(b), voteIndex(a)) + 1; 
                end 
            end
        end
    end
    
    
end

