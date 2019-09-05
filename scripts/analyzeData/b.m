fig2 = figure(2); clf;
set(fig2, 'units', 'centimeters', 'position', [5 5 9.0 9.0]);
c = parula;
c = c(1:2:64,:);
line([50 50],[-5  25], 'color', 'red', 'linestyle', ':')
p(1) = plot(mean(cond1_norm,2),'color', c(5,:) , 'linewidth', 2), hold on
plot(std(cond1_norm,1,2)/sqrt(20)+mean(cond1_norm,2), 'color', c(5,:) , 'linewidth', 1)
plot(-std(cond1_norm,1,2)/sqrt(20)+mean(cond1_norm,2), 'color', c(5,:), 'linewidth', 1)
p(2) = plot(mean(cond2_norm,2),'color', c(13,:) , 'linewidth', 2)
plot(std(cond2_norm,1,2)/sqrt(20)+mean(cond2_norm,2), 'color', c(13,:), 'linewidth', 1)
plot(-std(cond2_norm,1,2)/sqrt(20)+mean(cond2_norm,2), 'color', c(13,:), 'linewidth', 1)
p(3) = plot(mean(cond3_norm,2),'color', c(21,:) , 'linewidth', 2)
plot(std(cond3_norm,1,2)/sqrt(20)+mean(cond3_norm,2), 'color', c(21,:), 'linewidth', 1)
plot(-std(cond3_norm,1,2)/sqrt(20)+mean(cond3_norm,2), 'color', c(21,:), 'linewidth', 1)
p(4) = plot(mean(cond4_norm,2),'color', c(29,:) , 'linewidth', 2)
plot(std(cond4_norm,1,2)/sqrt(20)+mean(cond4_norm,2), 'color', c(29,:), 'linewidth', 1)
plot(-std(cond4_norm,1,2)/sqrt(20)+mean(cond4_norm,2), 'color', c(29,:), 'linewidth', 1)
title('SCR response', 'fontweight', 'bold')
set(gca, 'XTick', 0:10:100, 'XTickLabel', -50:10:50)
set(gca, 'XTick', 10:10:100, 'XTickLabel', -40:10:50)
xlabel('Time to threat')
legend(p, {'basal dynamic', 'on real', 'discontinuous dynamic', 'noise'}, 'location', 'northwest')