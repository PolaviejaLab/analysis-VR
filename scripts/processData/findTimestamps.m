function [ind_timestamps] = findTimestamps (timestamps, alltimestampsgsr)

alltimestampsgsr = char(alltimestampsgsr);

for i = 1:size(timestamps, 2)
    
    ind_timestamps{1, i} = strmatch(timestamps{1, i}(15:21), alltimestampsgsr(:, 15:21));
    
end 
end