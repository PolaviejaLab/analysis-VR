function [pvals_array] = analysisGroups (data1, data2)

basal_low = find(nanmean(data1) <= 3);
basal_med = find(nanmean(data1) > 3 & nanmean(data1) < 5);
basal_hig = find(nanmean(data1) >= 5);

addpath('statistics\');

[pvals_array] = stat_bygroups (10000, basal_low, basal_med, ...
    basal_hig, data1, data2);
end

