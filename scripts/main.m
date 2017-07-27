addpath('getData\');

dataDirectory = 'V:\Data\06. ExpRep';


%% Load sociodemographics and other relevant data (sociodemographics.txt)
% The vectors are already extracted with the subjects that are going to be
% used for the analysis
% Adjust the auxiliar variables according to the morphology of the table
[vecUsed, perFem, meanAge, stdAge, scholarity, gaming, vr] = ...
    sociodem (dataDirectory);


%% Load questionnaire data
[static_data, dynamic_data] = getData(dataDirectory);

static_data = static_data(:, :, vecUsed);
dynamic_data = dynamic_data(:, :, vecUsed);


%% 