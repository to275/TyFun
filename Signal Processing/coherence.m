function [g2,f] = coherence(x,y,fs,ns)
% [g2,f] = coherence(x,y,fs,ns)
%
% This function calculates the coherence between two signals. It is assumed
% that the two signals are the same size.
% Input: x - signal 1
% y - reference signal
% fs - sampling frequency
% ns - block size
%
% Output: g2 - coherence

%f - frequency array corresponding to the coherence
N = length(x);

% calculate the auto/cross spectra necessary
[Gxx,f] = autospec(x,fs,ns,N); % calculate the autospectrum
Gyy = autospec(y,fs,ns,N);
Gxy = crossspec(x,y,fs,ns,N); %calculate the cross spectrum

g2 = abs(Gxy).^2./(Gxx.*Gyy); % calculate the coherence.