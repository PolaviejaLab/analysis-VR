function [results] = ownership_sociodem (ownership, sociodem)
% 
% % This is working with the data for experiment 2 in the thesis. 
% ownerships = nanmean(squeeze(QuestionnaireData.static(1:4, 1, vecUsed)));
% ownershipd = nanmean(squeeze(QuestionnaireData.dynamic(1:4, 1, vecUsed)));
% 
% % ownership = ownerships;
% ownership = ownershipd;
% 
% 
% % Experiment2 differences in gender, gaming and vr in active and dynamic
% 
% [a, b, c]  = signrank(ownerships(SubjectData.females), ownershipd(SubjectData.females))
% [a, b, c] =  signrank(ownerships(SubjectData.males), ownershipd(SubjectData.males))
% 
% 
% % gender
% 
% [pval_gender, ~, stat_gender] = ranksum (ownership(SubjectData.females), ownership(SubjectData.males));
% 
% figure,
% G = [ones(size(ownership(SubjectData.females)))  2*ones(size(ownership(SubjectData.males)))];
% X = [ownership(SubjectData.females), ownership(SubjectData.males)];
% boxplot(X,G);
% ylim([0.5 7.5])
% 
% % Age
% 
% [a, b] = corr(SubjectData.Age.All, ownership', 'Type', 'Spearman');
% 
% figure,
% plot(SubjectData.Age.All, ownership', 'ok')
% xlim([15 50]); ylim([0.5 7.5])
% 
% 
% % gaming habits
% 
non_regular = [sociodem.gaming.usuallyNot; sociodem.gaming.seldom];
regular = [sociodem.gaming.month; sociodem.gaming.week; sociodem.gaming.day];
% 
% non_regular = [SubjectData.GameExp.UsuallyNot; SubjectData.GameExp.Seldom];
% regular = [SubjectData.GameExp.Month; SubjectData.GameExp.Week; SubjectData.GameExp.Day];
% 
[pval_game, ~, stat_game] = ranksum (ownership(non_regular), ownership(regular));
% 
% figure,
% G = [ones(size(ownership(non_regular)))  2*ones(size(ownership(regular)))];
% X = [ownership(non_regular), ownership(regular)];
% boxplot(X,G);
% ylim([0.5 7.5])
% 
% 
% 
% [a, b, c]  = signrank(ownerships(non_regular), ownershipd(non_regular))
% [a, b, c]  = signrank(ownerships(regular), ownershipd(regular))
% 
% 
% % virtual reality
% 
% first = [SubjectData.VRUse.First];
% not_first = [SubjectData.VRUse.Already; SubjectData.VRUse.Always];
% 
% [pval_vr, ~, stat_vr] = ranksum (ownership(first), ownership(not_first));
% 
% 
% figure,
% G = [ones(size(ownership(first)))  2*ones(size(ownership(not_first)))];
% X = [ownership(first), ownership(not_first)];
% boxplot(X,G);
% ylim([0.5 7.5])
% 
% [a, b, c]  = signrank(ownerships(first), ownershipd(first))
% [a, b, c]  = signrank(ownerships(not_first), ownershipd(not_first))
% 
% end