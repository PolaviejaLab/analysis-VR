addpath('..\..\getData');

%% Load trajectory Data
load('E:\GitHub\analysis-VR\data\03. Experiment_Rep\ProcessedData_Trajectories.mat');

fprintf('Data loaded \n');

%% GetVariables
[params] = GetParameters();
numParticipats = size(processed.hpositions.trials, 1);

%% Time to the target

% do generate and save then new type of number in the processed struct. 
% transform it in something that can be done some maths to
% work on it

% also study its variability. 

