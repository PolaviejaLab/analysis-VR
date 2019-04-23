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
subjectData.Age.All = age_array;
subjectData.Age.Mean = mean(age_array);
subjectData.Age.STD = std(age_array);

% scholarity
scholarity_array = input_array(:, scholarity_col);

% Gaming Experience
gaming_array = input_array(:, gaming_col);

subjectData.GameExp.UsuallyNot = find(gaming_array == 1);
subjectData.GameExp.Seldom = find(gaming_array == 2);
subjectData.GameExp.Month = find(gaming_array == 3);
subjectData.GameExp.Week = find(gaming_array == 4);
subjectData.GameExp.Day = find(gaming_array == 5);
subjectData.GameExp.Percentage = [...
    numel(gaming_array(gaming_array == 1))/nParticipants * 100;
    numel(gaming_array(gaming_array == 2))/nParticipants * 100;
    numel(gaming_array(gaming_array == 3))/nParticipants * 100;
    numel(gaming_array(gaming_array == 4))/nParticipants * 100;
    numel(gaming_array(gaming_array == 5))/nParticipants * 100;
    ];

% Virtual Reality Use
VR_array = input_array(:, VRusers_col);

subjectData.VRUse.First = find(VR_array == 1);
subjectData.VRUse.Already = find(VR_array == 2);
subjectData.VRUse.Always = find(VR_array == 3);

subjectData.VRUse.Percentage = [...
    numel(VR_array(VR_array == 1))/nParticipants * 100;
    numel(VR_array(VR_array == 2))/nParticipants * 100;
    numel(VR_array(VR_array == 3))/nParticipants * 100;
    ];


% Handedness (EHI - Davis 1970)
handedness_array = input_array(:, handedness_col);
subjectData.EHI.Mean = mean(handedness_array);
subjectData.EHI.STD = std(handedness_array);

end