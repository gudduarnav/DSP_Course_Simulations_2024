%% Author: Lu, Chia-Feng 2013.11.01
clear, close all

%% initialize parameters
samplerate=500; % in Hz
N=1024; % data length

sinefreq=10; % in Hz
%% generate a sine wave
t=[1:N]/samplerate;
sig=sin(2*pi*sinefreq*t);

%% generate window function
% help window
WF=zeros(1,N);
temp=window(@hamming,round(N/3));
WF(round(N/3):round(N/3)+length(temp)-1)=temp;

%% truncate signal by window function
sig_trunc=sig.*WF;

%% plot signal and window function
figure,
subplot(3,1,1),plot(t,sig),xlim([t(1) t(end)])
ylabel('a sine wave')
subplot(3,1,2),plot(t,WF),xlim([t(1) t(end)])
ylabel('window function')
subplot(3,1,3),plot(t,sig_trunc),xlim([t(1) t(end)])
ylabel('truncated signal')
xlabel('time (s)')

