function [results] =  statisticsQuestionnaires(data1, data2)

results.SignedRank = signrank (data1, data2);

[R, P] = corrcoef (data1, data2);
results.pearsonR = R(1,2);
results.RcorrPval = P(1,2);


[results.stats.spearmanRho, results.RhocorrPval] = ...
    corr(data1', data2', 'Type', 'Spearman');

[results.p_groups, results.n_groups] = ...
    analysisGroups (data1, data2);

end