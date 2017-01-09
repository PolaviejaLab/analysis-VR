function txyz = readHandPositions(filename)
% READHANDPOSITIONS - Reads a CSV file with hand positions
%  into a matrix. The first column is the timestamp (datenum)
%  the second, third, and fourth numbers are the X, Y, and Z
%  coordinates of the palm respectively.
%  Missing data is represented using NaNs.
%

    fid = fopen(filename, 'r');
    data = textscan(fid, '%[^,], %[^,], %f, %f, %f');

    timestamps = cellfun(@datenum8601, data{1});   
    valid = lower(strtrim(data{2}));
    valid = strcmp(valid, 'true' ) | strcmp(valid, '1'); % now it is a one, instead of a true
    
    xyz = [data{3} data{4} data{5}];
    txyz = [timestamps xyz];
    txyz(~valid, 2:4) = NaN;
    
    fclose(fid);