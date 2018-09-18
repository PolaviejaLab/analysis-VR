function [protocol_file] = get_protocol_file(input_file)
%GET_PROTOCOL_FILE Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(input_file);
full_table = textscan(fid, '%s %s %s', 'Delimiter', '\t');

ind_protocolNum = strmatch('Protocol file', full_table{1,3})';
protocol_str = char(full_table{3}{4});
protocol_split = strsplit(protocol_str, ' ');
protocol_file = char(protocol_split{3});

fprintf('Protocol file %s\n', protocol_file);
end

