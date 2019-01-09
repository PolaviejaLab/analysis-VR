function [wavesPerTrial] = cutWavesPerTrial (waves_timestamps, trials_bounds)


params = GetParameters();

nTrials = numel(params.dynamicTrials);
nWaves = params.waves_trial;


% divide into 3 trials that each will contain all waves for each trial
% it needs to see that the waves are within this trials
% it needs to check if the end matched the corresponding start.
% store it a way that makes sense for using them later.
% struct. 37 x 3, each cell of them containing the pairs for
% starting and ending for each wave.

testWave = waves_timestamps;
testTrials = trials_bounds;

for i_subject = 1:size(testWave, 1)
    subjectInfoStart = testWave{i_subject, 1};
    subjectInfoEnd = testWave{i_subject, 2};
    for i_trial = 1:nTrials
        try
            wavesPerTrial{i_subject, i_trial}{1} =  subjectInfoStart(params.waves_trial(i_trial, :), :);
            wavesPerTrial{i_subject, i_trial}{2} =  subjectInfoEnd(params.waves_trial(i_trial, :), :);
        catch
            wavesPerTrial{i_subject, i_trial}{1} =  NaN;
            wavesPerTrial{i_subject, i_trial}{2} = NaN;
        end
    end

end