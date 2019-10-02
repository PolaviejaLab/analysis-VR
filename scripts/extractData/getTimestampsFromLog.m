function [timestamps] = getTimestampsFromLog (params, ...
    experimentType, participant)

try
    % Log File
    file_log = dir(fullfile(params.dataDirectory, experimentType, char(participant), '*.log'));
    fileName_log = fullfile(file_log(1).name);
    fileID = fopen(fullfile(params.dataDirectory, experimentType, char(participant), fileName_log));
    table_ = textscan(fileID, '%q %q %q', 'Delimiter', '\t');
    
    timestamps_ = char(table_{1, 1});
    fclose(fileID);
catch
    warning('No Protocol File found for Participant %s', participant);
    timestamps_ = NaN;
    return, 
end



params.tags.Controller.trial,
params.tags.Event.Start,

params.tags.Event.trialEnd,

end 