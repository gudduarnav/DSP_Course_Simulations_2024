% Homework 1
% Q. 3

% ---- clear ----
close all;
clear all;
clc;

% ---- (a) ----
f = @(n) exp(1j*(pi/10)*n);

n = -10: 1: 10;
x = f(n);

% --- (b) ----
xr = real(x);
xi = imag(x);

f = figure(1);
f.Position = [10 10 800 640];
stem(n, xr, '-r', 'linewidth', 2);
hold on
stem(n, xi, '-.db', 'linewidth', 2);
hold off
grid on
legend('Re $x(n)$', 'Im $x(n)$', 'Location', 'Northwest');
xlabel('$n$')
ylabel('Re (Im) $x(n)$')
xlim([-10, 10])
ylim([-1.2, 1.2])
set(findall(f,'-property','FontSize'),'FontSize',14);
set(findall(f,'-property','Interpreter'), 'Interpreter', 'latex');

saveas(f, 'hw01.eps', 'epsc');