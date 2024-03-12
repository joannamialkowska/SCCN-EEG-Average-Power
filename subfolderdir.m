function subfolderdir(subFolders,resultsFileName)

fileID = -1;
errmsg = '';
[fileID,errmsg] = fopen(resultsFileName,'w');

if fileID < 0
    disp(fileID)
    disp(errmsg)
end

count = 0;

fprintf(fileID, 'Participant, Event, Fcz, Fz, Cz\n');

for i = 1:length(subFolders)
    %For loop that runs through all participant folders
    inputDir = append(subFolders(i).folder,'/',subFolders(i).name);
    myFiles = dir(fullfile(inputDir,'*epochs.set'));
    participant = subFolders(i).name;

    for k = 1:length(myFiles)
        
%         count = count + 1;
%         if count > 1
%             break
%         end

        baseFileName = myFiles(k).name;
        matrix = split(baseFileName); %, " ", 'CollapseDelimiters', 'True'
        event_type = str2double(matrix(2,1));
        [mean_spectra_fz, mean_spectra_fcz, mean_spectra_cz] = meanvalue(baseFileName,inputDir);

        fprintf(fileID, '%s, %i, %f, %f, %f\n',string(participant), event_type, mean_spectra_fcz, mean_spectra_fz, mean_spectra_cz);
    end
end
fclose(fileID);
end


