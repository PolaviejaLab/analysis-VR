function [params] = GetParameters ()
% Folders
params.dataDirectory = 'V:\Data\06. ExpRep';

% Questionnaires 
params.quest.owner = 1:4;
params.quest.ownerCnt = [5,7];
params.quest.similar = 6;

params.quest.agenDyn = 8:11;
params.quest.agenOut = 12:13;
params.quest.agenDynC = 14:16;

params.quest.agenStat = 8:9;
params.quest.agenStatC = 10;

params.quest.locDyn = 18:19;
params.quest.locStat = 11;

% Trials
params.staticTrials = [1,2,5];
params.dynamicTrials = [3,4,6];

params.conditionStatic = {...
    'Full arm static', ...
    'Detached hand static', ...
    'Full arm static - post'};
params.conditionDynamic = {...
    'Full arm dynamic', ...
    'Detached hand dynamic', ...
    'Incongruent movement'};

end 


