%% Get the indices of the order
vifirstind = find(sociodem_array(:, 7) == 1);
oofirstind = find(sociodem_array(:, 7) == 2);

%% Get the values of the questionnaires

vifirst_VI = QuestionnaireData.visuomotorInformation.responses(:, :, vifirstind);
oofirst_VI = QuestionnaireData.visuomotorInformation.responses(:, :, oofirstind);

vifirst_OO = QuestionnaireData.outcomeOwnership.responses(:, :, vifirstind);
oofirst_OO = QuestionnaireData.outcomeOwnership.responses(:, :, oofirstind);

%% 

[results.byOrder.vifirst_VI.ownership] = statisticsQuestionnaires (...
    nanmean(squeeze(QuestionnaireData.visuomotorInformation.responses(params.quest.agenAction, 1, :))), ...
    nanmean(squeeze(QuestionnaireData.visuomotorInformation.responses(params.quest.agenAction, 2, :))) ...
    );
    


