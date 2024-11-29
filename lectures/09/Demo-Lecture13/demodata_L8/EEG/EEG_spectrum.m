%% Author: Lu, Chia-Feng 2013.11.15
clear, close all

%% initialize parameters
samplerate=500; % in Hz

passband=[1 50];   % pass band of bandpass filter, in Hz
forder=6;     % filter order

fstep=0.5;   % frequency step for wavelet

%% load EEGdata 
load('R_0409_epo_s.mat')
ch_select=13; % 13 for C3

Mag=[];
for i=1:length(epo_s)
    data=epo_s{i}(ch_select,:);
    EEGdata=filter_2sIIR(data,passband,samplerate,forder,'bandpass'); % 2-stage IIR bandpass filter
    
    N=length(EEGdata);    
%% Time-frequency analysis (CWT, morlet wavelet)
    spec = tfa_morlet(EEGdata, samplerate, 8, 25, fstep);
    taxis=[1:N]/samplerate;
    faxis=[8:fstep:25];
    Mag(:,:,i)=abs(spec);     % get spectrum magnitude
end

AvgMag=mean(Mag,3);

figure('color',[1 1 1]),
mesh(taxis,faxis,AvgMag)   % plot spectrogram as 3D mesh
axis([taxis(1) taxis(end) faxis(1) faxis(end)])
view(40,50);           % specify the 3D plot view
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Time-frequency analysis (CWT)')

figure('color',[1 1 1]),
surface(taxis,faxis,AvgMag)   % plot spectrogram as 3D surface
axis([taxis(1) taxis(end) faxis(1) faxis(end)])
view(40,50);           % specify the 3D plot view
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Time-frequency analysis (CWT)')
grid on