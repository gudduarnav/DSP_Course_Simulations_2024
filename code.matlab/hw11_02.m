% HW11
% Q02

% ---------- reset -----------------
close all;
clear all;
clc;


% ---------- configs ----------------
w1 = 0.1;
w2 = 0.4;

% ------ generate the filter --------
[a b] = get_coeff_filter(w1, w2);  % generate the filter coeffs.


h = [a b a]; % actual 3 point filter coefficients

% ----------- generate the input signals ---------
n = 0: 99; % time index
A = 1; % amplitudes
B = 1.5;

x = A * cos(w1*n) + B * cos(w2*n); % input signal

% ----------- output = filter(input) -------------
y = filter(x, 1, x); 

% ----------- Analyze the filter -----------------


% Compute frequency response of the filter
[H, w] = freqz(h, 1, 512);

figure(1)
subplot(2,1,1)

% Plot the magnitude response
plot(w/pi, abs(H));
xlabel('Normalized Frequency (rad/sample)');
ylabel('Magnitude');
title('(a) Frequency Response','Units', 'normalized', 'Position', [0.5, -0.35, 0]);
grid on;

% Plot the phase response (optional)
subplot(2,1,2);
plot(w/pi, angle(H));
xlabel('Normalized Frequency (rad/sample)');
ylabel('Phase (radians)');
title('Phase Response');
title('(b) Frequency Response','Units', 'normalized', 'Position', [0.5, -0.35, 0]);
grid on;


saveas(gca, 'hw11_2a.eps', 'epsc');


% --------- Analyze I/O signals ---------

% Fourier Transform of Input Signal
X = fft(x, 512); % Compute the FFT of input signal
frequencies = (0:511) / 512; % Define the frequency axis (normalized)

% Fourier Transform of Output Signal
Y = fft(y, 512); % Compute the FFT of output signal

% Magnitudes of the FFTs
magnitude_X = abs(X); % Magnitude of FFT of input signal
magnitude_Y = abs(Y); % Magnitude of FFT of output signal

% Plot the frequency spectrum
figure;

% Input signal spectrum
subplot(2, 1, 1);
plot(frequencies, magnitude_X);
title('(a) Frequency Spectrum of Input Signal','Units', 'normalized', 'Position', [0.5, -0.35, 0]);

xlabel('Normalized Frequency');
ylabel('Magnitude');
grid on;

% Output signal spectrum
subplot(2, 1, 2);
plot(frequencies, magnitude_Y);
title('(b)Frequency Spectrum of Output Signal', 'Units', 'normalized', 'Position', [0.5, -0.35, 0]);
xlabel('Normalized Frequency');
ylabel('Magnitude');
grid on;

saveas(gca, 'hw11_2b.eps', 'epsc');


% ---------------- functions -------------
function [a, b] = get_coeff_filter(w1, w2)
    term1 = 1 + exp(-1j * 2* w1);
    term2 = exp(1j*w2) + exp(-1j*w2);
    
    a = 1/(term1 - term2);
    b = -term2/(term1 - term2);


end