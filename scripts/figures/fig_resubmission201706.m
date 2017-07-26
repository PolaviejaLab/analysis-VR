load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\handp.mat')
load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\drift.mat')

load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\arrays_agndyn.mat')
load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\arrays_ownstat.mat')
load('E:\GitHub\analysis-VR\data\1. IndividualityInOwnership\arrays_owndyn.mat')
%% Create colormap
c = parula;
c = c(1:2:64,:); 

c_o = 6;
c_a = 20;
%% Figure - hand and drift 
fig = figure(1); clf, hold on,
set(fig, 'units', 'centimeters', 'position', [5 5 8.5 8.5]);

p(1) = plot(nanmean(handp * 100), '.', 'markersize', 22);
p(2) = plot(nanmean(drift * 100), '.', 'markersize', 22);
hold off, box on,

xlim([0.5 6.5]); 
set(p(1), 'color', c(5, :)); set(p(2), 'color', c(15, :));

title('Real and hand position', 'fontweight', 'bold');
legend([p(1), p(2)], {'Real hand position', 'Perceived hand position'});
set(gca, 'XTickLabel', {'Habituation', 'No displacement', 'Full arm dynamic', ...
    'Knife to real hand', 'Detached arm', 'Noise'});
ylabel('Position [cm]');


%% Figure - SCR


%% Figure boxplot and distributions
fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 18.0 9.0]); 


subplot('Position', [0.1, 0.1, 0.15, 0.8]); hold on;
boxplot([own_dyn_control(:), own_dyn_noise(:)], 'color', 'k'); 
hold off; box on;
ylim([0.5, 8])
text(1, 0, 'full arm arm dynamic', 'fontname', 'arial');
text(2, 0, 'noise dynamic', 'fontname', 'arial');

line([3 3], [0 8], 'color', 'k'); 
% line([1 2], [6.5 6.5], 'Color', 'black'); text(1.5, 6.65, '*', ...
%     'FontWeight', 'bold', 'FontSize', 14); 
% xlim([0.5 2.5]); ylim([0.9 7.15]);
set(gca, 'XTick', [], 'XTickLabel', {'', ''}, 'YTick', 1:1:7, 'Fontsize', 9);
% title('Sense of ownership', 'FontWeight', 'bold');

edge = 1:7;
subplot('Position', [0.44, 0.1, 0.4, 0.8]); hold on;
line([4 4], [0 8], 'color', [220/255 220/255 220/255], 'LineStyle', ':', ...
    'LineWidth', 1.5); 
p_1(1) = plot(edge, hist(own_dyn_control(:), edge)/numel(own_dyn_control), ...
    'color', c(c_o, :), 'LineWidth', 3); 
p_1(2) = plot(edge, hist(own_dyn_noise(:), edge)/numel(own_dyn_noise), ...
    'color', c(c_o - 5, :), 'LineWidth', 3); 
line([mean(own_dyn_control(:)), mean(own_dyn_control(:))], [-0.1 1.1], ...
    'color', c(c_o, :));
line([mean(own_dyn_noise(:)), mean(own_dyn_noise(:))], [-0.1 1.1], ...
    'color', c(c_o - 5, :));
hold off; box on;

ylim([0 0.5]); xlim([0.9 7.15]); 
ylabel('Probability density', 'fontname', 'arial');
xlabel('Responses to questionnaires', 'fontname', 'arial'); 
set(gca, 'YTick', 0.1:0.1:0.5, ...
    'YTickLabel', {'0.1', '0.2', '0.3', '0.4', ''}, ...
    'Fontsize', 8, 'fontname', 'arial');
set(gca, 'XTick', 1:1:7, 'XTickLabel', 1:7, 'FontSize', 8, 'fontname', 'arial'); 

legend(p_1, {'Full arm dynamic', 'Noise dynamic'}, 'Location', 'Northwest', ...
    'Fontsize', 8, 'FontWeight', 'bold', 'fontname', 'arial');
