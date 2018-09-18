function [trajArray, tsArray] = extractTrajectories (fileName)

fileID = fopen(fileName);
table = textscan(fileID, '%q %q %q %q %q');

tsArray = char(table{1,1});

trajArray = [...
    str2num(char(table{1,3})), ...
    str2num(char(table{1,4})), ...
    str2num(char(table{1,5}))
    ];


end 