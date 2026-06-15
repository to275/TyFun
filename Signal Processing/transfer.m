function [Hxy, f] = CalcTransferFunction(x,y,fs,ns)

% this function calculate the transfer function from signal x to y
% Input: x - input signal
% y - output signal
% fs - sampling frequency
% ns - block size
% Output: Hxy, transfer function from x to y
% f - frequency renge corresponding to Hxy

N = length(x); % length of the signal

% calculate the auto/cross spectra necessary
[Gxx,f] = crossspec(x,x,fs,ns,N); % calculate the autospectrum
Gxy = crossspec(x,y,fs,ns,N); %calculate the cross spectrum

Hxy = Gxy./Gxx; % calculate the transfer function