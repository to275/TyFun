function savegif(filename,ims,fps,loops)
% function savegif(filename,ims,fps)
% THis script takes input images stored in ims and converts them into a gif
% format with a frame rate defined by fps. The gif is saved using the input
% filename.
%
% INPUTS - filename: A string name for the saved gif (no .gif in name).
%   ims: a collection of image objects representing each image in the gif
%   fps: an integer number of frames per second.
%   loops: an intger number of times you want the gif to repeat, default infinite (regular gif)
% 
% The time duration of the gif in seconds will be length(ims)/fps.
%
% To generate ims, use the following psedocode when making your matlab
% figures in a for loop:
%
% filename = 'yourfilename'; % name of your savefile  (don't include any . extension)
% fps = fps;                 % frames per second 
% for i = 1:T                % start plotting loop (T total figures)
%   clf                        % clear the content of the figure before plotting the new frame
% 
%   plot(...)                  % plot the current frame (this can be as long as you need it to
%                              % be and includes any figure formatting that happens before saving)
%
%   fg = gcf                   % figure handle for the current figure
%   drawnow                    % force the figure to update
%   frame = getframe(fg)       % convert the figure into a frame object
%   ims{i} = frame2im(frame);  % save as an image
% end                        % end of plotting loop
% savegif(filename,ims,fps)  % save the gif (note, since loops was not defined, this creates an
%                            % infinitely looping gif)

if ~exist('loops','var')
    loops = Inf; % set the default loop count to infinity
end

disp(['saving ', filename])

for i = 1:length(ims)
    [A,map] = rgb2ind(ims{i},256); % convert to saveable format
    if i==1
        imwrite(A,map,filename,"gif",LoopCount=loops,DelayTime = 1/fps)
    else
        imwrite(A,map,filename,"gif",WriteMode='append',DelayTime = 1/fps)
    end
end
disp([filename, ' saved'])

end