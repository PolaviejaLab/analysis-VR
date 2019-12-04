function [results] = pairwiseComparisons (data)

% Visuomotor Information, sense of ownership
[results.ownership.visuomotor.congruent_imovement] = statisticsQuestionnaires(...
    data.owner.visuomotor(1, :), data.owner.visuomotor(2, :));
    
[results.ownership.visuomotor.congruent_ioutcome] = statisticsQuestionnaires(...
    data.owner.visuomotor(1, :), data.owner.visuomotor(3, :));

[results.ownership.visuomotor.congruent_incongruent] = statisticsQuestionnaires(...
    data.owner.visuomotor(1, :), data.owner.visuomotor(4, :));

[results.ownership.visuomotor.imovement_ioutcome] = statisticsQuestionnaires (...
    data.owner.visuomotor(2, :), data.owner.visuomotor(3, :));

[results.ownership.visuomotor.imovement_incongruent] = statisticsQuestionnaires (...
    data.owner.visuomotor(2, :), data.owner.visuomotor(4, :));

[results.ownership.visuomotor.ioutcome_incongruent] = statisticsQuestionnaires (...
    data.owner.visuomotor(3, :), data.owner.visuomotor(4, :));

% Visuomotor Information, sense of agency (action)
[results.agency.visuomotor.congruent_imovement] = statisticsQuestionnaires(...
    data.agency.visuomotor(1, :), data.agency.visuomotor(2, :));
    
[results.agency.visuomotor.congruent_ioutcome] = statisticsQuestionnaires(...
    data.agency.visuomotor(1, :), data.agency.visuomotor(3, :));

[results.ownership.visuomotor.congruent_incongruent] = statisticsQuestionnaires(...
    data.agency.visuomotor(1, :), data.agency.visuomotor(4, :));

[results.agency.visuomotor.imovement_ioutcome] = statisticsQuestionnaires (...
    data.agency.visuomotor(2, :), data.agency.visuomotor(3, :));

[results.agency.visuomotor.imovement_incongruent] = statisticsQuestionnaires (...
    data.agency.visuomotor(2, :), data.agency.visuomotor(4, :));

[results.agency.visuomotor.ioutcome_incongruent] = statisticsQuestionnaires (...
    data.agency.visuomotor(3, :), data.agency.visuomotor(4, :));


% Visuomotor Information, outcome agency (action)
[results.outcome.visuomotor.congruent_imovement] = statisticsQuestionnaires(...
    data.outcome.visuomotor(1, :), data.outcome.visuomotor(2, :));
    
[results.agency.visuomotor.congruent_ioutcome] = statisticsQuestionnaires(...
    data.outcome.visuomotor(1, :), data.outcome.visuomotor(3, :));

[results.ownership.visuomotor.congruent_incongruent] = statisticsQuestionnaires(...
    data.outcome.visuomotor(1, :), data.outcome.visuomotor(4, :));

[results.agency.visuomotor.imovement_ioutcome] = statisticsQuestionnaires (...
    data.outcome.visuomotor(2, :), data.outcome.visuomotor(3, :));

[results.agency.visuomotor.imovement_incongruent] = statisticsQuestionnaires (...
    data.outcome.visuomotor(2, :), data.outcome.visuomotor(4, :));

[results.agency.visuomotor.ioutcome_incongruent] = statisticsQuestionnaires (...
    data.outcome.visuomotor(3, :), data.outcome.visuomotor(4, :));


% Block B - sense of ownership
[results.ownership.outcome.congruent_detached] = statisticsQuestionnaires(...
    data.owner.outcome(1, :), data.owner.outcome(2, :));
    
[results.ownership.outcome.congruent_ioutcome] = statisticsQuestionnaires(...
    data.owner.outcome(1, :), data.owner.outcome(3, :));

[results.ownership.outcome.congruent_idetached] = statisticsQuestionnaires(...
    data.owner.outcome(1, :), data.owner.outcome(4, :));

[results.ownership.outcome.detached_ioutcome] = statisticsQuestionnaires (...
    data.owner.outcome(2, :), data.owner.outcome(3, :));

[results.ownership.outcome.detached_idetached] = statisticsQuestionnaires (...
    data.owner.outcome(2, :), data.owner.outcome(4, :));

[results.ownership.outcome.ioutcome_idetached] = statisticsQuestionnaires (...
    data.owner.outcome(3, :), data.owner.outcome(4, :));

% Block B, sense of agency (action)
[results.agency.outcome.congruent_detached] = statisticsQuestionnaires(...
    data.agency.outcome(1, :), data.agency.outcome(2, :));
    
[results.agency.outcome.congruent_ioutcome] = statisticsQuestionnaires(...
    data.agency.outcome(1, :), data.agency.outcome(3, :));

[results.ownership.outcome.congruent_idetached] = statisticsQuestionnaires(...
    data.agency.outcome(1, :), data.agency.outcome(4, :));

[results.agency.outcome.detached_ioutcome] = statisticsQuestionnaires (...
    data.agency.outcome(2, :), data.agency.visuomotor(3, :));

[results.agency.outcome.detached_idetached] = statisticsQuestionnaires (...
    data.agency.outcome(2, :), data.agency.outcome(4, :));

[results.agency.outcome.ioutcome_idetached] = statisticsQuestionnaires (...
    data.agency.outcome(3, :), data.agency.outcome(4, :));


% Block B, outcome agency (action)
[results.outcome.outcome.congruent_detached] = statisticsQuestionnaires(...
    data.outcome.outcome(1, :), data.outcome.visuomotor(2, :));
    
[results.agency.outcome.congruent_ioutcome] = statisticsQuestionnaires(...
    data.outcome.outcome(1, :), data.outcome.outcome(3, :));

[results.ownership.outcome.congruent_incongruent] = statisticsQuestionnaires(...
    data.outcome.outcome(1, :), data.outcome.outcome(4, :));

[results.agency.outcome.detached_ioutcome] = statisticsQuestionnaires (...
    data.outcome.outcome(2, :), data.outcome.visuomotor(3, :));

[results.agency.outcome.detached_idetached] = statisticsQuestionnaires (...
    data.outcome.outcome(2, :), data.outcome.outcome(4, :));

[results.agency.outcome.ioutcome_idetached] = statisticsQuestionnaires (...
    data.outcome.outcome(3, :), data.outcome.outcome(4, :));

end
