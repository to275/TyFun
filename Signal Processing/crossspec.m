function [Gxy,f] = crossspec(x,y,fs,ns,N,unitflag)

% This program calulates the crossspectral density or spectrum of signals x and y.
% Hanning windowing is used, with 50% overlap. Per Bendat and Piersol, Section 11.6.3, Gxy 
% is scaled by the mean-square value of the window for overall amplitude
% scaling purposes.
%
%   call [Gxy,f] = crossspec(x,y,fs,ns,N,unitflag);
% 
%   Outputs: 
%   Gxy = Single-sided cross spectrum or cross spectral density, depending on unitflag
%   f = frequency array for plotting
%   OASPL = Overall sound pressure level
%
%   Inputs:
%   x,y = time series data
%   fs = sampling frequency
%   ns = number of samples per block.  Default is 2^15 if not specified.
%   N = total number of samples.  If N is not an integer multiple of ns, 
%       the samples less than ns in the last block are discarded.  Default   
%       is nearest lower power of 2 if not specified.
%   unitflag = 1 for autospectrum, 0 for autospectral density.  Default is
%   autospectral density
%
%   Authors: Kent Gee and Alan Wall

% Columnate the inputs
x = x(:);
y = y(:);

%warning off

%DEFAULT WAVEFORM SIZE
if nargin<6 || unitflag>1
    unitflag=0;
end

if nargin<5
    N = 2^floor(log2(length(x))); 
end
x = x(1:N);

%DEFAULT BLOCK SIZE
if nargin<4
    ns = 2^15; 
end

%FREQUENCY ARRAY
f = fs*(0:ns/2-1)/ns;
df = f(3) - f(2);   %Width of frequency bins.

%Enforce zero-mean
x = x-mean(x);
y = y-mean(y);

%HANNING WINDOW
ww = hann(ns);
W = mean(ww.*conj(ww)); %Used to scale the psd

%SPLITS DATA INTO BLOCKS
% Divides total data set into blocks of length ns with 50% overlap, and
% windowed.  Rather than constructing the matrix with a for loop, it
% creates a matrix of pointers used to index the waveform, x.

numBlocks = floor(2*N/ns-1);

blockmat = repmat(1:ns,numBlocks,1) + repmat(ns/2*(0:numBlocks-1)',1,ns);

blocksx = repmat(ww',numBlocks,1).*x(blockmat);  %window data blocks  
blocksy = repmat(ww',numBlocks,1).*y(blockmat);  %window data blocks 

%COMPLEX SPECTRUM

X = fft(blocksx,ns,2);  
Y = fft(blocksy,ns,2);

Xss = X(:,1:ns/2);  %Takes first ns/2 points to make it single-sided.                
Yss = Y(:,1:ns/2);

%CROSS SPECTRAL DENSITY

Scale = 2/ns/fs/W;

Gxy = Scale*mean(conj(Xss).*Yss,1); %Units are Pa^2/Hz
    
%SPECTRUM SCALING?
Gxy = Gxy*df^unitflag;

end
