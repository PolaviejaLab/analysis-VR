function [means, medians, pval_ttest, ...
    pval_mannwit, pval_permutationmeans, pval_permutationsmedians] =  ...
    analysisQuestions(data1, data2)

means = [nanmean(data1(:)), nanmean(data2(:))];
medians = [nanmedian(data1(:)), nanmedian(data2(:))];

[~, pval_ttest] = ttest2(data1(:), data2(:));

[pval_mannwit] = ranksum (data1(:), data2(:));


pval_permutationmeans = 0;

pval_permutationsmedians = 0;

end