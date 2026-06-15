% [fc,OTOspec]=FDOTOspec(f,Gxx,flims)
% Inputs:   f - frequency array (Hz)
%           Gxx - autospectral density in Engineering Units^2/Hz
%           flims - [flow, fhigh], desired range of low and high frequency one-third octave bands between 1 and 100000 Hz
%           method - 'rect','ANSI',Options for OTO filter type -
%           rectangular filter or ANSI filter mask.  The default is the
%           ANSI mask.
% Outputs:  fc, band center frequencies
%           OTOspec, one-third octave band spectra (Eng Units^2)
% Author: Kent Gee

function [fc,OTOspec]=FDOTOspec(f,Gxx,flims,method)
fc = [1, 1.25, 1.6, 2.0, 2.5, 3.15, 4, 5, 6.3, 8];
fc= [fc,fc*10,fc*100,fc*1000,fc*10000,1e5];

if nargin<4
    method='ANSI';
end

% Truncate fc array
ind = find(fc>=flims(1) & fc<=flims(2));
fc=fc(ind);
OTOspec=zeros(size(fc));
df=f(2)-f(1);
% Select method
switch method
    case 'rect'
        
        flow=[0.88, 1.13, 1.414, 1.76, 2.25, 2.825, 3.53, 4.4, 5.65, 7.07];
        flow=[flow,flow*10,flow*100,flow*1000,flow*10000,0.88e5];
        
        fhi=[1.13, 1.414, 1.76, 2.25, 2.825, 3.53, 4.4, 5.65, 7.07, 8.8];
        fhi=[fhi,fhi*10,fhi*100,fhi*1000,fhi*10000,1.13e5];
        
        
        for n = 1:length(fc)
            index = flow(ind(n))<=f & f<fhi(ind(n));
            OTOspec(n) = sum(Gxx(index))*df;
        end
        
    case 'ANSI'
        
        for n=1:length(fc)
            %From oct3spec function by Christophe Couvreur, Faculte Polytechnique de Mons (Belgium)
            f1 = fc(n)/(2^(1/6));
            f2 = fc(n)*(2^(1/6));
            Qr = fc(n)/(f2-f1);
            Qd = (pi/6)/(sin(pi/6))*Qr;
            Hsq = abs(1./(1+Qd^(6)*((f/fc(n))-(fc(n)./f)).^(6)));
            OTOspec(n)=sum(Gxx.*Hsq)*df;  
            
        end
        
        
    otherwise
        error('Invalid method');
end

