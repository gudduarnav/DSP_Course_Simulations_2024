% HW08
% Q03

% -------------- reset --------------------
close all;
clear all;
clc;

% -------------- (a) ----------------------
funcx = @(t) cos(2*pi*10*t);

N = 100;
t = 0: 1: (N-1);
t= t/N;
t = t.';
x = funcx(t);

Wk = zeros(N,N);
for m=1: N
    for n = 1: N
        W = exp(-1j * 2*pi/N);
        Wk(m,n) = power(W, m*n);
    end
end

n=1:N;
n = n.';
Xk = Wk * x;


Wkinv = Wk';
xk = 1/N * Wkinv * Xk;

Xk_fft = fft(x);
xk_fft = ifft(Xk_fft);

f = figure(1);

% (a)
subplot(2,2,1)
stem(n,abs(Xk), 'b-','linewidth', 2)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
xlim([0,N-1])
ylim([0, 60])
grid on
title("(a)", 'Units', 'normalized', 'Position', [0.5, -0.35, 0])

% (b)
subplot(2,2,2)
stem(t, real(xk), 'r-', 'linewidth', 2)
grid on
xlim([0,(N-1)/N])
ylim([-1.1,1.1])
xlabel('Time (s)')
ylabel('Amplitude')
title("(b)", 'Units', 'normalized', 'Position', [0.5, -0.35, 0])

% (c)
subplot(2,2,3)
stem(n,abs(Xk_fft), 'b-','linewidth', 2)
xlabel('Frequency (Hz)')
ylabel('Amplitude')
xlim([0,N-1])
ylim([0, 60])
grid on
title("(c)", 'Units', 'normalized', 'Position', [0.5, -0.35, 0])

% (d)
subplot(2,2,4)
stem(t, real(xk_fft), 'r-', 'linewidth', 2)
grid on
xlim([0,(N-1)/N])
ylim([-1.1,1.1])
xlabel('Time (s)')
ylabel('Amplitude')
title("(d)", 'Units', 'normalized', 'Position', [0.5, -0.35, 0])



saveas(f, 'hw08_3.eps', 'epsc');

