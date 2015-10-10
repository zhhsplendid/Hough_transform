function [centers] = detectCircles(im, radius, usegradient)
    [centers, radius] = detectCirclesAnyRadius( im, fixRadius, usegradient);
end

