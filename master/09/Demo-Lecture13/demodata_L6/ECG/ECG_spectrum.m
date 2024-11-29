%% Author: Lu, Chia-Feng 2013.11.01
clear, close all

%% initialize parameters
samplerate=500; % in Hz

segmentNo=20; % for Welch method
%% load ECT data 
load('ECG_500SampleRate.txt')
data=ECG_500SampleRate;
clear ECG_500SampleRate

N=length(data);
figure,plot([1:N]/samplerate,data),xlim([1 10])

%% detect R peak and store R-R interval
%%% perform double-threshold method to detect R peak
% threshold 1: magnitude
indmag=find(data>=1.5);    % find the index with value larger than 1.5

% threshold 2: define window
diffind=indmag(2:end)-indmag(1:end-1);
indgap=find(diffind>1);

indmax=[];   % the location of index with maximal value in each cycle
for i=1:length(indgap)+1
    if i==1
        period=indmag(1:indgap(1));
    elseif i==length(indgap)+1    
        period=indmag(indgap(i-1)+1:end);
    else
        period=indmag(indgap(i-1)+1:indgap(i));
    end
    [value,ind]=max(data(period));
    indmax(i)=period(ind(1));
end

indmax(end)=[];
RRinterval=[];  % heart rate variability (HRV)
RRinterval=diff(indmax)/samplerate;
HRV=60./RRinterval;
%% rewrite data set by HRV
data=RRinterval; 
% data=HRV; 
samplerate=1/mean(RRinterval);
N=length(RRinterval);

figure,plot(data),title('Heart rate variability')
xlabel('beats'),ylabel('R-R interval (s)')
figure,hist(data,100),title(['Mean HRV is ' num2str(mean(data)) ])
xlabel('R-R interval (s)'),ylabel('count beats')
%% Spectral analysis (FFT)
nfft = 2^nextpow2(N); % Next power of 2 from length of y
data_freq=fft(data,nfft);
PS=abs(data_freq).^2;
PS=PS/max(PS);
faxis=samplerate/2*linspace(0,1,nfft/2+1);

figure,
plot(faxis,20*log10(PS(1:nfft/2+1)))
% plot(faxis,PS(1:nfft/2+1))
title('Spectral Analysis (FFT)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum (dB)')

%% Spectral analysis (FFT with Welch method)
windowlength=round(N/segmentNo);
[PS_W,faxis_W] = pwelch(data,hamming(windowlength),[],windowlength,samplerate);
PS_W=PS_W/max(PS_W);

figure,
plot(faxis_W,20*log10(PS_W))
% plot(faxis_W,PS_W)
title('Spectral Analysis (FFT with Welch method)')
xlabel('Frequency (Hz)')
ylabel('Power Spectrum (dB)')

