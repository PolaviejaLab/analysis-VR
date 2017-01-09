[~, cube] = orderresponses();

% get the cubes for agency and ownership

qOwnership = 1:4;
qAgency = 7:9;

cubeOwnership = cube(qOwnership, :, :);
cubeAgency = cube(qAgency, :, :);

% get the means and the standart deviations per subject
meansSubjectOwnership = squeeze(mean(cubeOwnership, 1));
meansSubjectAgency = squeeze(mean(cubeAgency, 1));



sdevSubjectOwnership = squeeze(std(cubeOwnership, 1));
sdevSubjectAgency = squeeze(std(cubeAgency, 1));


meanGroupOwnership = squeeze(mean(meansSubjectOwnership, 2));
meanGroupAgency = squeeze(mean(meansSubjectAgency, 2));


sdevGroupOwnership = squeeze(std(sdevSubjectOwnership, 2));
sdevGroupAgency = squeeze(std(sdevSubjectAgency, 2));

coefvarianceOwnership = sdevSubjectOwnership./meansSubjectOwnership;
coefvarianceAgency = sdevSubjectAgency./meansSubjectAgency;

