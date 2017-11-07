function [positionBin] = getIndexBinFile (bitalinoTSFile, timestamps)

fileID = fopen(bitalinoTSFile);
aux_ = textscan(fileID, '%q');
allTS = aux_{1,1};

positionBin = zeros(1, numel(timestamps(:,1)));

for i = 1:numel(timestamps(:,1))
    try
        i_ts = strfind(allTS, timestamps(i, 15:21));
        ind_find = find(~cellfun(@isempty, i_ts));
        %         positionBin(i)  = ind_find;
        if (numel(ind_find) > 1)
            [ind_find] = removeCloseNumbers(ind_find);
        end
        positionBin(i) = ind_find;
        
    catch
        aux_num = str2num(timestamps(i, 20:21));
        
        if (aux_num == .9)
            new_min = str2num(timestamps(i, 19)) + 1;
            aux_num = strcat(num2str(new_min), '.0');
            
            i_ts = strfind(allTS, strcat(timestamps(i, 15:18), aux_num));
            
        else
            aux_num = num2str(aux_num + 0.1);
            i_ts = strfind(allTS, strcat(timestamps(i, 15:19), aux_num(2:3)));
        end
        
        ind_find = find(~cellfun(@isempty, i_ts));
        %         positionBin(i)  = ind_find;
        
        if (numel(ind_find) > 1)
            [ind_find] = removeCloseNumbers(ind_find);
        end
        positionBin(i) = ind_find;
        
    end
    
    
end

end