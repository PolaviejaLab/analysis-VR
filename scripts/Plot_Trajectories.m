addpath('analyses');
addpath('getData\');


%% Load trajectory Data
[params] = GetParameters();
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat');

fprintf('Data loaded \n');

%% GetVariables
numParticipats = size(processed.hpositions.trials, 1);


%% Plot the full task for individuals
fprintf('Plotting whole trajectory tasks \n');
for i_participant = 1:numParticipats
    fig = figure(i_participant); hold on,
    try
        plot(...
            processed.hpositions.trials{i_participant, 1}(:, 3), ...
            processed.hpositions.trials{i_participant, 1}(:, 1), 'k');
        plot(...
            processed.hpositions.trials{i_participant, 2}(:, 3), ...
            processed.hpositions.trials{i_participant, 2}(:, 1), 'b');
        plot(...
            processed.hpositions.trials{i_participant, 3}(:, 3), ...
            processed.hpositions.trials{i_participant, 3}(:, 1), 'r');
    catch
        fprintf('No task data to plot for participant %u \n', i_participant);
    end
    title(strcat('Participant ', num2str(i_participant)));
    hold off, box on,
end


%% Plot individual waving events
fprintf('Plotting individual waving events \n');
for i_participant = 1:numParticipats
    fig = figure(i_participant + 37);
    hold on,
    
    for i_trial = 1:3
        
        for i_wave = 1:size(processed.hpositions.waves{i_participant, i_trial}, 2)
            try
                figure, plot(...
                    processed.hpositions.wave{i_participant, 1}{1, i_wave}(:, 3), ...
                    processed.hpositions.wave{i_participant, 1}{1, i_wave}(:, 1), 'k');
                
            catch
                fprintf('No waving event data to plot for participant %u \n', i_participant);
            end
        end
        
    end
    
    
    hold off, box on,
end






