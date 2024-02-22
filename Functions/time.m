function [] = time(n,h)
% Divides the time until 17:00 (or h:00) into n blocks and outputs the time in
% minutes.
format shortg
c = datetime("now");
t0 = [hour(c) minute(c)]; % current time
try
    tend = [h 0];
catch
    tend = [17 0];% 5pm
end
dt = tend-t0; % time until then
t = 60*dt(1)+dt(2);
fprintf("Item %i for %0.0f min\n",randi(n,1),t/n)

end

