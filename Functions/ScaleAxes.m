function ScaleAxes(ax,qstr,a)
% this function will take in an axis, rescale it, and change the tick
% labels
% INPUT: ax - axis object to modify
%        qstr - a string representation of which axis to edit, eg. 'x',
%        'y', 'z', or capitalized, though that's not required
%        a - scaling factor, the new axis is a times the old axis
% OUTPUT

% force the axis string to be capitalized
qstr = upper(qstr);
qLims = ax.([qstr,'Lim']);
qTicks = ax.([qstr,'Tick']);

qpLims = a * qLims;  % new limits
N = length(qTicks); % number of ticks, start here

dqp = diff(qpLims)/(N-1); % ideal tick spacing
% round dqp to the nearest multiple of 5
dqp = 5*round(dqp/5);


qpLimsnew = dqp * floor(qpLims/dqp); % round to the multiple of dqp

qpTicks = qpLimsnew(1):dqp:qpLimsnew(2); % new tick labels

% find these locations on the original scale
ax.([qstr,'Tick']) = qpTicks/a;

% update the ticks on the figure
ax.([qstr,'TickLabels']) = qpTicks;

end

