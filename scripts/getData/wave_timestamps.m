function [wavesTimestamps] = wave_timestamps ...
    (input_file, params, indicesTrial)

addpath('..\DataPreprocessing');

%GET_TIMESTAMPS Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(input_file);

full_table = textscan(fid, '%s %s %s', 'Delimiter', '\t');



% find the indices where there is a WaveController event
indController = strmatch(params.tags.Controller.wave, full_table{1,2});
indStart = strmatch(params.tags.Event.waveStart, full_table{1,3});
indCorrect = strmatch(params.tags.Event.waveEnd{1}, full_table{1,3});
indIncorrect = strmatch(params.tags.Event.waveEnd{2}, full_table{1,3});


if (isempty(indStart))
    wavesIndices = NaN;
else
    for i = 1:numel(indStart)
        for c = 1:numel(indController)
            if (indStart(i) == indController(c))
                wavesIndices(i, 1) = indStart(i);
                
                [~, closest(1)] = min(abs(indCorrect - indStart(i)));
                
                if (~isempty(indIncorrect))
                    [~, closest(2)] = min(abs(indIncorrect - indStart(i)));
                end
                
                closerIndex = findClosest(indStart(i), closest);
                
                if (closerIndex == 1)
                    wavesIndices(i, 2) = indCorrect(closest(1));
                elseif (closerIndex == 2)
                    wavesIndices(i, 2) = indIncorrect(closest(2));
                end
            else
                continue,
            end
        end
    end
end


% check that they are matched properly.
for i = 1:size(wavesIndices, 1)
    if (i == 1)
        continue,
    end
    
    if (i == size(wavesIndices, 1))
        if (wavesIndices(i, 1) < wavesIndices (i, 2))
            continue,
        else
            wavesIndices(i, 1:2) = NaN;
            fprintf('problem in wave %u \n', i);
        end
    end
    
    if (wavesIndices(i, 1) < wavesIndices (i, 2) && ...
            wavesIndices(i+1, 1) > wavesIndices (i, 2))
        continue,
    else
        wavesIndices(i, 1:2) = NaN;
        fprintf('problem in wave %u \n', i);
    end
end

% get the corresponding timestamps

timestamps = full_table{1,1};

for i = 1:size(wavesIndices, 1)
    for j = 1:size(wavesIndices, 2)
        try
            wavesTimestamps(i, j) = timestamps{wavesIndices(i, j)};
        catch
            wavesTimestamps(i, j) = nan;
        end
    end
end

% divide into trials





end


