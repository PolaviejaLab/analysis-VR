function [] = formatcorrelations (x_lim, y_lim, x_axis, y_axis, fontsize)

xlim(x_lim); ylim(y_lim);
xlabel(x_axis, 'FontSize', fontsize, 'FontWeight', 'bold');
ylabel(y_axis, 'FontSize', fontsize, 'FontWeight', 'bold');
end