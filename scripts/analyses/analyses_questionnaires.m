%% get the data

addpath('..\getData\');
addpath('..\figures\');
[stat_array, dyn_array] = get_data (1);


%% Declare Question Number
nOwnership = 1:4;
nSimilar = 5;

nControlOw_static = 6:7;
nLocation_static = 8;

nControlOw_dynamic = 6;
nAgency = 7:9;

nControlAg = 10:12;
nLocation_dynamic = 13:14;

nParticipants = size(stat_array, 3);
ii = 10000;     % number of iterations
jj = 4;         % number of comparisions - dynamic

%% Static
mat_stat_own = [...
    mean(squeeze(stat_array(nOwnership, 1, :))); % no gap
    mean(squeeze(stat_array(nOwnership, 2, :))); % gap
    ];

mn_stat_own = [...
    mean(mat_stat_own(1, :));
    mean(mat_stat_own(2, :));
    ];

% md_stat_own = [...
%     median(mat_stat_own(1, :));
%     median(mat_stat_own(2, :));
%     ];

std_stat_own = [...
    std(mat_stat_own(1, :));
    std(mat_stat_own(2, :));
    ];

diffmn_stat = mn_stat_own(1, :) - mn_stat_own(2, :);

vec_comp =  repmat(diffmn_stat, 1, ii);

vec_perm = [mat_stat_own(1, :) mat_stat_own(2, :)];

vec_res = zeros(1, ii);

for i = 1:ii
    i_rand = randperm(length(vec_perm));
    aux = vec_perm(i_rand);
    
    vec_res(i) = mean(aux(1:20)) - mean(aux(21:40));       
end 

pval_stat = sum(vec_res > vec_comp, 2)/ii;

[h_stat, pks_stat] = kstest2 (mat_stat_own(1, :), mat_stat_own(2, :));

fig1 = figure(1); clf;
legend_font = 12;
axis_font = 16;
title_font = 18;
fig_distributions(mat_stat_own(1, :), mat_stat_own(2, :), 2, 9, ...
    nParticipants, mn_stat_own(1, :), mn_stat_own(2, :), axis_font, ...
    pval_stat, pks_stat);
title('static block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'no gap', 'gap'}, 'location', 'northwest', 'FontSize', legend_font);
set(fig1,'units','normalized', 'Position', [0.15 0 0.48 0.75]);


%% Dynamic - ownership

mat_dyn_own = [... % mean per subject
    mean(squeeze(dyn_array(nOwnership, 1, :))); % control
    mean(squeeze(dyn_array(nOwnership, 2, :))); % offset = 10 cm
    mean(squeeze(dyn_array(nOwnership, 3, :))); % knife on real
    mean(squeeze(dyn_array(nOwnership, 4, :))); % gap
    mean(squeeze(dyn_array(nOwnership, 5, :))); % noise
    ];

mn_dyn_own = [...
    mean(mat_dyn_own(1, :)); % control
    mean(mat_dyn_own(2, :)); % offset = 10 cm
    mean(mat_dyn_own(3, :)); % knife on real
    mean(mat_dyn_own(4, :)); % gap
    mean(mat_dyn_own(5, :)); % noise
    ];

std_dyn_own = [...
    std(mat_dyn_own(1, :)); % control
    std(mat_dyn_own(2, :)); % offset = 10 cm
    std(mat_dyn_own(3, :)); % knife on real
    std(mat_dyn_own(4, :)); % gap
    std(mat_dyn_own(5, :)); % noise
    ];

diffmn_own = [...
    mn_dyn_own(2, :) -  mn_dyn_own(1, :); % offset - control;
    mn_dyn_own(2, :) -  mn_dyn_own(3, :); % offset - onreal;
    mn_dyn_own(2, :) -  mn_dyn_own(4, :); % offset - gap;
    mn_dyn_own(2, :) -  mn_dyn_own(5, :); % offset - noise;
    ];

mat_comp = repmat(diffmn_own, 1, ii);

mat_perm = [...
    mat_dyn_own(2, :) mat_dyn_own(1, :); % offset - control;
    mat_dyn_own(2, :) mat_dyn_own(3, :); % offset - onreal;
    mat_dyn_own(2, :) mat_dyn_own(4, :); % offset - gap;
    mat_dyn_own(2, :) mat_dyn_own(5, :); % offset - noise;
    ];

mat_res = zeros (jj, ii);

for i = 1:ii
    i_rand = randperm(length(mat_perm(1, :)));
      
    for j = 1:jj  
        aux_vec = mat_perm(j, i_rand);
        mat_res(j, i) = mean(aux_vec(1:20)) - mean(aux_vec(21:40));   
    end
    
end 

pval_dyn_own = sum(mat_res > mat_comp, 2)/ii;

[h1_ow, p1_ow] = kstest2 (mat_dyn_own(2, :), mat_dyn_own(1, :));
[h2_ow, p2_ow] = kstest2 (mat_dyn_own(2, :), mat_dyn_own(3, :));
[h3_ow, p3_ow] = kstest2 (mat_dyn_own(2, :), mat_dyn_own(4, :));
[h4_ow, p4_ow] = kstest2 (mat_dyn_own(2, :), mat_dyn_own(5, :));


fig2 = figure(2); clf;
legend_font = 11;
axis_font = 12;
title_font = 14;
subplot(2, 2, 1);
fig_distributions(mat_dyn_own(2, :), mat_dyn_own(1, :), 2, 5, ...
    nParticipants, mn_dyn_own(2, :), mn_dyn_own(1, :), ...
    axis_font, pval_dyn_own(1), p1_ow);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'no offset'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 2);
fig_distributions(mat_dyn_own(2, :), mat_dyn_own(3, :), 2, 7, ...
    nParticipants, mn_dyn_own(2, :), mn_dyn_own(3, :), ...
    axis_font, pval_dyn_own(2), p2_ow);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'knife on real'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 3);
fig_distributions(mat_dyn_own (2, :), mat_dyn_own (4, :), 2, 9, ...
    nParticipants, mn_dyn_own(2, :), mn_dyn_own(4, :), ...
    axis_font, pval_dyn_own(3), p3_ow);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'gap'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 4);
