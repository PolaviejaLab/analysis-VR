function [order] = get_order_fromprotocol (unityFolder)

% get number of protocol from the log file



% get the number of trial 
fid = '\GitHub\Victoria-Discontinuity\Protocol\Exp2_Experiment\prueba_77.txt'

[~, ~, order] = tblread(fid);
order = str2double(order)';

