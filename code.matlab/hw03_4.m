% Homework-4
% 4

% ---- clear ----
close all;
clc;
clear all;

% ---- 4 (a) -----
u = @(n) (n>=0) * 1  ;
func_x = @(n)  sin(1/10 * pi * n) .* (u(n+10) - u(n-10));

n = -20: 1: 20;
x = func_x(n);

f = figure(1);
stem(n,x, 'b', 'linewidth',2)
grid on
xlim([-20, 20])
ylim([-1, 1])

xlabel('$n$')
ylabel('$x(n)$')

set(findall(f,'-property','FontSize'),'FontSize',14);
set(findall(f,'-property','Interpreter'), 'Interpreter', 'latex');


saveas(f, 'hw03_4a.eps', 'epsc');


% ------ (b) ---------
% autocorrelation 
x_acr = xcorr(x,x);

f = figure(2);

stem(x_acr, 'r', 'linewidth',2)

% ------ (c) -----
% conv(x,x)
x_c = conv(x,x);
hold on
stem(x_c, '-.db', 'linewidth', 2)
hold off

grid on
xlim([20, 60])
ylim([-10, 10])

legend('autocorr $x(n)$', 'conv ($x$, $x$)')
xlabel('$n$')
ylabel('$autocorr\ x(n)$')


set(findall(f,'-property','FontSize'),'FontSize',14);
set(findall(f,'-property','Interpreter'), 'Interpreter', 'latex');

saveas(f, 'hw03_4d.eps', 'epsc');