fig_distributions(mat_dyn_own(2, :), mat_dyn_own(5, :), 2, 11, ...
    nParticipants, mn_dyn_own(2, :), mn_dyn_own(5, :), ...
    axis_font, pval_dyn_own(4), p4_ow);
title('dynamic block - ownership', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'noise'}, 'location', 'northwest', 'FontSize', legend_font);

set(fig2,'units','normalized', 'Position', [0.15 0 0.61 0.93]);


%% Dynamic - agency

mat_dyn_agn = [... % mean per subject
    mean(squeeze(dyn_array(nAgency, 1, :))); % control
    mean(squeeze(dyn_array(nAgency, 2, :))); % offset = 10 cm
    mean(squeeze(dyn_array(nAgency, 3, :))); % knife on real
    mean(squeeze(dyn_array(nAgency, 4, :))); % gap
    mean(squeeze(dyn_array(nAgency, 5, :))); % noise
    ];

mn_dyn_agn = [...
    mean(mat_dyn_agn(1, :)); % control
    mean(mat_dyn_agn(2, :)); % offset = 10 cm
    mean(mat_dyn_agn(3, :)); % knife on real
    mean(mat_dyn_agn(4, :)); % gap
    mean(mat_dyn_agn(5, :)); % noise
    ];

std_dyn_agn = [...
    std(mat_dyn_agn(1, :)); % control
    std(mat_dyn_agn(2, :)); % offset = 10 cm
    std(mat_dyn_agn(3, :)); % knife on real
    std(mat_dyn_agn(4, :)); % gap
    std(mat_dyn_agn(5, :)); % noise
    ];

diffmn_agn = [...
    mn_dyn_agn(2, :) -  mn_dyn_agn(1, :); % offset - control;
    mn_dyn_agn(2, :) -  mn_dyn_agn(3, :); % offset - onreal;
    mn_dyn_agn(2, :) -  mn_dyn_agn(4, :); % offset - gap;
    mn_dyn_agn(2, :) -  mn_dyn_agn(5, :); % offset - noise;
    ];

mat_comp = repmat(diffmn_agn, 1, ii);

mat_perm = [...
    mat_dyn_agn(2, :) mat_dyn_agn(1, :); % offset - control;
    mat_dyn_agn(2, :) mat_dyn_agn(3, :); % offset - onreal;
    mat_dyn_agn(2, :) mat_dyn_agn(4, :); % offset - gap;
    mat_dyn_agn(2, :) mat_dyn_agn(5, :); % offset - noise;
    ];

mat_res = zeros (jj, ii);

for i = 1:ii
    i_rand = randperm(length(mat_perm(1, :)));
    
    
    for j = 1:jj  
        aux_vec = mat_perm(j, i_rand);
        mat_res(j, i) = mean(aux_vec(1:20)) - mean(aux_vec(21:40));   
    end
    
end 

pval_dyn_agn = sum(mat_res > mat_comp, 2)/ii;

[h1_ag, p1_ag] = kstest2 (mat_dyn_agn(2, :), mat_dyn_agn(1, :));
[h2_ag, p2_ag] = kstest2 (mat_dyn_agn(2, :), mat_dyn_agn(3, :));
[h3_ag, p3_ag] = kstest2 (mat_dyn_agn(2, :), mat_dyn_agn(4, :));
[h4_ag, p4_ag] = kstest2 (mat_dyn_agn(2, :), mat_dyn_agn(5, :));


fig3 = figure(3); clf;
legend_font = 11;
axis_font = 12;
title_font = 14;
subplot(2, 2, 1);
fig_distributions(mat_dyn_agn(2, :), mat_dyn_agn (1, :), 2, 5, ...
    nParticipants, mn_dyn_agn(2, :), mn_dyn_agn (1, :), ...
    axis_font, pval_dyn_agn(1), p1_ag);
title('dynamic block - agency', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'no offset'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 2);
fig_distributions(mat_dyn_agn (2, :), mat_dyn_agn (3, :), 2, 7, ...
    nParticipants, mn_dyn_agn(2, :), mn_dyn_agn(3, :), ...
    axis_font, pval_dyn_agn(2), p2_ag);
title('dynamic block - agency', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'knife on real'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 3);
fig_distributions(mat_dyn_agn (2, :), mat_dyn_agn (4, :), 2, 9, ...
    nParticipants, mn_dyn_agn(2, :), mn_dyn_agn(4, :), ...
    axis_font, pval_dyn_agn(3), p3_ag);
title('dynamic block - agency', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'gap'}, 'location', 'northwest', 'FontSize', legend_font);

subplot(2, 2, 4);
fig_distributions(mat_dyn_agn (2, :), mat_dyn_agn (5, :), 2, 11, ...
    nParticipants, mn_dyn_agn(2, :), mn_dyn_agn(5, :), ...
    axis_font, pval_dyn_agn(4), p4_ag);
title('dynamic block - agency', 'FontSize', title_font, 'FontWeight', 'bold');
legend({'control', 'noise'}, 'location', 'northwest', 'FontSize', legend_font);

set(fig3,'units','normalized', 'Position', [0.15 0 0.61 0.93]);