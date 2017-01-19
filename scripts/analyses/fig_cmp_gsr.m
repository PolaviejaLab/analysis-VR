function [] = fig_cmp_gsr (vect1, vect2, c1, c2, cond1, cond2)

c = parula;
c = c(1:2:64,:);

fig = figure,
set(fig, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
subplot('Position', [0.13, 0.15, 0.77, 0.75]); hold on;
p(1) = plot(mean(vect1,2), 'Color', c(c1,:) , 'linewidth', 2); hold on
plot(std(vect1,1,2)/sqrt(20)+mean(vect1,2), 'Color', c(c1,:) , 'linewidth', 1)
plot(-std(vect1,1,2)/sqrt(20)+mean(vect1,2), 'Color', c(c1,:) , 'linewidth', 1)
p(2) = plot(mean(vect2,2), 'Color', c(18,:), 'linewidth', 2);
plot(std(vect2,1,2)/sqrt(20)+mean(vect2,2), 'Color', c(c2,:) , 'linewidth', 1)
plot(-std(vect2,1,2)/sqrt(20)+mean(vect2,2), 'Color', c(c2,:) , 'linewidth', 1)
line([50 50], [-5 25], 'LineStyle', ':', 'Color', [215/255 215/255 215/255])
title('SCR response', 'fontweight', 'bold');
xlabel('Time to threat')
legend(p, {cond1, cond2}, 'Location', 'Northwest', ...
    'Fontsize', 8, 'FontWeight', 'bold');
set(gca, 'XTick', 0:10:100, 'XTickLabel', -5:1:5)
xlabel('Time to threat [s]');
box on;

end



