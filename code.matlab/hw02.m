% Homework 2

% --- clear ---
close all;
clear all;
clc;

% --- function ---
dd = @(n) ((n==0)*1);
fx = @(n) dd(n) + 3*dd(n-1) + 2*dd(n-2) + 6*dd(n-3) + 7*dd(n-4) + 5*dd(n-5) + 4*dd(n-6);

% --- series ---
n = 0: 10;
x = fx(n);

% --- (a) ---
f1 = figure(1);
stem(n, x, '-b', 'linewidth', 2)
xlabel('$n$')
ylabel('$x(n)$')
xlim([0, 10])
ylim([0, 8])
grid on
set(findall(f1,'-property','FontSize'),'FontSize',14);
set(findall(f1,'-property','Interpreter'), 'Interpreter', 'latex');
saveas(f1, 'hw02a.eps', 'epsc');

% --- (b) ---
y = [];
for k=1: length(x)
    k0 = max([1, k-2]);
    yb(k) = (1/3) * sum(x(k0:k));
end

% --- (c) ---
fma = @(n) (1/3) * (dd(n) + dd(n-1) + dd(n-2));

ma = fma(n)
yc = conv(x, ma,'full'); 
yc = yc(1: length(n));

% --- (d) ----
f2 = figure(2);
stem(n, yb, '-r', 'linewidth', 2)
hold on
stem(n, yc, '-.db', 'linewidth', 2)
hold off
grid on
xlabel('$n$')
ylabel('$y(n)$')
xlim([0, 10])
ylim([0, 8])
grid on
legend('for-loop', 'conv')
set(findall(f2,'-property','FontSize'),'FontSize',14);
set(findall(f2,'-property','Interpreter'), 'Interpreter', 'latex');
saveas(f2, 'hw02d.eps', 'epsc');
