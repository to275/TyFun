s = settings;
sc = s.matlab.colors;
fn = fieldnames(sc);
fn = [fn{:} 'BackgroundColor']';
for i = 1:numel(fn)
    fni = fn{i};
    try
        sc.(fni).TemporaryValue = randi(255,[1,3]);
    catch
        fn2 = fieldnames(sc.(fni));
        for j = 1:numel(fn2)
            fnj = fn2{j};
            try
                sc.(fni).(fnj).TemporaryValue = randi(255,[1,3]);
            catch
                sc.(fni).(fnj).TemporaryValue = round(rand);
            end
        end
    end
end
