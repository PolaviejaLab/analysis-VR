function [subjectData] = extractSociodemographics (params, sociodemographicsFile)

% Read the file
sociodem_table = readtable(fullfile(params.dataDirectory, sociodemographicsFile));

% Find the participants that are included for analysis 
% Inclusion Criteria: the tracking worked well, the the participant 
% followed our instructions, naîve to the study)
indUsed = find(table2array(sociodem_table(:, params.sociodem.used)));


subjectData.nParticipants = numel(indUsed);

% subject code
subjectData.subjectID = table2array(sociodem_table(indUsed, params.sociodem.subjectID));

% gender data
subjectData.nFemales = sum(table2array(sociodem_table(indUsed, params.sociodem.gender)));
subjectData.nMales = subjectData.nParticipants - subjectData.nFemales;
subjectData.percFemale = subjectData.nFemales/subjectData.nParticipants * 100;

% age
subjectData.ages = table2array(sociodem_table(indUsed, params.sociodem.age));
subjectData.ageMean = [mean(subjectData.ages), std(subjectData.ages)];

% scholarity
subjectData.scholarity.none = find(table2array(sociodem_table(indUsed, params.sociodem.scholarity)) == 1);
subjectData.scholarity.highschool = find(table2array(sociodem_table(indUsed, params.sociodem.scholarity)) == 2);
subjectData.scholarity.university = find(table2array(sociodem_table(indUsed, params.sociodem.scholarity)) == 3);
subjectData.scholarity.master = find(table2array(sociodem_table(indUsed, params.sociodem.scholarity)) == 4);
subjectData.scholarity.phd = find(table2array(sociodem_table(indUsed, params.sociodem.scholarity)) == 5);

subjectData.percScholarity = [...
    numel(subjectData.scholarity.none)/subjectData.nParticipants * 100, ...
    numel(subjectData.scholarity.highschool)/subjectData.nParticipants * 100, ...
    numel(subjectData.scholarity.university)/subjectData.nParticipants * 100, ...
    numel(subjectData.scholarity.master)/subjectData.nParticipants * 100, ...
    numel(subjectData.scholarity.phd)/subjectData.nParticipants * 100 ...
    ];

% Gaming Experience
subjectData.gaming.usuallyNot = find(table2array(sociodem_table(indUsed, params.sociodem.gaming)) == 1);
subjectData.gaming.seldom = find(table2array(sociodem_table(indUsed, params.sociodem.gaming)) == 2);
subjectData.gaming.month = find(table2array(sociodem_table(indUsed, params.sociodem.gaming)) == 3);
subjectData.gaming.week = find(table2array(sociodem_table(indUsed, params.sociodem.gaming)) == 4);
subjectData.gaming.day = find(table2array(sociodem_table(indUsed, params.sociodem.gaming)) == 5);

subjectData.percGaming = [...
    numel(subjectData.gaming.usuallyNot)/subjectData.nParticipants * 100, ...
    numel(subjectData.gaming.seldom)/subjectData.nParticipants * 100, ...
    numel(subjectData.gaming.month)/subjectData.nParticipants * 100, ...
    numel(subjectData.gaming.week)/subjectData.nParticipants * 100, ...
    numel(subjectData.gaming.day)/subjectData.nParticipants * 100 ...
    ];

% Virtual Reality Use
subjectData.VRuse.first = find(table2array(sociodem_table(indUsed, params.sociodem.VRuse)) == 1);
subjectData.VRuse.already = find(table2array(sociodem_table(indUsed, params.sociodem.VRuse)) == 2);
subjectData.VRuse.always = find(table2array(sociodem_table(indUsed, params.sociodem.VRuse)) == 3);

subjectData.perVRuse = [...
    numel(subjectData.VRuse.first)/subjectData.nParticipants * 100, ...
    numel(subjectData.VRuse.already)/subjectData.nParticipants * 100, ...
    numel(subjectData.VRuse.always)/subjectData.nParticipants * 100 ...
    ];

% Order Session
subjectData.firstSession_VI = find(table2array(sociodem_table(indUsed, params.sociodem.sessionOrder)) == 1);
subjectData.firstSession_OO = find(table2array(sociodem_table(indUsed, params.sociodem.sessionOrder)) == 2);
subjectData.percFirstSession = [...
    numel(subjectData.firstSession_VI)/subjectData.nParticipants * 100, ...
    numel(subjectData.firstSession_OO)/subjectData.nParticipants * 100 ...
    ];

% Handedness (EHI - Davis 1970)
subjectData.EHI = table2array(sociodem_table(indUsed, params.sociodem.EHI));
subjectData.EHIMean = [mean(subjectData.EHI), std(subjectData.EHI)];

% Subjects with GSR
subjectData.usedGSR = find(table2array(sociodem_table(indUsed, params.sociodem.GSR)));
subjectData.GSRorder = table2array(sociodem_table(subjectData.usedGSR, params.sociodem.sessionOrder));

end