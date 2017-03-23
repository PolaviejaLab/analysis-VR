qo = 1:4;
qa = 7:9;
ql = 13:14;

iterations = 10000;

v_age = [21 24 24 19 55 18 20 60 49 60 29 29 60 45]; % all participants
participants = [1 2 3 4 5 6 7 8 10 11 12 13]; % participants that I was able to get the questionnaire data from

v_participants = v_age(participants); % ages of participants that had the questionnaire data available

hist(v_participants, 10); % plot age

% get from questionnaires
addpath('getData\'); addpath('statistics\');
[statArray, dynArray] = get_questionnaire_data();

