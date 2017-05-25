function [trajArray] = extractTrajectories (fileID)

table = textscan(fileID, '%q %q %q %q %q');

trajArray = [...
    str2num(char(table{1,3})), ...
    str2num(char(table{1,4})), ...
    str2num(char(table{1,5}))
    ];
end 