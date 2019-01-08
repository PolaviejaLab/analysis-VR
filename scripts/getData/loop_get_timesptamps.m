function [timestampArray] = ...
    loop_get_timesptamps (input_file, tags)

fid = fopen(input_file);
full_table = textscan(fid, '%s %s %s', 'Delimiter', '\t');

indController = strmatch(tags.Controller, full_table{1,2});

% Get Timestamps of Start of the waving event
indSameStart = findsame(indController, strmatch(tags.Event.waveStart, full_table{1, 3}));
indSameEnd = findsame(indController,  strmatch(tags.Event.waveEnd, full_table{1, 3}));

ts_col = cell2mat(full_table{1});

end