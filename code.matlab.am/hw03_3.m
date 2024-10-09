% Homework-3
% 3

% ---- clear ----
close all;
clc;
clear all;

% ---- (a) -----
u = @(n) (n>=0)*1.0;
func_y = @(n)  (24/7)*(-4).^n + (18/7)*(3).^n - u(n);

n = 0:1:4;
y_sol = func_y(n);

f = figure(1);
stem(n, y_sol, '-r', 'linewidth', 2)

% ------ (b) -----
y = [-0.5, -1];
for  k = 0:1:4
    y_next = 10*u(k) - y(k+3-1) + 12 * y(k+3-2);
    y(end+1) = y_next;
end
y = y(3:end);
hold on
stem(n, y, '--db' , 'linewidth', 2)


% ---- (c) ----
% (filter)
x = 10 * u(n);
y0 = [-1, -0.5]; % initial soln.
coeff_x = [1]; % coeff of x
coeff_y = [1,1,-12]; % coeff of y
eq = filtic(coeff_x, coeff_y, y0);
yf = filter(coeff_x, coeff_y, x, eq);

stem(n, y, ':xk' , 'linewidth', 2)
hold off


% %%%%%
xlabel('$n$')
ylabel('$y(n)$')
grid on
xlim([0,4])
legend('LCDDE', 'for-loop', 'filter')
set(findall(f,'-property','FontSize'),'FontSize',14);
set(findall(f,'-property','Interpreter'), 'Interpreter', 'latex');


saveas(f, 'hw03_3.eps', 'epsc');
