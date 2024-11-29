%% Author: Lu, Chia-Feng 2013.11.15
clear, close all

%% initialize parameters
samplerate=500; % in Hz
N=1024; % data length

sinefreq1=20; % in Hz
sinefreq2=60; % in Hz

fstep=1;   % frequency step for wavelet

%% generate simulated signals with step changes in frequency
ts=[1:N/4]/samplerate;  % time axis for each segment
data=[zeros(1,N/4) sin(2*pi*sinefreq1*ts) sin(2*pi*sinefreq2*ts) zeros(1,N/4)];

taxis=[1:N]/samplerate;   % time axis for whole data length

figure, 
plot(taxis,data),xlim([taxis(1) taxis(end)])
xlabel('Time (s)')

%% Time-frequency analysis (CWT, morlet wavelet)
spec = tfa_morlet(data, samplerate, 1, 250, fstep);
faxis=[1:fstep:250];
Mag=abs(spec);     % get spectrum magnitude

figure('color',[1 1 1]),
mesh(taxis,faxis,Mag)   % plot spectrogram as 3D mesh
axis([taxis(1) taxis(end) faxis(1) faxis(end)])
view(40,50);           % specify the 3D plot view
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Time-frequency analysis (CWT)')

figure('color',[1 1 1]),
surface(taxis,faxis,Mag)   % plot spectrogram as 3D surface
axis([taxis(1) taxis(end) faxis(1) faxis(end)])
view(40,50);           % specify the 3D plot view
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Time-frequency analysis (CWT)')
grid on





