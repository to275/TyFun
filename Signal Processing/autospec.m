function [Gxx,f,OASPL] = autospec(x,fs,ns,N,unitflag,wind)

% This program calulates the autospectral density or autospectrum and the OASPL of a signal.
% Hanning windowing is used, with 50% overlap. Per Bendat and Piersol, Gxx 
% is scaled by the mean-square value of the window to recover the correct OASPL.
%
%   call [Gxx,f,OASPL] = autospec(x,fs,ns,N);
% 
%   Outputs: 
%   Gxx = Single-sided autospectrum or autospectral density, depending on unitflag
%   f = frequency array for plotting
%   OASPL = Overall sound pressure level
%
%   Inputs:
%   x = time series data.
%   fs = sampling frequency
%   ns = number of samples per block.  Default is 2^15 if not specified.
%   N = total number of samples.  If N is not an integer multiple of ns, 
%       the samples less than ns in the last block are discarded.  Default   
%       is nearest lower power of 2 if not specified.
%   unitflag = 1 for autospectrum, 0 for autospectral density.  Default is
%   autospectral density
%
%   Authors: Kent Gee, Alan Wall, and Brent Reichman
%   Last Modified: 10/8/2016.  Modified code to use pointers to index array
%   rather than for loop


%warning off

% Force the data to be column vector
x = x(:);

%DEFAULT WAVEFORM SIZE
if nargin<6
    wind = 1; % default use the hann window
end

if nargin<5 || unitflag>1
    unitflag=0;
end

if nargin<4
    N = 2^floor(log2(length(x))); 
end
x = x(1:N);

%DEFAULT BLOCK SIZE
if nargin<3
    ns = 2^15; 
end

%FREQUENCY ARRAY
f = fs*(0:ns/2-1)/ns;
df = f(2);   %Width of frequency bins.

%Enforce zero-mean
x = x-mean(x);

%HANNING WINDOW
if wind
    ww= hann(ns); % hann
else
    ww = ones([ns,1]); % boxcar
end

W = mean(ww.*conj(ww)); %Used to scale the ASD for energy conservation

%SPLITS DATA INTO BLOCKS
% Divides total data set into blocks of length ns with 50% overlap, and
% windowed.  Rather than constructing the matrix with a for loop, it
% creates a matrix of pointers used to index the waveform, x.

numBlocks = floor(2*N/ns-1);

blockmat = repmat(1:ns,numBlocks,1) + repmat(ns/2*(0:numBlocks-1)',1,ns);

blocks = repmat(ww',numBlocks,1).*x(blockmat);  %window data blocks                                         

%COMPLEX PRESSURE SPECTRUM

X = fft(blocks,ns,2);    %Will scale this in the autospectral density

Xss = X(:,1:ns/2);  %Takes first ns/2 points to make it single-sided.

%AUTOSPECTRAL DENSITY
Scale = 2/ns/fs/W;
    
Gxx = Scale*mean(conj(Xss).*Xss,1); %Units are Pa^2/Hz

%AUTOSPECTRUM SCALING?
Gxx = Gxx*df^unitflag;

%OVERALL SOUND PRESSURE LEVEL
if nargout > 2
    OASPL = 20*log10(sqrt(sum(Gxx*df^(~unitflag)))/2e-5);
end

end