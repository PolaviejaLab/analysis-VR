% SOCIODEM is a function that will read the sociodemographics text file and
% extract important information
% vecUsed is the vector of used participants (indicated with a 1 in the
% sociodemgraphics file).
% perFem will output the percetage of female participans
% meanAge will output the mean age of the participants that will be used in
% the analysis (by using vecUsed)
% stdAge ouputs the standart deviation of the age of the participants that
% will be used for the analysis (using vecUsed)
% sch_array is the array with the scholarity of the participants in order
% to group them afterwards
% gamArray is the vector with all the participants used for their analysis.
% 

function [vecUsed, perFem, meanAge, stdAge, sch_array, gameArray, vrArray] = sociodem (dataDirectory)

fileName = 'sociodemographics.txt';
sociodem_table = readtable(fullfile(dataDirectory, fileName));

% variables to indicate in which column each variable is found in the text
% file
used_aux = 8;
gen_aux = 3;
age_aux = 4;
sch_aux = 5;
game_aux = 6;
vr_aux = 7; 

nParticipants = size(sociodem_table, 1);

% vecUsed - will be used to remove the participants that we will exclude
% from the analysis
vecUsed = table2array(sociodem_table(:, used_aux));
vecUsed = find(vecUsed == 1);

% gender
gender_array = table2array(sociodem_table(vecUsed, gen_aux));
n_females = sum(gender_array);
perFem = n_females/length(vecUsed) * 100;

% age
age_array = table2array(sociodem_table(vecUsed, age_aux));
meanAge = mean(age_array);
stdAge = std(age_array);

% scholarity
sch_array = table2array(sociodem_table(vecUsed, sch_aux));

% gaming
gameArray = table2array(sociodem_table(vecUsed, game_aux));

% VR 
vrArray = table2array(sociodem_table(vecUsed, vr_aux));


end