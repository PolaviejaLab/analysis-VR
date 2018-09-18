function [timestamps_array] = get_timestamps ...
    (input_file, str_col1, str_col2)
%GET_TIMESTAMPS Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(input_file);
full_table = textscan(fid, '%s %s %s', 'Delimiter', '\t');

ind_cond1 = strmatch(str_col1, full_table{1,2});
ind_cond2 = strmatch(str_col2, full_table{1,3});

ind_timestamps = findsame(ind_cond1, ind_cond2);

ts_col = cell2mat(full_table{1});
timestamps_array = ts_col(ind_timestamps, :); 
end

