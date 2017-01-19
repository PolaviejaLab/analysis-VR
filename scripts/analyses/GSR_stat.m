addpath('..\statistics\');

load('..\..\data\GSR_nocond.mat');

% figure,plot(median(pepo,2)/mean(median(pepo(1:50,:),2)))
% hold on,plot(median(mulero,2)/mean(median(mulero(1:50,:),2)),'r')
% hold on,plot(median(carlcox,2)/mean(median(carlcox(1:50,:),2)),'k')
% hold on,plot(median(varela,2)/mean(median(varela(1:50,:),2)),'g')
% legend({'cond1', 'cond2', 'cond3', 'cond4'}, 'Location', 'Northwest');

ii = 10000;

cmp_gsr1 = nan(1, 100); cmp_gsr2 = nan(1, 100); 
cmp_gsr3 = nan(1, 100); cmp_gsr4 = nan(1, 100);
cmp_gsr5 = nan(1, 100); cmp_gsr6 = nan(1, 100);
cmp_gsr7 = nan(1, 100); cmp_gsr8 = nan(1, 100); 
cmp_gsr9 = nan(1, 100); cmp_gsr10 = nan(1, 100);
cmp_gsr11 = nan(1, 100); cmp_gsr12 = nan(1, 100);

for t = 1:100
    cmp_gsr1(1, t) = stat_bootstrapping(ii, pepo(t, :), mulero(t, :));
    cmp_gsr2(1, t) = stat_bootstrapping(ii, pepo(t, :), carlcox(t, :));
    cmp_gsr3(1, t) = stat_bootstrapping(ii, pepo(t, :), varela(t, :));
    cmp_gsr4(1, t) = stat_bootstrapping(ii, mulero(t, :), pepo(t, :));
    cmp_gsr5(1, t) = stat_bootstrapping(ii, mulero(t, :), carlcox(t, :));
    cmp_gsr6(1, t) = stat_bootstrapping(ii, mulero(t, :), varela(t, :));
    cmp_gsr7(1, t) = stat_bootstrapping(ii, carlcox(t, :), pepo(t, :));
    cmp_gsr8(1, t) = stat_bootstrapping(ii, carlcox(t, :), mulero(t, :));
    cmp_gsr9(1, t) = stat_bootstrapping(ii, carlcox(t, :), varela(t, :));
    cmp_gsr10(1, t) = stat_bootstrapping(ii, varela(t, :), pepo(t, :));
    cmp_gsr11(1, t) = stat_bootstrapping(ii, varela(t, :), mulero(t, :));
    cmp_gsr12(1, t) = stat_bootstrapping(ii, varela(t, :), carlcox(t, :));
end

res_cmp = [cmp_gsr1; cmp_gsr2; cmp_gsr3; cmp_gsr4; cmp_gsr5; cmp_gsr6;
cmp_gsr7; cmp_gsr8; cmp_gsr9; cmp_gsr10; cmp_gsr11; cmp_gsr12];

figure, plot(1:100, res_cmp); 
line([0 100], [0.05 0.05], 'LineStyle', ':');
