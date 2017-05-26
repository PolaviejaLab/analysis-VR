% dynHig(dynHig == 10) = [];
% dynHig(dynHig == 21) = [];
% dynLow(dynLow == 10) = [];
% dynLow(dynLow == 21) = [];
% dynMed(dynMed == 10) = [];
% dynMed(dynMed == 21) = [];
% 
% for i = 1:size(dynHig, 2)
%     if (dynHig(i) > 10 && dynHig(i) <= 21)
%         dynHig(i) = dynHig(i) - 1;
%     end
%     if (dynHig(i) == 22) 
%         dynHig(i) = 20;
%     end
% end
% 
% for i = 1:size(dynLow, 2)
%     if (dynLow(i) > 10 && dynLow(i) <= 21)
%         dynLow(i) = dynLow(i) - 1;
%     end
%     if (dynLow(i) == 22) 
%         dynLow(i) = 20;
%     end
% end
% 
% for i = 1:size(dynMed, 2)
%     if (dynMed(i) > 10 && dynMed(i) <= 21)
%         dynMed(i) = dynMed(i) - 1;
%     end
%     if (dynMed(i) == 22) 
%         dynMed(i) = 20;
%     end
% end


% Divide GSR by conditions

% basal_low = cond1_norm(:, dynLow);
% basal_med = cond1_norm(:, dynMed);
% basal_hig = cond1_norm(:, dynHig);
% 
% onreal_low = cond2_norm(:, dynLow);
% onreal_med = cond2_norm(:, dynMed);
% onreal_hig = cond2_norm(:, dynHig);


% aux_ = dynLow(2:size(dynLow, 2)) - 1
% aux1_ = dynMed -1 
% aux3 = dynHig -1
% gap_low = cond3_norm(:, aux_);
% gap_med = cond3_norm(:, aux1_);
% gap_hig = cond3_norm(:, aux3);
% 
% dynHig(dynHig == 9) = []
% for i = 1:size(dynLow, 2)
%     if dynLow(i) >= 9 
%         dynLow(i) = dynLow(i) - 1;
%     end
% end
% for i = 1:size(dynMed, 2)
%     if dynMed(i) >= 9 
%         dynMed(i) = dynMed(i) - 1;
%     end
% end
% for i = 1:size(dynHig, 2)
%     if dynHig(i) >= 9 
%         dynHig(i) = dynHig(i) - 1;
%     end
% end
% 
% noise_low = cond4_norm(:, dynLow);
% noise_med = cond4_norm(:, dynMed);
% noise_hig = cond4_norm(:, dynHig);


figure
plot(mean(basal_hig,2), 'r', 'linewidth', 2), hold on
plot(std(basal_hig,1,2)/sqrt(19)+mean(basal_hig,2), 'r', 'linewidth', 1)
plot(-std(basal_hig,1,2)/sqrt(19)+mean(basal_hig,2), 'r', 'linewidth', 1)

plot(mean(gap_hig,2), 'b', 'linewidth', 2), hold on
plot(std(gap_hig,1,2)/sqrt(19)+mean(gap_hig,2), 'b', 'linewidth', 1)
plot(-std(gap_hig,1,2)/sqrt(19)+mean(gap_hig,2), 'b', 'linewidth', 1)

plot(mean(noise_hig,2), 'g', 'linewidth', 2), hold on
plot(std(noise_hig,1,2)/sqrt(19)+mean(noise_hig,2), 'g', 'linewidth', 1)
plot(-std(noise_hig,1,2)/sqrt(19)+mean(noise_hig,2), 'g', 'linewidth', 1)


figure
plot(mean(basal_low,2), 'r', 'linewidth', 2), hold on
plot(std(basal_low,1,2)/sqrt(19)+mean(basal_low,2), 'r', 'linewidth', 1)
plot(-std(basal_low,1,2)/sqrt(19)+mean(basal_low,2), 'r', 'linewidth', 1)

plot(mean(gap_low,2), 'b', 'linewidth', 2), hold on
plot(std(gap_low,1,2)/sqrt(19)+mean(gap_low,2), 'b', 'linewidth', 1)
plot(-std(gap_low,1,2)/sqrt(19)+mean(gap_low,2), 'b', 'linewidth', 1)

plot(mean(noise_low,2), 'g', 'linewidth', 2), hold on
plot(std(noise_low,1,2)/sqrt(19)+mean(noise_low,2), 'g', 'linewidth', 1)
plot(-std(noise_low,1,2)/sqrt(19)+mean(noise_low,2), 'g', 'linewidth', 1)


%% statistics

diffVec = abs(nanmean(gap_low,2) - nanmean(gap_hig,2));
res_vec = zeros(1, 10000);
p_val = zeros(1, 100);

for k = 1:100
    aux_vec = [gap_low(k, :), gap_hig(k, :)];
    cmp_vec = repmat(diffVec(k, 1), 1, 10000);
    for it = 1:10000
        i_rand = randperm(size(aux_vec, 2));
        randVec = aux_vec(1, i_rand);
        res_vec(1,it) = abs(nanmean(randVec(1:size(gap_low,2))) ...
            - nanmean(randVec(size(gap_low,2)+1:size(randVec,2)))); 
        
    end
    p_val(1,k) = sum(abs(res_vec) > cmp_vec, 2)/10000;
    
end 




