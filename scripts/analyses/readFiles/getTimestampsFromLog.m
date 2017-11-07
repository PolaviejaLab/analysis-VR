function [ts_array] = getTimestampsFromLog (logFile, evName)

[timestampsArray, ~, eventArray] = readLogFile (logFile);

i_ts = strmatch(evName, eventArray, 'exact');

ts_array = timestampsArray(i_ts, :); 


end