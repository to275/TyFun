function TycePlotDefaults(varargin)
% function TycePlotDefaults(varargin)
% this function sets my prefered default plot styles
% optional name pair arguments. Default sets none of these.
% 'Journal':
%   'AIAA' -> Sets font to Times New Roman 10 pt
%   'JASA' -> Sets font to Garamond 11 pt
% 'Size':
%   'Standard' -> Sets the figure size to 3.5" x 3.5"
%   'Full' -> Sets figure size to 7" x 3.5"

%% parse inputs
expectedJournals = {'None','AIAA','JASA'};
expectedSize = {'None','Standard','Full'};

defaultJournal = 'none';
defaultSize = 'none';

p = inputParser;
validJournal = @(x) ischar(x) && any( strcmpi(x,expectedJournals));
validSize = @(x) ischar(x) && any( strcmpi(x,expectedSize));
addParameter(p,'Journal',defaultJournal,validJournal);
addParameter(p,'Size',defaultSize,validSize);

parse(p,varargin{:})

% reset everything
reset(groot)

% plotting
set(0,'DefaultLineLineWidth',1.5); % line thickness

% axes
set(0,'DefaultAxesXGrid','on'); % x grid
set(0,'DefaultAxesYGrid','on'); % y grid
set(0,'DefaultAxesLineWidth',1.5); % axis thickness
set(0,'DefaultAxesFontName','Times New Roman'); % font name
set(0,'DefaultAxesFontSize',12); % font size

% figure



% set journal specifics
switch lower(p.Results.Journal)
    case 'aiaa'
        set(0,'DefaultAxesFontName','Times New Roman'); % font name
        set(0,'DefaultAxesFontSize',10); % font size
    case 'jasa'
        set(0,'DefaultAxesFontName','Garamond'); % font name
        set(0,'DefaultAxesFontSize',11); % font size
end

% set size specifics
switch lower(p.Results.Size)
    case 'standard'
        set(0,'DefaultFigureUnits','inches'); % set units to inches
        set(0,'DefaultFigurePosition',[11 3 3.5 3.5])
    case 'full'
        set(0,'DefaultFigureUnits','inches'); % set units to inches
        set(0,'DefaultFigurePosition',[11 3 7 3.5])
end