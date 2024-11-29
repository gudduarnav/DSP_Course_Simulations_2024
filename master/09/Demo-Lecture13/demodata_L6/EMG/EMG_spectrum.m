%% Author: Lu, Chia-Feng 2013.11.01
clear, close all

%% initialize parameters
samplerate=1000; % in Hz

segmentNo=20; % for Welch method
passband=[50 450];
%% load ECT EMGdata 
load('EMGdata.mat')
EMGdata=filter_proc(EMGdata',samplerate,passband,3)'; % bandpass filter
EMGdata=EMGdata(:,1); % only use the 1st channel of EMG

N=length(EMGdata);
figure,plot([1:N]/samplerate,EMGdata)
%% Spectral analysis (FFT)
nfft = 2^nextpow2(N); % Next power of 2 from length of y
data_freq=fft(EMGdata,nfft);
PS=abs(data_freq).^2;
PS=PS/max(PS);
faxis=samplerate/2*linspace(0,1,nfft/2+1);

figure,
% plot(faxis,20*log10(PS(1:nfft/2+1))),xlim([passband(1) passband(end)])
plot(faxis,PS(1:nfft/2+1)),xlim([passband(1) passband(end)])
title('Spectral Analysis (FFT)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum')

%% Spectral analysis (FFT with Welch method)
windowlength=round(N/segmentNo);
[PS_W,faxis_W] = pwelch(EMGdata,hamming(windowlength),[],windowlength,samplerate);
PS_W=PS_W/max(PS_W);

figure,
% plot(faxis_W,20*log10(PS_W)),xlim([passband(1) passband(end)])
plot(faxis_W,PS_W),xlim([passband(1) passband(end)])
title('Spectral Analysis (FFT with Welch method)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum')

%% rectify EMG data
EMGdata=abs(EMGdata(:,1)); % only use the 1st channel of EMG

N=length(EMGdata);
figure,plot([1:N]/samplerate,EMGdata)
%% Spectral analysis (FFT)
nfft = 2^nextpow2(N); % Next power of 2 from length of y
data_freq=fft(EMGdata,nfft);
PS=abs(data_freq).^2;
PS=PS/max(PS);
faxis=samplerate/2*linspace(0,1,nfft/2+1);

figure,
% plot(faxis,20*log10(PS(1:nfft/2+1))),xlim([passband(1) passband(end)])
plot(faxis,PS(1:nfft/2+1))
title('Spectral Analysis (FFT)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum')

%% Spectral analysis (FFT with Welch method)
windowlength=round(N/segmentNo);
[PS_W,faxis_W] = pwelch(EMGdata,hamming(windowlength),[],windowlength,samplerate);
PS_W=PS_W/max(PS_W);

figure,
% plot(faxis_W,20*log10(PS_W)),xlim([passband(1) passband(end)])
plot(faxis_W,PS_W)
title('Spectral Analysis (FFT with Welch method)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum')

