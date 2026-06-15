function plotgxx(x,fs,ns,unitflag)
%%%%%%
% This function will plot the autospectral density of input signal x
% INPUT: x - input signal
%   fs - sampling frequency
%   ns - block size
%   
%
% OUTPUT: none
%%%%%%%

if nargin<4
    unitflag = 0; % default to autospectral density
end

%% Plot the autospectral density
[Gxx, fxx] = autospec(x,fs,ns,length(x),unitflag); % calculate the autospectral density

GxxdB = 10*log10(Gxx/(2e-5)^2); % decibate

semilogx(fxx,GxxdB)
grid on
xlabel('Frequncy, Hz')
ylabel('Autospectral density, dB re 20\muPa')

