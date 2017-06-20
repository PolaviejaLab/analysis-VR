%%%%%%%
% Find timestamps

addpath('readFiles\');

[tsEvents, ~, events] = ...
    readLogFile('E:\GitHub\Victoria-Discontinuity\Results\ElementsAgency\test_DDdaf\2017-05-31 10.56 .log');

iStart = strmatch('Implicit Measure Started', events, 'exact');
tsStart = tsEvents(iStart, :);

iEnd = strmatch('Implicit Measure Finished', events, 'exact');
tsEnd = tsEvents(iEnd, :);


%% Find the corresponding indexes in the trajectories file

addpath('trajectories\');

% Extract the trajectories from the file
[handposition, tsTrajectories] = ...
    extractTrajectories('E:\GitHub\Victoria-Discontinuity\Results\ElementsAgency\test_DDdaf\2017-05-31 10.56  Trial 1.csv');

iTsStart = strmatch(tsStart(1, 1:22), tsTrajectories);
iTsEnd = strmatch(tsEnd(1, 1:22), tsTrajectories);

figure, plot(handposition(iTsStart:iTsEnd-1,1), -handposition(iTsStart:iTsEnd-1,3)); hold on;
interval = 0.1:0.1:30;
resta = handposition(iTsStart:iTsEnd-1,1)' + interval;
plot(resta, -handposition(iTsStart:iTsEnd-1,3), 'r');
plot(interval, -handposition(iTsStart:iTsEnd-1,3), 'k');