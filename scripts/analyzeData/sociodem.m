dataDirectory = 'V:\Data\04. Exp1_Frontiers\';
fileName = 'sociodemographic.txt';

sociodem_table = table2array(readtable(fullfile(dataDirectory, fileName)));

% aux
gen_aux = 2;
age_aux = 3;

nParticipants = size(sociodem_table, 1);

% gender
gender_array = sociodem_table(:, gen_aux);
n_females = sum(gender_array);
perc_fem = n_females/nParticipants * 100;

% age
age_array = sociodem_table(:, age_aux);
mean_age = mean(age_array);

std_age = std(age_array);