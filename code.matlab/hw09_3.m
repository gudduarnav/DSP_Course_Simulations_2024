% Homework 9
% Q. 3

% ------------ clear all ----------------
close all;
clear all;
clc;


% ------------ generate x(t) ------------
samplerate = 100; % Hz
Tsample = 1/samplerate; % s.
Nsamples = samplerate * 1; % sec

t = 0: Tsample: (1-Tsample); % time sample
n_t = t/Tsample;
x = cos(2*pi*5*t); % samples

% ------------- twiddle matrix ----------
W = zeros(Nsamples, Nsamples);

for m = 1: Nsamples
    for n = 1: Nsamples
        W(m,n)= exp(-1j * 2*pi/Nsamples * (m-1)*(n-1) );
    end
end

% -------------- twiddle inverse --------
Winv = 1/Nsamples * conj(W);


% -------------- a ----------------------
X_DFT = W * x.';
X_DFT = X_DFT.';

% -------------- b ----------------------
x_IDFT= Winv * X_DFT.';
x_IDFT= x_IDFT.';

% -------------- c ----------------------
X_FFT = fft(x);

% -------------- d ----------------------
x_IFFT = ifft(X_FFT);

% -------------- e ----------------------
f = figure(1);
f.Position = [200,100, 1200, 800];

subplot(5,1,1);
stem(n_t, x, 'linewidth', 2);
grid on
xlim([0, max(n_t)])
ylim([-1.2, 1.2])
xlabel('n')
ylabel('x(n)')
title("(a)", 'Units', 'normalized', 'Position', [0.5, -0.5, 0])


subplot(5,1,2);
stem(n_t, abs(X_DFT), 'linewidth', 2);
grid on
xlim([0, max(n_t)])
ylim([min(abs(X_DFT)), max(abs(X_DFT))+10])
xlabel('k')
ylabel('$X_{DFT}$(k)', 'interpreter', 'latex')
title("(b)", 'Units', 'normalized', 'Position', [0.5, -0.5, 0])

subplot(5,1,3);
stem(n_t, real(x_IDFT), 'linewidth', 2);
grid on
xlim([0, max(n_t)])
ylim([-1.2, 1.2])
xlabel('n')
ylabel('$X_{IDFT}$(n)', 'interpreter', 'latex')
title("(c)", 'Units', 'normalized', 'Position', [0.5, -0.5, 0])


subplot(5,1,4);
stem(n_t, abs(X_FFT), 'linewidth', 2);
grid on
xlim([0, max(n_t)])
ylim([min(abs(X_FFT)), max(abs(X_FFT))+10])
xlabel('k')
ylabel('$X_{FFT}$(k)', 'interpreter', 'latex')
title("(d)", 'Units', 'normalized', 'Position', [0.5, -0.5, 0])


subplot(5,1,5);
stem(n_t, real(x_IFFT), 'linewidth', 2);
grid on
xlim([0, max(n_t)])
ylim([-1.2, 1.2])
xlabel('n')
ylabel('$X_{IFFT}$(n)', 'interpreter', 'latex')
title("(e)", 'Units', 'normalized', 'Position', [0.5, -0.5, 0])


saveas(f, 'hw09_3.eps', 'epsc');
