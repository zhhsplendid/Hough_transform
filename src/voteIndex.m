function [ ret ] = voteIndex( x )
% In order to have different bin size of vote space, this function input a 
% num x indicates the x'th row or x'th column position in image, return the
% index for which vote bin x should belong to.

    BIN_SIZE = 2;
    
    ret = floor(x / BIN_SIZE) + 1;
end

