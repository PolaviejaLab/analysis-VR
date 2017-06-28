%% collection of lines that have generated the files in the figures file from today (21-06-2017)


figure, 
plot(handp' / 10, 'o'), hold on, plot(drift' * 100, 'x')
xlim ([0, 9]);
ylabel ('position in cm')
xlabel ('condition')



figure
plot(nanmean(handp')/10, 'o')
hold on
plot(nanmean(drift')*100, 'x')
title('mean')
xlabel ('position in cm')
ylabel ('position in cm')
xlabel('conditions')

plot(nanmedian(handp')/10, 'o')
hold on
plot(nanmedian(drift')*100, 'x')
title('median')
ylabel ('position in cm')
xlabel('conditions')


for i = 1:12
errorbar(i, nanmean(drift(:, i)) * 100, ...
nanstd(drift(:, i) * 100) /sqrt(8), ...
'Color', 'k');
end

load('E:\GitHub\analysis-VR\data\Exp_PilotsNoise\order.mat');

load('E:\GitHub\analysis-VR\data\Exp_PilotsNoise\order.mat');
handp1 = handp(1:8, :)
handp2 = handp(9:12, :)
handp = nan(14, 8)
handp(1:8, :) = handp1
handp(10:13, :) = handp2


[~, I_high] = find(ans >= 4)
[~, I_low] = find(ans < 4)

handp_high = handp(:, I_high)
handp_low = handp(:, I_low)




handp1 = handp(1:8, :)
handp2 = handp(9:12, :)
handp = nan(14, 8)
handp(1:8, :) = handp1
handp(10:13, :) = handp2
handp_high = handp(:, I_high)
handp_low = handp(:, I_low)
size(handp)
handp_high = handp(I_high, :)
handp_low = handp(I_low, :)
mean(handp_low)
nanmean(handp_low,2)
figure, plot(ans, 'or')
nanmean(handp_high, 2)
hold onplot(ans, 'ob')
hold on
plot(ans, 'ob')
nanmean(handp_low, 1)
figure, plot(ans, 'or')
nanmean(handp_high, 1)
hold on
plot(ans, 'ob')
basal_dynamic = squeeze(dynamicArray(1:4, 1, :))
mean(basal_dynamic)
handp_basaldynamic = handp(:, 2)
plot(basal_dynamic, handp_basaldynamic)
plot(basal_dynamic, handp_basaldynamic, 'o')
figure, plot(basal_dynamic, handp_basaldynamic, 'o')
size(handp_basaldynamic)
figure, plot(basal_dynamic, handp_basaldynamic', 'o')
basal_dynamic
figure, plot(mean(basal_dynamic), handp_basaldynamic', 'o')
xlabel('questionnaires responses ownership')
ylabel('handposition in mm')
[r, p] = corrcoef(mean(basal_dynamic), handp_basaldynamic')
figure, plot(nanmean(basal_dynamic), handp_basaldynamic', 'o')
xlabel('questionnaires responses ownership')
ylabel('handposition in mm')
[r, p] = corrcoef(nanmean(basal_dynamic), handp_basaldynamic')
close all
for i = 1:12