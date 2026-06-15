function finish

clc
switch randi(4)
    case 1
        a = 'Have a great day!';
    case 2
        a = 'Well, so long.';
    case 3
        a = 'Ra Ra';
    case 4
        a = 'Good day to you.';
end

fprintf('\n\n\n\t\t\t%s\n\n\n',a)
pause(1)

% quit cancel

end

