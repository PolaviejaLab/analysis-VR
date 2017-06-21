function config()
% CONFIG  Creates a global variable config_ that contains
%  constants that have to be shared between scripts.

global config_;

% Store base directory of git repository
[scriptDirectory, ~, ~] = fileparts(mfilename('fullpath'));
config_.baseDirectory = fullfile(scriptDirectory, '..');

% Set cache directory (to store intermediate results)
config_.cacheDirectory = fullfile(config_.baseDirectory, 'cache');

% Participant configuration
config_.dataDirectory = fullfile(config_.baseDirectory, 'data');

if(exist('config_local', 'file'))
    config_local();
end

dataDirectory = config_.dataDirectory;

config_.participants = cell(0, 3);

aux_dir = dir(config_.dataDirectory);

for i = 1:numel(aux_dir)
    if ~aux_dir(i).isdir || aux_dir(i).name(1) == '.'
        continue;
    end
    subjectDirectory = fullfile(dataDirectory, aux_dir(i).name, 'Unity_Files');
    aux_subjectfiles = dir(subjectDirectory);
    time_date = '';
    
    for j = 1:numel(aux_subjectfiles)
        if numel(aux_subjectfiles(j).name) >= 16
            
            if strcmp(aux_subjectfiles(j).name(1:2), '20')
                time_date = aux_subjectfiles(j).name(1:16);
                break;
            end
        end
    end
    config_.participants(end + 1, :) = {aux_dir(i).name, time_date, subjectDirectory};
end


config_.conditionsShort = { ...
    'S1', 'S2', 'Trn', 'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'};

config_.conditionsLong = { ...
    'Static 1', 'Static 2', 'Training', ...
    'Dinamic 1', 'Dinamic 2', 'Dinamic 3', 'Dinamic 4', 'Dinamic 5', ...
    'Dynamic 6', 'Dynamic 7' ...
    };

config_.questions = { ...
    '"looking at my own hand, not a VH"', ...
    '"virtual hand was my hand"', ...
    '"virtual hand belonged to me "', ...
    '"virtual hand was part of my body"', ...
    '"physically resembling my hand"', ...
    '"my real hand was turning virtual"',  ...
    '"I could control the virtual hand"', ...
    '"virtual movements were caused by me"', ...
    '"my movement turned the lights off"', ...
    '"focussing only on the virtual hand"', ...
    '"the virtual hand was controlling mine"', ...
    '"virtual hand caused the movement of mine"', ...
    '"my hand was located where the VH was"',...
    '"my hand moved where the VH moved"'};