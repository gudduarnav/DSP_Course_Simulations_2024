% Homework 04
% Q. 3

% ---------- clear -------------
close all;
clear all;
clc;

% ---------- (a) ---------------
ustep = @(n) (n>=0)*1.0;
ddelta= @(n) (n==0)*1.0;

hfunc = @(n) (1/3).^n .* ustep(n);
xfunc = @(n) ddelta(n) - 1/2*ddelta(n-1);

n = 0:1:99;
x = xfunc(n);
h = hfunc(n);


f = figure(1);
f.Position = [100,300, 1400,900];
set(groot, 'defaultAxesFontName', 'Times New Roman');
set(groot, 'defaultAxesFontSize', 14);

subplot(2,1,2);
stem(n, h, 'b', 'linewidth', 2, 'marker', 'd');
grid on;
xlabel('n');
ylabel('h(n)');
xlim([0,99]);
ylim([-1,1]);
title('(b)', 'Units', 'normalized', 'Position', [0.5, -0.3, 0]);


subplot(2,1,1);
stem(n, x, 'r', 'linewidth', 2, 'marker', 'd');
grid on;
xlabel('n');
ylabel('x(n)');
xlim([0, 99]);
ylim([-1, 1]);
title('(a)', 'Units', 'normalized', 'Position', [0.5, -0.3, 0]);

saveas(f, 'hw04_3a.eps', 'epsc');
%close all;

% ------------ (b) -------------------
omega = 0: pi/100: 6*pi;
X = zeros(size(omega));
H = zeros(size(omega));

for index = 1: length(omega)
    omega1 = omega(index); 

    X(index) = sum( x .* exp(-1j * omega1 * n ) );
    H(index) = sum( h .* exp(-1j * omega1 * n ) );
end


% ------------ (c) ---------------------
Y = X .* H;

f = figure(2); 
f.Position = [100,300, 1400,900];
set(groot, 'defaultAxesFontName', 'Times New Roman');
set(groot, 'defaultAxesFontSize', 14);

subplot(3,2,1)
plot(omega, abs(X),'b', 'linewidth', 2)
grid on
xlim([min(omega), max(omega)])
ylim([0, 2])
xlabel('$\omega$', 'interpreter', 'latex')
ylabel('$|X(e^{j \omega})|$', 'interpreter', 'latex')

subplot(3,2,2)
plot(omega, angle(X), 'r', 'linewidth', 2)
grid on
xlim([min(omega), max(omega)])
ylim([-pi/4, pi/4])
xlabel('$\omega$', 'interpreter', 'latex')
ylabel('$\angle X(e^{j \omega})$', 'interpreter', 'latex')

title('(a)', 'Units', 'normalized', 'Position', [-0.2, -0.3, 0])


subplot(3,2,3)
plot(omega, abs(H),'b', 'linewidth', 2)
grid on
xlim([min(omega), max(omega)])
ylim([0, 2])
xlabel('$\omega$', 'interpreter', 'latex')
ylabel('$|H(e^{j \omega})|$', 'interpreter', 'latex')

subplot(3,2,4)
plot(omega, angle(H), 'r', 'linewidth', 2)
grid on
xlim([min(omega), max(omega)])
ylim([-pi/4, pi/4])
xlabel('$\omega$', 'interpreter', 'latex')
ylabel('$\angle H(e^{j \omega})$', 'interpreter', 'latex')

title('(b)', 'Units', 'normalized', 'Position', [-0.2, -0.3, 0])


subplot(3,2,5)
plot(omega, abs(Y),'b', 'linewidth', 2)
grid on
xlim([min(omega), max(omega)])
ylim([0, 2])
xlabel('$\omega$', 'interpreter', 'latex')
ylabel('$|Y(e^{j \omega})|$', 'interpreter', 'latex')

subplot(3,2,6)
plot(omega, angle(Y), 'r', 'linewidth', 2)
grid on
xlim([min(omega), max(omega)])
ylim([-pi/4, pi/4])
xlabel('$\omega$', 'interpreter', 'latex')
ylabel('$\angle Y(e^{j \omega})$', 'interpreter', 'latex')

title('(c)', 'Units', 'normalized', 'Position', [-0.2, -0.3, 0])


saveas(f, 'hw04_3c.eps', 'epsc');
%close all; 

% ---------------- (d) --------------------
y = conv(x, h);
y_hat = zeros(size(y));
n_hat = 0:(length(y)-1);

for index = 1: length(y_hat)
   n1 = index-1;
   y_hat(index) = 1/100 * 1/(2*pi) * sum(Y .* exp(1j*omega*n1) );
end


f = figure(3); 
f.Position = [100,300, 1400,900];
set(groot, 'defaultAxesFontName', 'Times New Roman');
set(groot, 'defaultAxesFontSize', 14);

subplot(2,1,1)
stem(n_hat, y, 'b', 'linewidth', 2)
grid on
xlim([min(n), max(n)])
ylim([-0.5, 1])
xlabel('$n$', 'interpreter', 'latex')
ylabel('$y(n)$', 'interpreter', 'latex')
title('(a)', 'Units', 'normalized', 'Position', [0.5, -0.3, 0]);


subplot(2,1,2)
stem(n_hat, y_hat, 'r', 'linewidth', 2)
grid on
xlim([min(n), max(n)])
ylim([-0.5, 1])
xlabel('$n$', 'interpreter', 'latex')
ylabel('$\hat{y}(n)$', 'interpreter', 'latex')

title('(b)', 'Units', 'normalized', 'Position', [0.5, -0.3, 0]);

saveas(f, 'hw04_3d.eps', 'epsc');

