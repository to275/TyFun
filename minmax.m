function [rng] = minmax(x)
% This function calculates the minimum and maximum values of matrix x and
% returns this range as a 1 x 2 vector. Ideally used for finding limits for
% plotting purposes
x = x(:); % columnate
xmin = min(x); % minimum
xmax = max(x); % maximum
rng = [xmin, xmax]; % range
end

