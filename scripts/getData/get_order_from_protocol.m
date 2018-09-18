function [order] = get_order_from_protocol (input_protocol_file)
%GET_ORDER_FROM_PROTOCOL Summary of this function goes here
%   Detailed explanation goes here
gitDirectory = 'E:\GitHub\Victoria-Discontinuity\';

try
    protocolID = fopen(strcat(gitDirectory, input_protocol_file));
    table_ = textscan(protocolID, '%s %s %s %s %s %s %s %s %s %s');
    protocolOrder = str2num(char(table_{1,1}(2:7)));
    
    order = protocolOrder;
catch
    order = nan;
end


end

