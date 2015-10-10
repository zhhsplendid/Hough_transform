function [ ret ] = indexToPosition( x )
% In order to have different bin size of vote space, this function input a 
% num x indicates the index for which vote bin x.  
% @return 
%    the ret'th row or ret'th column position in image, indicates the
%    center of circle

    BIN_SIZE = 2;
    
    ret = (x - 1)* BIN_SIZE + floor(BIN_SIZE / 2);
end

