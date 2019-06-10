function [params] = GetParameters ()
% Folders
params.dataDirectory = 'V:\Data\07. OutcomeNoise';

params.waves_trial = [...
    1:30;
    31:60;
    61:90;
    ];

% Questionnaires
params.quest.owner = 1:4;
params.quest.ownerCnt = 5:6;
params.quest.similar = 7;

params.quest.agenAction = 8:11;
params.quest.agenOutcome = 12:13;
params.quest.agenActionCnt = 14:16;
params.quest.agenOutcomeCnt = 17:18;

params.quest.location = 19:20;

params.conditionsVisuomotor = {...
    'Control', ...
    'Action Noise', ...
    'Outcome Noise', ...
    'Both Impaired'};
params.conditionsOutcomeOwnership = {...
    'Control', ...
    'Detached hand', ...
    'Outcome Impaired', ...
    'Outcome Impaired Detached Hand'};

% Analysis
params.tags.Controller.wave = 'WaveController';
params.tags.Controller.trial = 'TrialController';
params.tags.Event.waveStart = 'Entering state Target';
params.tags.Event.waveEnd{1} = 'Waved correctly'; %  'Entering state Waved'
params.tags.Event.waveEnd{2} = 'Waved incorrectly';
params.tags.Event.waveEnd{3} = 'Wave late'; % this one should be ignored


end


