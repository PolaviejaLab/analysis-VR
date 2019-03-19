function [params] = GetParameters()
%GETPARAMETERS Summary of this function goes here
%   Detailed explanation goes here

% Folders
params.dataDirectory = 'V:\Data\01. Pilots_ExperimentDiscontinuity';

% Questionnaires
params.quest.ownership = 1:4;
params.quest.similar = 5;
params.quest.ownershipcontrol = 6:7;
params.quest.agency = 8:10;
params.quest.agencycontrol = 11:12;
params.quest.location = 13:14;

% Conditions
params.conditions = {...
    'Full arm - Displacement(0)', ...
    'Full arm - Displacement(5)', ...
    'Full arm - Displacement(10)', ...
    'Detached hand - Displacement (0)', ...
    'Detached hand - Displacement (5)', ...
    'Detached hand - Displacement (10)'};

end

