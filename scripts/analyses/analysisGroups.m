load('..\..\data\arrays_ownstat.mat');
load('..\..\data\arrays_owndyn.mat');

addpath('..\statistics\');

% define the groups
statLow = find(mean(own_stat_nogap) <= 3);
statMed = find(mean(own_stat_nogap) > 3 & mean(own_stat_nogap) < 5);
statHig = find(mean(own_stat_nogap) >= 5);

dynLow = find(mean(own_dyn_control) <= 3);
dynMed = find(mean(own_dyn_control) > 3 & mean(own_dyn_control) < 5);
dynHig = find(mean(own_dyn_control) >= 5);

% ANALYSIS
it = 10000;

pval = [...
    stat_bygroups(it, statLow, statMed, statHig, own_stat_nogap, own_stat_gap), ...
    stat_bygroups(it, statLow, statMed, statHig, own_stat_nogap, own_dyn_control), ...
    stat_bygroups(it, statLow, statMed, statHig, own_stat_gap, own_dyn_gap), ...
    stat_bygroups(it, dynLow, dynMed, dynHig, own_dyn_control, own_dyn_gap), ...
    stat_bygroups(it, dynLow, dynMed, dynHig, own_dyn_control, own_dyn_noise), ...
    ];