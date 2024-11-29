%% Author: Lu, Chia-Feng 2013.11.15
clear, close all

%% initialize parameters
samplerate=1000; % in Hz

passband=[50 450];   % pass band of bandpass filter, in Hz
forder=6;     % filter order

Win_nfft=64;      % window size for each segment
noverlap=round(Win_nfft*0.5);  % number of overlapping points (50%)

fstep=1;   % frequency step for wavelet

%% load ECT EMGdata 
load('EMGdata.mat')
EMGdata=filter_2sIIR(EMGdata',passband,samplerate,forder,'bandpass')'; % 2-stage IIR bandpass filter
% EMGdata=EMGdata(:,1); % only use the 1st channel of EMG
EMGdata=EMGdata(3500:6000,1); % only use the 1st channel and time range of [1:6000] data points 

N=length(EMGdata);
taxis=[1:N]/samplerate;
figure,plot(taxis,EMGdata),xlim([taxis(1) taxis(end)])
xlabel('Time (s)')
%% Spectral analysis (FFT)
nfft = 2^nextpow2(N); % Next power of 2 from length of y
data_freq=fft(EMGdata,nfft);
Mag=abs(data_freq);
faxis=samplerate/2*linspace(0,1,nfft/2+1);

figure,
plot(faxis,Mag(1:nfft/2+1)),xlim([passband(1) passband(end)])
title('Spectral Analysis (FFT)')
xlabel('Frequency (Hz)')
ylabel('Spectrum')

%% Time-frequency analysis (STFT, spectrogram)
[spec,faxis,taxis]=spectrogram(EMGdata,hamming(Win_nfft),noverlap,Win_nfft,samplerate);
Mag=abs(spec);     % get spectrum magnitude

figure('color',[1 1 1]),
mesh(taxis,faxis,Mag)   % plot spectrogram as 3D mesh
axis([taxis(1) taxis(end) faxis(1) faxis(end)])
view(40,50);           % specify the 3D plot view
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram (STFT)')

figure('color',[1 1 1]),
surface(taxis,faxis,Mag)   % plot spectrogram as 3D surface
axis([taxis(1) taxis(end) faxis(1) faxis(end)])
view(40,50);           % specify the 3D plot view
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram (STFT)')
grid on

%% Time-frequency analysis (CWT, morlet wavelet)
spec = tfa_morlet(EMGdata', samplerate, 1, 500, fstep);
taxis=[1:N]/samplerate;
faxis=[1:fstep:500];
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

