function [results] =  statisticsQuestionnaires(data1, data2)

results.means = [nanmean(data1(:)), nanmean(data2(:))];
results.medians = [nanmedian(data1(:)), nanmedian(data2(:))];
results.std = [nanstd(data1(:)), nanstd(data2(:))];


results.stats.SignedRank = signrank (data1, data2);

[R, P] = corrcoef (data1, data2);
results.stats.pearsonR = R(1,2);
results.stats.corrPval = P(1,2);

[results.stats.groups] = analysisGroups (data1, data2);


end