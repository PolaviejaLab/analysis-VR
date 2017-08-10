function [fig3] = plotCorrelations ...
    (data1, data2, plot_title, plot_xlabel, plot_ylabel, pearsonr, pval)



fig3 = figure(3); clf, hold on,
line([1 7], [1 7], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]);
line([1 1], [0 1], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]); 
line([0 1], [1 1], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]);
line([3 3], [0 3], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]); 
line([0 3], [3 3], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]);
line([5 5], [0 5], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]); 
line([0 5], [5 5], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]);
line([7 7], [0 7], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]); 
line([0 7], [7 7], 'LineStyle', ':', 'Color', [200/255, 200/255, 200/255]);

plot(nanmean(data1), nanmean(data2), '.k', 'MarkerSize', 20); hold on

if (pval < 0.001)
    text(1,6, 'p<0.001', 'fontname', 'arial');
elseif (pval < 0.05)
    pval = round(pval*1000)/1000;
    text(1, 6, strcat('p= ', num2str(pval)), 'fontname', 'arial');
else 
    pval = round(pval * 100)/100;
    text(1, 6, strcat('p= ', num2str(pval)), 'fontname', 'arial');
end

pearsonr = round(pearsonr*1000)/1000;
text(1, 6.5, strcat('r= ', num2str(pearsonr)), 'fontname', 'arial');


xlim([0.5 7.5]); ylim([0.5 7.5]);
title(plot_title, 'fontname', 'arial');
xlabel(plot_xlabel, 'fontname', 'arial');
ylabel(plot_ylabel, 'fontname', 'arial');
hold off, box on;


end 