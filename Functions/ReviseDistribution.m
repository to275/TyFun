function [xr] = reviseDistribution(x,nsig,displayflag)
% This function will revise a distribution by removing Nans and outliers
% Input: x - distribution to be revised. Assumed to be a 1D vector
% nsig - number of standard deviations to include. Default is 5
% Output: xr - the revised distribution. If too much data is removed, this
% will be the original signal and a warning message will display

% define defauls
if nargin<2
    nsig = 5;
end
if nargin<3
    displayflag = 1;
end

% Save data about the initial distribution
xOriginal = x;
LOriginal = length(x);

% remove Nans from data
x(isnan(x)) = [];

% iteratively remove data until all the data is within sig sigma
revising = true;
xr = x;
while revising
    L = length(xr);
    % calculate statistical properties of the distribution
    stdev = std(xr);
    mu = mean(xr);
    % compute the interval
    low=mu-nsig*stdev;
    high=mu+nsig*stdev;
    % remove values outside of the interval
    xr(xr>high) = [];
    xr(xr<low) = [];
    % determine change
    dL = L - length(xr);
    if dL==0
        revising = false;
    end
end
L = length(xr);

dLtot = LOriginal - L;
Lratio = dLtot/LOriginal*100;

if dLtot < 0.5*LOriginal
    if displayflag
        fprintf("Removed %i values (%0.02f percent) in ReviseDistribution.m\n",dLtot,Lratio)
    end
else
    warning("%s percent of the data has been removed. Returning initial signal",string(Lratio))
    xr = xOriginal;
end