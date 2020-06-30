function [params] = GetParameters ()
% Folders
params.dataDirectory = 'E:\Data\08. CB_VR_Outcome'; 

params.experimentTypes = {'Visuomotor Information' 'Outcome Ownership'};

% Sociodemographic table
params.sociodem.number = 1;
params.sociodem.subjectID = 2;
params.sociodem.gender = 3;
params.sociodem.age = 4;
params.sociodem.scholarity = 5;
params.sociodem.gaming = 6;
params.sociodem.VRuse = 7;
params.sociodem.EHI = 8;
params.sociodem.sessionOrder = 9;
params.sociodem.GSR = 10;
params.sociodem.used = 11;

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
    'Full arm - congruent', ...
    'Full arm - incongruent movement', ...
    'Full arm - incongruent outcome', ...
    'Full arm - incongruent'};
params.conditionsOutcomeOwnership = {...
    'Full arm - congruent', ...
    'Detached hand - congruent', ...
    'Full arm - incongruent outcome', ...
    'Detached hand - incongruent outcome'};

% Analysis
params.tags.Controller.wave = 'WaveController';
params.tags.Controller.trial = 'TrialController';
params.tags.Event.Start = 'Started';
params.tags.Event.End = 'Entering state End';
params.tags.Event.trialEnd = 'Event SpTrialFinished';
params.tags.Event.waveStart = 'Entering state Target';
params.tags.Event.waveEnd{1} = 'Waved correctly'; %  'Entering state Waved'
params.tags.Event.waveEnd{2} = 'Waved incorrectly';
params.tags.Event.waveEnd{3} = 'Wave late'; % this one should be ignored

% Trial Information File Header

params.trialInformation.trialNumber = 1;
params.trialInformation.continuity = 2;
params.trialInformation.setThreat = 3;
params.trialInformation.noiseType = 4;
params.trialInformation.knifeLocation = 5;
params.trialInformation.genderModel = 6;
params.trialInformation.handOffset = 7;
params.trialInformation.probability = 8;
params.trialInformation.totalWaves = 9; % this seems to be wrong
params.trialInformation.correctWaves = 10;
params.trialInformation.incorrectWaves = 11;
params.trialInformation.lateWaves = 12;



end


