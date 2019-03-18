function [wavesTrialStart,wavesTrialEnd ] = cutWavesPerTrial (waves_timestamps, ...
    trial_bounds, params)

nTrials = numel(params.dynamicTrials);
% nWaves = params.waves_trial;

for i_subject = 1:37 % change to n of participants
    for i_trial = 1:nTrials
        try
        trial_start = trial_bounds{i_subject, 1}(i_trial, 1:16);
        trial_end = trial_bounds{i_subject, 2}(i_trial, 1:16);
        
        [ind_start] = ...
            strmatch (trial_start, waves_timestamps{i_subject, 1});
        [ind_end] = ...
            strmatch (trial_end, waves_timestamps{i_subject, 2});
        catch
            ind_start = NaN;
            ind_end = NaN; 
        end
        
        % first wave should alawys be the frist. 
        
        if i_trial == 1 && isempty(ind_start)
            ind_start = 1;
        end
        
        if ~isnan(ind_start) && ~isnan(ind_end)    
            wavesTrialStart{i_subject, i_trial} = ...
                waves_timestamps{i_subject, 1}(ind_start(1, :), ind_end(1, :));
            wavesTrialEnd{i_subject, i_trial} = ...
                waves_timestamps{i_subject, 2}(ind_start(1, :), ind_end(1, :));
        else
            wavesTrialStart{i_subject, i_trial} = NaN;
            wavesTrialEnd{i_subject, i_trial} = NaN;
        end 
        
        
     
    end
end 

% % divide into 3 trials that each will contain all waves for each trial
% % it needs to see that the waves are within this trials
% % it needs to check if the end matched the corresponding start.
% % store it a way that makes sense for using them later.
% % struct. 37 x 3, each cell of them containing the pairs for
% % starting and ending for each wave.
% 
% 
% for i_subject = 1:size(testWave, 1)
%     subjectInfoStart = testWave{i_subject, 1};
%     subjectInfoEnd = testWave{i_subject, 2};
%     for i_trial = 1:nTrials
%         try
%             wavesPerTrial{i_subject, i_trial}{1} =  subjectInfoStart(params.waves_trial(i_trial, :), :);
%             wavesPerTrial{i_subject, i_trial}{2} =  subjectInfoEnd(params.waves_trial(i_trial, :), :);
%         catch
%             wavesPerTrial{i_subject, i_trial}{1} =  NaN;
%             wavesPerTrial{i_subject, i_trial}{2} = NaN;
%         end
%     end
% 
end