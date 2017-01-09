%% add paths

addpath('..\getData\');
addpath('..\analyses\');


%% get the data
config; [~, cube_firstpilots] = get_data_pilots (); % first Pilots

[cube_ar_inverted, ~] = get_data_ar (); % Ar Event
[cube_ar] = invertLScube (cube_ar_inverted); % Inverted the scale


%% auxiliar variables
q_ownership = 1:4;
q_agency = 7:9;

conditions = [1 3 4 6];

q_own_ar = 1:2;
q_agn_ar = 3:4;

cond_nonoise_nooffset_Ar = 1;
cond_noise_nooffset_Ar = 2; 
cond_nonoise_offset_Ar = 3;


%% 
axis_fontsize = 13;
title_fontsize = 17;

line_width = 3;


%% matrices with the results
owAr = cube_ar(:, q_own_ar, :);
agAr = cube_ar(:, q_agn_ar, :);

mat_ownership_Ar = squeeze(mean(owAr, 2));
mat_agency_Ar = squeeze(mean(agAr, 2));


%% real matrices 
own_nogap_nonoise = mean(squeeze(cube_firstpilots(q_ownership, 1, :)));
own_nogap_nonoise_Ar = mat_ownership_Ar(cond_nonoise_offset_Ar, :);
own_nogap_noise = mean(squeeze(cube_firstpilots(q_ownership, 3, :)));
own_nogap_noise_Ar = mat_ownership_Ar(cond_noise_nooffset_Ar, :);
own_gap_nonoise = mean(squeeze(cube_firstpilots(q_ownership, 4, :)));
own_gap_noise = mean(squeeze(cube_firstpilots(q_ownership, 6, :)));

agn_nogap_nonoise = mean(squeeze(cube_firstpilots(q_agency, 1, :)));
agn_nogap_nonoise_Ar = mat_agency_Ar(cond_nonoise_offset_Ar, :);
agn_nogap_noise = mean(squeeze(cube_firstpilots(q_agency, 3, :)));
agn_nogap_noise_Ar = mat_agency_Ar(cond_noise_nooffset_Ar, :);
agn_gap_nonoise = mean(squeeze(cube_firstpilots(q_agency, 4, :)));
agn_gap_noise = mean(squeeze(cube_firstpilots(q_agency, 6, :)));


%% Bootstrapping

ii = 10000;

% Diferences means
diff_means_own = [...
    mean(own_nogap_nonoise) - mean(own_gap_nonoise); ... %% Gap
    mean(own_nogap_nonoise_Ar) - mean(own_nogap_noise_Ar); %% Noise
    ];

diff_means_agn = [...
    mean(agn_nogap_nonoise) - mean(agn_gap_nonoise); %% Gap
    mean(agn_nogap_nonoise_Ar) - mean(agn_nogap_noise_Ar); %% noise
    ];

%Vectors
vec_own_intown = [own_nogap_nonoise, own_gap_nonoise];
vec_own_intagn = [own_nogap_nonoise_Ar, own_nogap_noise_Ar];

mat_own = [...
    vec_own_intown;
    vec_own_intagn];

vec_agn_intown = [agn_nogap_nonoise, own_gap_nonoise];
vec_agn_intagn = [own_nogap_nonoise_Ar, own_nogap_noise_Ar];

mat_agn = [...
    vec_agn_intown; 
    vec_agn_intagn];

% aux vectors
compmat_own = repmat(diff_means_own, 1, ii);
compmat_agn = repmat(diff_means_agn, 1, ii);

resmat_own = zeros (2, ii);
resmat_agn = zeros (2, ii);

for i = 1:ii
    i_perm = randperm(length(vec_own_intown));
    for  j = 1:2
        permmat_own = mat_own(j, i_perm);
        permmat_agn = mat_agn(j, i_perm);
        
        resmat_own(j, i) = mean(permmat_own(1:19)) - mean(permmat_own(20:38));
        resmat_agn(j, i) = mean(permmat_agn(1:19)) - mean(permmat_own(20:38));
        
    end
end

pval_own = sum(resmat_own >= compmat_own, 2)/ii;
pval_agn = sum(resmat_agn >= compmat_agn, 2)/ii;


%% better plot 

c = parula;
c  =  c([1 6 11 16 42 47 52 57], :);

edge = 1:1:7;
h1 = hist(own_nogap_nonoise, edge);
hh1 = hist(own_nogap_nonoise_Ar, edge);
h2 = hist(own_nogap_noise, edge);
hh2 = hist(own_nogap_noise_Ar, edge);
h3 = hist(own_gap_nonoise, edge);
h4 = hist(own_gap_noise,edge);


h5 = hist(agn_nogap_nonoise, edge);
hh5 = hist(agn_nogap_nonoise_Ar, edge);
h6 = hist(agn_nogap_noise, edge);
hh6 = hist(agn_nogap_noise_Ar, edge);
h7 = hist(agn_gap_nonoise, edge);
h8 = hist(agn_gap_noise, edge);

fig1 = figure(1);

subplot(2, 2, 1)
plot(edge, h1/19, 'color', c(8, :), 'LineWidth', line_width); hold on,
plot(edge, h3/19, 'color', c(6, :), 'LineWidth', line_width); 
hold off, 

xlim([0.5 7.5]);
ylim([-0.025 0.66]);
% xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

title('interfering with ownership', 'FontSize', title_fontsize, 'FontWeight', 'bold');
line([mean(own_nogap_nonoise), mean(own_nogap_nonoise)], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(8, :));
line([mean(own_gap_nonoise), mean(own_gap_nonoise)], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(6, :));

line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

legend({'no gap', 'gap'}, 'location', 'northwest');

text(0.75, 0.4, strcat('p =', num2str(pval_own(1), '%.3f')), 'FontSize', 12, 'color', c(6,:));

 
subplot(2, 2, 2)
plot(edge, hh1/19, 'color', c(8, :), 'LineWidth', line_width); hold on, 
plot(edge, hh2/19, 'color', c(6, :), 'LineWidth', line_width);
hold off, 

title('interfering with agency', 'FontSize', title_fontsize, 'FontWeight', 'bold');
xlim([0.5 7.5]);
ylim([-0.025 0.65]);
% xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
% ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

line([mean(own_nogap_nonoise_Ar), mean(own_nogap_nonoise_Ar)], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(8, :));
line([mean(own_nogap_noise_Ar), mean(own_nogap_noise_Ar)], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(6, :))
line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

legend({'no noise', 'noise'}, 'location', 'northwest');

text(0.75, 0.4, strcat('p =', num2str(pval_own(2), '%.3f')), 'FontSize', 12, 'color', c(6,:));

subplot(2, 2, 3)
plot(edge, h5/19, 'color', c(1, :), 'LineWidth', line_width); hold on,
plot(edge, h7/19+0.01, 'color', c(3, :), 'LineWidth', line_width);
hold off, 

xlim([0.5 7.5]);
ylim([-0.025 0.66]);
xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

line([mean(agn_nogap_nonoise)-0.01, mean(agn_nogap_nonoise)-0.01], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(1, :));
line([mean(agn_gap_nonoise)+0.01, mean(agn_gap_nonoise)+0.01], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(3, :));
line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

legend({'no gap', 'gap'}, 'location', 'northwest');

text(0.75, 0.375, strcat('p =', num2str(pval_agn(1), '%.3f')), 'FontSize', 12, 'color', c(3,:));

subplot(2, 2, 4)
plot(edge, hh5/19, 'color', c(1, :), 'LineWidth', line_width); hold on, 
plot(edge, hh6/19, 'color', c(3, :), 'LineWidth', line_width); hold off, 

xlim([0.5 7.5]);
ylim([-0.025 0.65]);
xlabel('questionnaire responses', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
% ylabel('probability density', 'FontSize', axis_fontsize, 'FontWeight', 'bold');
set(gca, 'FontSize', 12, 'FontWeight', 'bold');

line([mean(agn_nogap_nonoise_Ar), mean(agn_nogap_nonoise_Ar)], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(1, :));
line([mean(agn_nogap_noise_Ar), mean(agn_nogap_noise_Ar)], [-0.1 0.7], ...
    'LineStyle', '-', 'color', c(3, :));
line([0 8],[0 0], 'LineStyle', ':', 'color', [211/256 211/256 211/256]);

legend({'no noise', 'noise'}, 'location', 'northwest');

text(0.75, 0.375, strcat('p =', num2str(pval_agn(2), '%.3f')), 'FontSize', 12, 'color', c(3,:));

set(fig1,'units','normalized', 'Position', [0.15 0.01 0.61 0.9])

