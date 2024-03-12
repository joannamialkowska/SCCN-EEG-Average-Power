participantDir = '/Users/joannamialkowska/Documents/MATLAB/SCCN/mateusz/meanexample';

%Input folder directory containing all participant folders
myParticipantFiles = dir(participantDir);

controlSubFolders = dir(fullfile(participantDir,'Kc*'));
experimentalSubFolders = dir(fullfile(participantDir,'C*'));

%Run function
subfolderdir(controlSubFolders,'results_control.csv')
subfolderdir(experimentalSubFolders,'results_experimental.csv')

