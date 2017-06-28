function [tsArray, machineArray, eventArray] = readLogFile (fileName)

fileID = fopen(fileName);
table = textscan(fileID, '%s %s %s', 'Delimiter', '\t');

tsArray = char(table{1,1});
machineArray = char(table{1,2});
eventArray = char(table{1,3});


end