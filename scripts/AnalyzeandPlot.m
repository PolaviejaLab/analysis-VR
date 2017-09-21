function [mn, stds, md, pVec, corrVec, groupVec] = AnalyzeandPlot ...
    (i_fig, data1, data2, cond1, cond2, FigTitle)

i_fig = i_fig + 1;

clear mn md pttest pmann pks2 R P pGroups

[mn, stds, md, pttest, pmann, ~, ~] = ...
    analysisQuestions (data1, data2);

[fig1, fig2] = plotQuestionnaires(...
    data1, data2, ...
    FigTitle, ...
    cond1, cond2, pmann);

% Distributions
[~, pks2] = kstest2(data1(:), data2(:));

% Correlations
[R, P] = corrcoef (nanmean(data1), nanmean(data2));
corrVec = [R, P];

[fig3] = plotCorrelations(data1, data2, ...
    FigTitle, cond1, cond2, ...
    R(1,2), P(1,2));

pVec = [pttest, pmann, pks2];

[pGroups, nLow, nMed, nHigh] = analysisGroups(data1,data2);
groupVec = [pGroups;
    nLow, nMed, nHigh];

FigName = strcat('Figure',num2str(i_fig));

saveas(fig1, strcat(saveDirectory, FigName, 'A.png'));
saveas(fig1, strcat(saveDirectory, FigName, 'A.eps'));
saveas(fig1, strcat(saveDirectory, FigName, 'A.fig'));
saveas(fig2, strcat(saveDirectory, FigName, 'B.png'));
saveas(fig2, strcat(saveDirectory, FigName, 'B.eps'));
saveas(fig2, strcat(saveDirectory, FigName, 'B.fig'));
saveas(fig3, strcat(saveDirectory, FigName, 'C.png'));
saveas(fig3, strcat(saveDirectory, FigName, 'C.eps'));
saveas(fig3, strcat(saveDirectory, FigName, 'C.fig'));


end