%% Author: Lu, Chia-Feng 2013.11.01
clear, close all

%% initialize parameters
samplerate=250; % in Hz
N=512; % data length

sinefreq=10; % in Hz

%% generate a sine signals 
t=[1:N]/samplerate;
sig=sin(2*pi*sinefreq*t);

%% Spectral analysis (FFT)
nfft = 2^nextpow2(N); % Next power of 2 from length of y
sig_freq=fft(sig,nfft);
PS=abs(sig_freq).^2;
PS=PS/max(PS);  % normalize PS to its maximum
faxis=samplerate/2*linspace(0,1,nfft/2+1);

figure, 
subplot(1,2,1),plot(t,sig),xlim([t(1) t(end)])
title([num2str(sinefreq) '-Hz Sine Wave'])
xlabel('Time (s)')
subplot(1,2,2),plot(faxis,PS(1:nfft/2+1))  
xlim([faxis(1) faxis(end)])
title('Spectral Analysis (FFT)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum')


