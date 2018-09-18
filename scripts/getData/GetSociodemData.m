function [subjectData] = GetSociodemData (input_array)
nParticipants = size(input_array, 1);

% changes according to new tables
gender_col = 1;
age_col = 2;
scholarity_col = 3;
gaming_col = 4;
VRusers_col = 5; 
handedness_col = 7;

% Gender data
gender_array = input_array(:, gender_col);
subjectData.nFemales = sum(gender_array);
subjectData.nMales = nParticipants - subjectData.nFemales;
subjectData.percFemale = sum(gender_array)/nParticipants * 100;

% age
age_array = input_array(:, age_col);
subjectData.Age.Mean = mean(age_array);
subjectData.Age.STD = std(age_array);

% scholarity
scholarity_array = input_array(:, scholarity_col);

% Gaming Experience
gaming_array = input_array(:, gaming_col);
subjectData.GameExp.UsuallyNot = numel(gaming_array(gaming_array == 1))/nParticipants * 100;
subjectData.GameExp.Seldom = numel(gaming_array(gaming_array == 2))/nParticipants * 100;
subjectData.GameExp.Month = numel(gaming_array(gaming_array == 3))/nParticipants * 100;
subjectData.GameExp.Week = numel(gaming_array(gaming_array == 4))/nParticipants * 100;
subjectData.GameExp.Day = numel(gaming_array(gaming_array == 5))/nParticipants * 100;

% Virtual Reality Use
VR_array = input_array(:, VRusers_col);
subjectData.VRUse.First = numel(VR_array(VR_array == 1))/nParticipants * 100;
subjectData.VRUse.Already = numel(VR_array(VR_array == 2))/nParticipants * 100;
subjectData.VRUse.Always = numel(VR_array(VR_array == 3))/nParticipants * 100;

% Handedness (EHI - Davis 1970)
handedness_array = input_array(:, handedness_col);
subjectData.EHI.Mean = mean(handedness_array);
subjectData.EHI.STD = std(handedness_array);

end