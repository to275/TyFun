function [ax1,ax2]=plotH(f,H,type,a)
% this function will plot the dB transfer function into the current figure.
% It is referenced to its own maximum value.
% Input: f - frequency array
% H - raw transfer function data
% type - 2 for regular array, 3 for pcolor with angle
% a - angle array to use
%
% Output: ax1 - axis handle for the top plot
% ax2 - axis handle for the bottom plot

Hmag = abs(H); % pull out the magnitude of the transfer function
HdB = 10*log10(Hmag);%./max(Hmag)); % convert to dB

if ~exist('a','var') || isequal(a,[])% check to see if a was passed in
    type = 2; % default to a regular array
end


switch type
    case 2
        subplot(2,1,1)
        semilogx(f,HdB)
        grid on
        xlabel('Frequency, Hz')
        ylabel('dB')
        ax1 = gca;

        subplot(2,1,2)
        semilogx(f,angle(H)*180/pi)
        grid on
        xlabel('Frequency, Hz')
        ylabel('Angle, °')
        ax2 = gca;

    case 3
    % plot the magnitude
    subplot(2,1,1)
    pc=pcolor(f,a,HdB'); % plot the dB magnitude of the transfer function
    pc.EdgeColor='none';
    ax1 = gca; ax1.XScale = 'log';
    xlabel('Frequency, Hz')
    ylabel('Angle, °')
    title('Transfer function magnitude')
    colorbar
    
    subplot(2,1,2)
    pc=pcolor(f,a,angle(H')*180/pi); % plot the phase of the transfer function
    pc.EdgeColor='none';
    ax2 = gca; ax2.XScale = 'log';
    xlabel('Frequency, Hz')
    ylabel('Angle, °')
    title('Transfer function phase')
    colorbar
    otherwise
        disp('Invalid plotting type, choose 2 or 3')
end