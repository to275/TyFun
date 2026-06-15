function [diffcmap] = diffmap(n)
% [diffcmap] = diffmap(n)
% this function creates a central colormap moving from blue to white to red
% with n steps. If n is odd, there will be (n-1)/2 steps to and from white
% and n/2 steps if n is even.

% check to see if n is even or odd
if mod(n,2)==1
    n2 = (n-1)/2; % odd
else
    n2 = n/2; % even
end

% create the initial
Rstart = 0;
Gstart = 0;
Bstart = 1;

Rmid = 1;
Gmid = 1;
Bmid = 1;

Rend = 1;
Gend = 0;
Bend = 0;

dR = (Rmid-Rstart)/n2;
R = [Rstart:dR:(Rmid-dR), Rmid, linspace(Rmid,Rend,n2)]';
dG1 = (Gmid-Gstart)/n2; dG2 = (Gend-Gmid)/n2;
G = [Gstart:dG1:(Gmid-dG1), Gmid, (Gmid+dG2):dG2:Gend]';
dB = (Bend-Bmid)/n2;
B = [linspace(Bstart,Bmid,n2), Bmid, (Bmid+dB):dB:Bend]';

diffcmap = [R G B];