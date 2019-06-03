function [wavesOnTrial] = cutWavesPerTrial_ (waves_timestamps, ...
    trial_bounds, params)

nTrials = numel(params.dynamicTrials);
% nWaves = params.waves_trial;
aux_ = nan;
wavesOnTrial = [];

for i_subject = 1:37 % change to n of participants
    
    % if there is no information about the timestamps of the waves, it will
    % log a nan in the corresponding position and move on to the next
    % subject.
    if (isempty(waves_timestamps{i_subject, 1}))
        wavesOnTrial{i_subject, 1}(1:3) = nan;
        wavesOnTrial{i_subject, 2}(1:3) = nan;
        continue,
    end
    
    for iw = 1:size(waves_timestamps{i_subject, 1}, 1)
        try
            aux_(iw, 1) = datenum8601(waves_timestamps{i_subject, 1}(iw, 1:22));
        catch
            aux_(iw, 1) = nan;
        end
        try
            aux_(iw, 2) = datenum8601(waves_timestamps{i_subject, 2}(iw, 1:22));
        catch
            aux_(iw, 2) = nan;
        end
    end
    
    
    % Get the indices of the waves at the begining and the end of the
    % trials.
    for i_trial = 1:nTrials
        try
            auxt_start = datenum8601(trial_bounds{i_subject, 1}(i_trial, 1:22));
            auxt_end = datenum8601(trial_bounds{i_subject, 2}(i_trial, 1:22));
            
            ind_startTrialWave(i_trial) = findClosestTimestamp(auxt_start, aux_(:, 1));
            ind_endTrialWave(i_trial) = findClosestTimestamp(auxt_end, aux_(:, 2));
        catch
            ind_startTrialWave(i_trial) = nan;
            ind_endTrialWave(i_trial) = nan;
        end
    end
    
    % for trial 1, need to find a cleaner way to do this
    try
        wavesOnTrial{i_subject, 1}{1} = ...
            waves_timestamps{i_subject, 1}(ind_startTrialWave(1):...
            ind_startTrialWave(2)-1, :);
        wavesOnTrial{i_subject, 1}{2} = ...
            waves_timestamps{i_subject, 2}(1:...
            ind_endTrialWave(1), :);
    catch
        wavesOnTrial{i_subject, 1}{1} = nan;
        wavesOnTrial{i_subject, 1}{2} = nan;
    end
    
    
    % for trial 2, need to find a cleaner way to do this
    try
        wavesOnTrial{i_subject, 2}{1} = ...
            waves_timestamps{i_subject, 1}(ind_startTrialWave(2):...
            ind_startTrialWave(3)-1, :);
        wavesOnTrial{i_subject, 2}{2} = ...
            waves_timestamps{i_subject, 2}(ind_endTrialWave(1)+1:...
            ind_endTrialWave(2), :);
    catch
        wavesOnTrial{i_subject, 2}{1} = nan;
        wavesOnTrial{i_subject, 2}{2} = nan;
    end
    
    % for trial 3, need to find a cleaner way to do this
    try
        wavesOnTrial{i_subject, 3}{1} = ...
            waves_timestamps{i_subject, 1}(ind_startTrialWave(3): ...
            size(waves_timestamps{i_subject, 1}, 1), :);
        wavesOnTrial{i_subject, 3}{2} = ...
            waves_timestamps{i_subject, 2}(ind_endTrialWave(2)+1:...
            ind_endTrialWave(3), :);
    catch
        wavesOnTrial{i_subject, 3}{1} = nan;
        wavesOnTrial{i_subject, 3}{2} = nan;
    end
end




end