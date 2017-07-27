addpath('getData\');

dataDirectory = 'V:\Data\06. ExpRep';


%% Load sociodemographics and other relevant data (sociodemographics.txt)
% Adjust the auxiliar variables according to the morphology of the table
[vecUsed, perFem, meanAge, stdAge, schArray, gameArray, vrArray] = ...
    sociodem (dataDirectory);


%% Load questionnaire data
[static_data, dynamic_data] = getData(dataDirectory);


%% 