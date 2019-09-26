function [preprocessedData] = extractGSR (params, subjectData, participants)

folderName = 'GSR_BonsaiFiles';

folderID = fullfile(params.dataDirectory, folderName);

for i = 1:numel(subjectData.usedGSR)
    
    filesGSR = dir(char(fullfile(params.dataDirectory, folderName, ...
        participants(subjectData.usedGSR(i)), '*.bin')));
    filesTimestamps = dir(char(fullfile(params.dataDirectory, folderName, ...
        participants(subjectData.usedGSR(i)), 'bitalinoRecordings*.csv')));
    
    if size(filesTimestamps, 1) ~= 2 || size(filesGSR, 1) ~= 2
        warning(strcat('Skipped Participant: ', ...
            char(participants(subjectData.usedGSR(i))), ', no timestamps file'));
        preprocessedData.GSR{i, 1} = [];
        preprocessedData.GSR{i, 2} = [];
        continue,
    end
    
    
    for iFile = 1:length(filesGSR)
        IDfileGSR = char(fullfile(folderID, ...
            participants(subjectData.usedGSR(i)), filesGSR(iFile).name));
        
        fid = fopen(IDfileGSR);
        bit_valuemat = fread(fid);
        gsrMat{iFile} = bit_valuemat(1:1200:size(bit_valuemat, 1));
    end
    if subjectData.GSRorder(i) == 2
        preprocessedData.GSR{i, 1} = gsrMat{1, 2};
        preprocessedData.GSR{i, 2} = gsrMat{1, 1};
    else
        preprocessedData.GSR{i, 1} = gsrMat{1, 1};
        preprocessedData.GSR{i, 2} = gsrMat{1, 2};
    end
    
    
    
    for iFile = 1:length(filesTimestamps)
        IDfileTimestamp = char(fullfile(folderID, ...
            participants(subjectData.usedGSR(i)), ...
            filesTimestamps(iFile).name));
        
        fid = fopen(IDfileTimestamp);
        timestampsMat(iFile) = textscan(fid, '%q');
        
    end
    if subjectData.GSRorder(i) == 2
        preprocessedData.timestamps{i, 1} = timestampsMat{1, 2};
        preprocessedData.timestamps{i, 2} = timestampsMat{1, 1};
    else
        preprocessedData.timestamps{i, 1} = timestampsMat{1, 1};
        preprocessedData.timestamps{i, 2} = timestampsMat{1, 2};
    end
    
end
end