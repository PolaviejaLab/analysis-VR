vec_local = 0:0.001:1;
vec_outcome = 0:0.001:1;

vec_local2 = 1./(1+exp(-vec_outcome*2));

mattrial_1 = zeros(length(vec_local), length(vec_outcome));
mattrial_2 = zeros(length(vec_local), length(vec_outcome));
mattrial_3 = zeros(length(vec_local), length(vec_outcome));

for i = 1:length(vec_local)
    for ii = 1:length(vec_outcome)
        mattrial_1(ii, i) = vec_local(i) + vec_outcome(ii);
        mattrial_2(ii, i) = vec_local(i) + 2 * vec_outcome(ii);
        mattrial_3(ii, i) = vec_local2(i) + vec_outcome(ii);
%         mattrial_3(i, ii) = + 1/(1 + exp(10-1*(3*v1(i)+ v22(ii)))) ;
%         mattrial_3(i, ii) = v2(ii) + 1/(exp(-v1(i)));
%         mattrial_3(i, ii) = 2 * v2(ii) + 1/(1 + exp(-v1(i)));
    end
end

fig1 = figure(1);

axis([0 1 0 1]);

colormap jet;
subplot('Position', [0.05 0.2 0.22 0.6])
imagesc(mattrial_1)
set(gca,'YDir','normal', 'XTickLabel', {''}, 'YTickLabel', {''});
xlabel('agency over movement', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('agency over consequences', 'FontSize', 11, 'FontWeight', 'bold');
title('model 1', 'FontSize', 13, 'FontWeight', 'bold');

subplot('Position', [0.4 0.2 0.22 0.6])
imagesc(mattrial_2)
set(gca,'YDir','normal', 'XTickLabel', {''}, 'YTickLabel', {''});
xlabel('agency over movement', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('agency over consequences', 'FontSize', 11, 'FontWeight', 'bold');
title('model 2', 'FontSize', 13, 'FontWeight', 'bold');

subplot('Position', [0.75 0.2 0.22 0.6])
imagesc(mattrial_3)
set(gca,'YDir','normal', 'XTickLabel', {''}, 'YTickLabel', {''});
xlabel('agency over movement', 'FontSize', 11, 'FontWeight', 'bold');
ylabel('agency over consequences', 'FontSize', 11, 'FontWeight', 'bold');
title('model 3', 'FontSize', 13, 'FontWeight', 'bold');
% colorbar;

set(fig1, 'units', 'centimeters', 'Position', [5 5 18.0 8.0]);