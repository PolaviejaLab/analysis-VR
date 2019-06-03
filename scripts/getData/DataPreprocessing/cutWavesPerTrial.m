function [wavesOnTrial] = cutWavesPerTrial (waves_timestamps, ...
    trial_bounds, params)


nTrials = numel(params.dynamicTrials);
% nWaves = params.waves_trial;
aux_ = nan;
wavesOnTrial = [];


for s = 1:37 % change to n of participants
    
    % if there is no information about the timestamps of the waves, it will
    % log a nan in the corresponding position and move on to the next
    % subject.
    if (isempty(waves_timestamps{1, s}))
        wavesOnTrial{s, 1}(1:3) = nan;
        wavesOnTrial{s, 2}(1:3) = nan;
        continue,
    end
    
    
    for t = 1:nTrials
        % Transform the trials bound timestamps into times that can be
        % substracted between each other.
        try
            times_start = datenum8601(trial_bounds{s, 1}(t, 1:22));
            times_end = datenum8601(trial_bounds{s, 2}(t, 1:22));
        catch
            times_start = nan;
            times_end = nan;
        end
        
        
        % Using these times, find which of the waves is the one closest.
        % Get the index of that wave to be able to break the waves into
        % three trials. Select those indices, and make three groups of
        % start-end timestamps.
        if (isnan(times_start))
            warning('no timestamp for trial %u in subject %u', t, s);
            continue,
        else
            indicesBoundsWaves(t, 1) = ...
                findClosest(times_start, waves_timestamps{1, s}{1, 1}(1, 1:22));
            indicesBoundsWaves(t, 2) = ...
                findClosest(times_end, waves_timestamps{1, s}(:, 1:22));
        end
    end
    
    

    
    

    

end




