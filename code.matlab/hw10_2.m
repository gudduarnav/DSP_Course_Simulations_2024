% HW10
% Q. 2

% ---- clear ----
close all;
clear all;
clc;

% ---- (a) ----
% Read the audio file
[x, Fs] = audioread('guitar4.wav');

% ---- (b) -----
% Create and plot a Hann window

% Define the DFT length N such that the bandwidth of the DFT bins is ~20Hz
bandwidth = 20; % Desired bandwidth in Hz
N = 2^nextpow2(Fs / bandwidth); % Calculate N as a power of 2

% Create the Hann window
n = 0:N-1; % Sample indices
w = 0.5 * (1 - cos(2 * pi * n / N)); % Hann window formula

% Plot the Hann window
figure;
plot(n, w, 'LineWidth', 1.5);
title('Hann Window');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Save the Hann window plot as an .eps file
saveas(gcf, 'hw10_2b.eps', 'epsc');

% Display window details
disp(['DFT Length (N): ', num2str(N)]);

% ---- (c) ----
M = N / 4; % Number of samples to shift after DFT

% Compute the spectrogram
X = myspectrogram(x, N, w, M);

% ---- (d) ----
% Prepare time and frequency vectors
t = (0:size(X, 2)-1) * (M / Fs); % Time vector
f = (0:N/2-1) * (Fs / N); % Frequency vector (positive frequencies)

% Plot the spectrogram using the provided code
figure;
image(t, f, (X(1:floor(N/2), :))); % Plot spectrogram
colormap(hot(256)); % Apply hot colormap
colorbar; % Add color bar
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram of the Signal');

% Save the spectrogram plot as an .eps file
saveas(gcf, 'hw10_2d.eps', 'epsc');
