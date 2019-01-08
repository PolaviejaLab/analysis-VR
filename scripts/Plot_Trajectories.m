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
for i_participant = 2:numParticipats
    fig = figure(i_participant + 37);
    hold on,
    try
        for i_wave = 1:25
            if (~isempty(processed.hpositions.wave{i_participant, 1}{1, i_wave}))
            plot(...
                processed.hpositions.wave{i_participant, 1}{1, i_wave}(:, 3), ...
                processed.hpositions.wave{i_participant, 1}{1, i_wave}(:, 1), 'k');
            else
                continue,
            end
        end
        for i_wave = 1:25
            if (~isempty(processed.hpositions.wave{i_participant, 2}{1, i_wave}))
            plot(...
                processed.hpositions.wave{i_participant, 2}{1, i_wave}(:, 3), ...
                processed.hpositions.wave{i_participant, 2}{1, i_wave}(:, 1), 'b');
                        else
                continue,
            end
        end
        for i_wave = 1:25
            if (~isempty(processed.hpositions.wave{i_participant, 3}{1, i_wave}))
            plot(...
                processed.hpositions.wave{i_participant, 3}{1, i_wave}(:, 3), ...
                processed.hpositions.wave{i_participant, 3}{1, i_wave}(:, 1), 'r');
                        else
                continue,
            end
        end
    catch
        fprintf('No waving event data to plot for participant %u \n', i_participant);
    end
    title(strcat('Participant ', num2str(i_participant)));
    hold off, box on,
end

