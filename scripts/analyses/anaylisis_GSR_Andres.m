addpath('..\statistics\');
load('..\..\data\GSR_nocond.mat');


%% Condition 1

% data=KOV; 
data=carlcox;

for i=1:20
    data(:,i)=data(:,i)-mean(data(1:50,i));
end
cond1_norm = data;
amp = mean(max(data(46:100, :)) - mean(data(42:44, :)))

amp_cmp = repmat(amp, 1, 10000);
amp_res = zeros(1, 10000);

for i = 1:10000
i_rand = randperm(size(data, 1));
vec_perm = data(i_rand,:);
amp_res(1, i) = mean(max(vec_perm(46:100, :)) - mean(vec_perm(42:44, :)));
end
pv = sum(abs(amp_res) > amp_cmp, 2)/10000

figure,plot(mean(data,2),'r' , 'linewidth', 2), hold on
plot(std(data,1,2)/sqrt(20)+mean(data,2), 'r', 'linewidth', 1)
plot(-std(data,1,2)/sqrt(20)+mean(data,2), 'r', 'linewidth', 1)

data_cum1 = data;
cum = 0;
for i_subj = 1:size(data_cum1, 2)
    for i_t = 50:size(data_cum1,1)
        data_cum1(i_t, i_subj) = data_cum1(i_t, i_subj) + cum;
        cum = data_cum1(i_t, i_subj);
    end 
    cum = 0;
end

%% Condition 2
% data=KOR;
data = mulero;

for i=1:20
    data(:,i)=data(:,i)-mean(data(1:50,i));
end
cond2_norm = data;
% amp = mean(mean(data(51:100, :))) - mean(mean(data(1:49, :)))
amp = mean(max(data(46:100, :)) - mean(data(42:44, :)))
amp_cmp = repmat(amp, 1, 10000);
amp_res = zeros(1, 10000);

for i = 1:10000
i_rand = randperm(size(data, 1));
vec_perm = data(i_rand,:);
amp_res(1, i) = mean(max(vec_perm(46:100, :)) - mean(vec_perm(42:44, :)));
end
pv = sum(abs(amp_res) > amp_cmp, 2)/10000

plot(mean(data,2), 'k', 'linewidth', 2)
plot(std(data,1,2)/sqrt(20)+mean(data,2), 'k', 'linewidth', 1)
plot(-std(data,1,2)/sqrt(20)+mean(data,2), 'k', 'linewidth', 1)


data_cum2 = data;
cum = 0;
for i_subj = 1:size(data_cum2, 2)
    for i_t = 50:size(data_cum2,1)
        data_cum2(i_t, i_subj) = data_cum2(i_t, i_subj) + cum;
        cum = data_cum2(i_t, i_subj);
    end 
    cum = 0;
end
%% Condition 3
% data=GAP(:,2:end);
data=pepo(:,2:end);

for i=1:19
    data(:,i)=data(:,i)-mean(data(1:50,i));
end
cond3_norm = data;

% Analysis of amplitude
% amp = mean(mean(data(51:100, :))) - mean(mean(data(1:49, :)))
amp = mean(max(data(46:100, :)) - mean(data(42:44, :)))
amp_cmp = repmat(amp, 1, 10000);
amp_res = zeros(1, 10000);

for i = 1:10000
i_rand = randperm(size(data, 1));
vec_perm = data(i_rand,:);
amp_res(1, i) = mean(max(vec_perm(46:100, :)) - mean(vec_perm(42:44, :)));
end
pv = sum(abs(amp_res) > amp_cmp, 2)/10000


plot(mean(data,2), 'b', 'linewidth', 2)
plot(std(data,1,2)/sqrt(19)+mean(data,2), 'b', 'linewidth', 1)
plot(-std(data,1,2)/sqrt(19)+mean(data,2), 'b', 'linewidth', 1)


% Cumulative


data_cum3 = data;
cum = 0;
for i_subj = 1:size(data_cum3, 2)
    for i_t = 50:size(data_cum3,1)
        data_cum3(i_t, i_subj) = data_cum3(i_t, i_subj) + cum;
        cum = data_cum3(i_t, i_subj);
    end 
    cum = 0;
end
%% Condition 4
% data=NOI(:,[1:8 10:20]);
data=varela(:,[1:8 10:20]);

for i=1:19
    data(:,i)=data(:,i)-mean(data(1:50,i));
end
cond4_norm = data;

amp = mean(max(data(46:100, :)) - mean(data(42:44, :)))

amp_cmp = repmat(amp, 1, 10000);
amp_res = zeros(1, 10000);

for i = 1:10000
i_rand = randperm(size(data, 1));
vec_perm = data(i_rand,:);
amp_res(1, i) = mean(max(vec_perm(46:100, :))) - mean(mean(vec_perm(42:44, :)));
end
pv = sum(abs(amp_res) > amp_cmp, 2)/10000


plot(mean(data,2), 'g', 'linewidth', 2)
plot(std(data,1,2)/sqrt(19)+mean(data,2), 'g', 'linewidth', 1)
plot(-std(data,1,2)/sqrt(19)+mean(data,2), 'g', 'linewidth', 1)

data_cum4 = data;
cum = 0;
for i_subj = 1:size(data_cum4, 2)
    for i_t = 50:size(data_cum4,1)
        data_cum4(i_t, i_subj) = data_cum4(i_t, i_subj) + cum;
        cum = data_cum4(i_t, i_subj);
    end 
    cum = 0;
end

%% 

% figure,plot(mean(data_cum1,2),'k' , 'linewidth', 2), hold on
% plot(std(data_cum1,1,2)/sqrt(20)+mean(data_cum1,2), 'k', 'linewidth', 1)
% plot(-std(data_cum1,1,2)/sqrt(20)+mean(data_cum1,2), 'k', 'linewidth', 1)
% 
% plot(mean(data_cum2,2), 'b', 'linewidth', 2)
% plot(std(data_cum2,1,2)/sqrt(20)+mean(data_cum2,2), 'b', 'linewidth', 1)
% plot(-std(data_cum2,1,2)/sqrt(20)+mean(data_cum2,2), 'b', 'linewidth', 1)
% 
% plot(mean(data_cum3,2), 'r', 'linewidth', 2)
% plot(std(data_cum3,1,2)/sqrt(19)+mean(data_cum3,2), 'r', 'linewidth', 1)
% plot(-std(data_cum3,1,2)/sqrt(19)+mean(data_cum3,2), 'r', 'linewidth', 1)
% 
% plot(mean(data_cum4,2), 'g', 'linewidth', 2)
% plot(std(data_cum4,1,2)/sqrt(19)+mean(data_cum4,2), 'g', 'linewidth', 1)
% plot(-std(data_cum4,1,2)/sqrt(19)+mean(data_cum4,2), 'g', 'linewidth', 1)

