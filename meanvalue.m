function [mean_spectra_fz, mean_spectra_fcz, mean_spectra_cz] = meanvalue(baseFileName,inputDir)

%Function that applies filter from 4Hz to 7.5Hz; cuts out 200ms-300ms timeframe and calculates the mean value
        %for three channels (fz,fcz, cz) in that time. The values are saved into a matrix. 
   
%Call EEGLab, import set file
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',baseFileName,'filepath',inputDir);

%Spectopo
%figure;
[spectra, freqs] = pop_spectopo(EEG, 1, [200  300], 'EEG', 'freqrange',[4 7.5], 'freqfac', 100); %, 'freq', [4  5.75 7.5], 'freqrange',[4 7.5],'electrodes','off',

binsize = 500/2/(length(freqs)-1);

minfreq = 4;
maxfreq = 7.5;

minbin = ceil(minfreq/binsize)+1;
maxbin = floor(maxfreq/binsize)+1;

thetafreqs = spectra(:, minbin:maxbin);

%Mean value for Fz
spectra_fz = thetafreqs(2,:);
mean_spectra_fz = mag2db(mean(db2mag(spectra_fz)));

%Mean value for Fcz
spectra_fcz = thetafreqs(62,:);
mean_spectra_fcz = mag2db(mean(db2mag(spectra_fcz)));

%Mean value for Cz
spectra_cz = thetafreqs(24,:);
mean_spectra_cz = mag2db(mean(db2mag(spectra_cz)));

%Save theta wave in new set
thetaFileName = append(baseFileName,' theta');
EEG = pop_saveset(EEG, 'filename',thetaFileName, 'filepath',inputDir);
[ALLEEG, EEG, CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);

end