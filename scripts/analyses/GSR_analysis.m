%% Load data
load('..\..\data\mat_GSR.mat');
load('..\..\data\bit_for_Frontiers.mat');


%% Without normalizing through individuals. 
% Without normalizing
figure(1); clf; hold on;
plot(1:100, median(KOV, 2), 'k', 'LineWidth', 3);
plot(1:100, median(KOR, 2), 'r', 'LineWidth', 3);
plot(1:100, median(GAP, 2), 'g', 'LineWidth', 3); 
plot(1:100, median(NOI, 2), 'b', 'LineWidth', 3);
title('without normalization');
legend({'basal', 'on-real', 'gap', 'noise'});
hold off; box on;

% measure the amplitude -- base-to-peak measure
amp_kov = max(median(KOV(51:100, :), 2)) - mean(median(KOV(47:49, :), 2));
amp_kor = max(median(KOR(51:100, :), 2)) - mean(median(KOR(47:49, :), 2));
amp_gap = max(median(GAP(51:100, :), 2)) - mean(median(GAP(47:49, :), 2));
amp_noi = max(median(NOI(51:100, :), 2)) - mean(median(NOI(47:49, :), 2));


%%
% Normalizing the values compared to the median of the 50 frames
% aux = zeros(100, 20);

for i = 1:size(KOR, 1)
    for j = 1:size(KOR, 2)
        base_kor = mean(KOR(1:50, j));
        base_kov = mean(KOV(1:50, j));
        base_gap = mean(GAP(1:50, j));
        base_noi = mean(NOI(1:50, j));
    
        aux_kor(i, j) = KOR(i, j) / base_kor;
        aux_kov(i, j) = KOV(i, j) / base_kov;
        aux_gap(i, j) = GAP(i, j) / base_gap;
        aux_noi(i, j) = NOI(i, j) / base_noi;

    end
end

figure(3); clf; hold on;
plot(1:100, median(aux_kov, 2), 'k', 'LineWidth', 3);
plot(1:100, median(aux_kor, 2), 'r', 'LineWidth', 3);
plot(1:100, median(aux_gap, 2), 'g', 'LineWidth', 3);
plot(1:100, median(aux_noi, 2), 'b', 'LineWidth', 3);
title('norm with the 50first frames of condition (w. mean)')
legend({'basal', 'on-real', 'gap', 'noise'}, 'Location', 'Northwest');
hold off; box on;


%% 
% figure, plot(1:100, aux_gap), hold on, plot(median(aux_gap, 2), 'LineWidth', 4), title('gap'), ylim([-0.5 2.5]);
% figure, plot(1:100, aux_noi), hold on, plot(median(aux_noi, 2), 'LineWidth', 4), title('noise'), ylim([-0.5 2.5]);
% figure, plot(1:100, aux_kor), hold on, plot(median(aux_kor, 2), 'LineWidth', 4), title('on real'), ylim([-0.5 2.5]);
% figure, plot(1:100, aux_kov), hold on, plot(median(aux_kov, 2), 'LineWidth', 4), title('basal'), ylim([-0.5 2.5]);


%%
% Normalizing the values compared to the median of the 1 frame
% aux = zeros(100, 20);

for i = 1:size(KOR, 1)
    for j = 1:size(KOR, 2)
        base_kor = KOR(1, j);
        base_kov = KOV(1, j);
        base_gap = GAP(1, j);
        base_noi = NOI(1, j);
    
        aux_kor(i, j) = KOR(i, j) / base_kor;
        aux_kov(i, j) = KOV(i, j) / base_kov;
        aux_gap(i, j) = GAP(i, j) / base_gap;
        aux_noi(i, j) = NOI(i, j) / base_noi;

    end
end


figure(4); clf; hold on;
plot(1:100, median(aux_kov, 2), 'k', 'LineWidth', 3);
plot(1:100, median(aux_kor, 2), 'r', 'LineWidth', 3);
plot(1:100, median(aux_gap, 2), 'g', 'LineWidth', 3);
plot(1:100, median(aux_noi, 2), 'b', 'LineWidth', 3);
title('norm with the first frame of condition')
legend({'basal', 'on-real', 'gap', 'noise'});
hold off; box on;


%% 
% figure, plot(1:100, aux_gap), hold on, plot(median(aux_gap, 2), 'LineWidth', 4), title('gap'), ylim([-0.5 2.5]);
% figure, plot(1:100, aux_noi), hold on, plot(median(aux_noi, 2), 'LineWidth', 4), title('noise'), ylim([-0.5 2.5]);
% figure, plot(1:100, aux_kor), hold on, plot(median(aux_kor, 2), 'LineWidth', 4), title('on real'), ylim([-0.5 2.5]);
% figure, plot(1:100, aux_kov), hold on, plot(median(aux_kov, 2), 'LineWidth', 4), title('basal'), ylim([-0.5 2.5]);


%%
% %  Normalizing compared to the whole 100 frames of basal condition
% figure(2); clf; hold on;
% plot(1:100, median((KOV ./ KOV), 2), 'k', 'LineWidth', 3);
% plot(1:100, median((KOR ./ KOV), 2), 'r', 'LineWidth', 3);
% plot(1:100, median((GAP ./ KOV), 2), 'g', 'LineWidth', 3); 
% plot(1:100, median((NOI ./ KOV), 2), 'b', 'LineWidth', 3);
% title('normalizing compared to the 100s of basal')
% legend({'basal', 'on-real', 'gap', 'noise'});
% hold off; box on;

