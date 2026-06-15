function welcome
% this script will generate a random welcome message whenever I open a new
% matlab session
rng("shuffle") % prevents the same message from appearing every time.
clc; % clear the home screen

% run a random segment of the Final Countdown

% make the message

msg = [salut ' ' name];
msg(1) = upper(msg(1));
fprintf('\n\n\t\t\t %s \n\n\n',msg)

end

function a = salut

    switch randi(5)
        case 1
            a = 'welcome';
        case 2
            a = 'hello';
        case 3
            a = 'glad to see you today';
        case 4
            a = ['good ' timeofday];
        case 5
            a = 'ello';
    end
end

function a = name
    switch randi(6)
        case 1
            a = 'Master Tyce';
        case 2
            a = 'm''Lord';
        case 3
            a = 'Tyce';
        case 4
            a = 'Gov''ner';
        case 5
            a = 'Handsome';
        case 6
            a = 'Dr. Tyce';
    end
end

function a = timeofday
    dt = datetime('now');
    h = hour(dt); % pull out the hour
    if h < 6
        a = '... why are you up?';
    elseif h < 12
        a = 'morning';
    elseif h < 17
        a = 'afternoon';
    else
        a = 'evening';
    end
end