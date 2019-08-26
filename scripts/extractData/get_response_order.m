% function [order_static, order_dynamic] = get_response_order (subjectFolder)

% Not used due to lack of information

addpath(subjectFolder);

unityFiles = dir(fullfile(subjectFolder, '\Unity_Files\'));

i_aux = 1;

for i_files = 1:length(unityFiles)
    a = regexp(unityFiles(i_files).name, 'Participant.\.csv');
    
    if (~isempty(a))
        fileID = fopen(fullfile(subjectFolder, '\Unity_Files\', ...
            unityFiles(i_files).name));
        aux = textscan(fileID, '%u %s %s %s %s %u %u %u %u %u %f', ...
            'Delimiter', ',');
        fclose(fileID);
        
        res_cell{aux{1}, 1} = aux;
        i_aux = i_aux + 1;
    else 
    end
end

res_table = cell2table(res_cell);

% static
if (strcmp(res_cell{1, 1}{1, 2}, 'Continuous Limb'))
    order_static = [1 2];
elseif(strcmp(res_cell{1, 1}{1, 2}, 'Discontinuous Limb'))
    order_static = [2 1];
else 
    NaN
end

% dynamic
for i_files = 1:length(unityFiles)
    b = strcmp(unityFiles(i_files).name, '.log');
    if (b == 1)
        i_files
    end
end