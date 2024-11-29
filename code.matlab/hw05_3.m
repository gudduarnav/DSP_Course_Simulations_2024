% HW05
% Q. 3

% ------------ clear all ----------------
close all;
clear all;
clc;

% ------------ (a) ----------------------

B = [1, -2];
A = [1. -3/4];

f=figure(1);
zplane(B,A)
grid on
saveas(f, 'hw05_4a.eps', 'epsc');

% ----------- (b) ------------------------
N= 100; % num points to calculate
points = freqz(B,A,N);

mag = abs(points);
phase = angle(points);

f = figure(2);
subplot(2,1,1)
plot(mag, 'linewidth',2)
grid on
title("(a)", 'Units', 'normalized', 'Position', [0.5, -0.35, 0])
xlim([1,N])
ylim([0, max(mag)]+0.5)
xlabel("Points")
ylabel("Mag. Resp.")

subplot(2,1,2)
plot(phase, 'linewidth',2)
grid on
title("(b)", 'Units', 'normalized', 'Position', [0.5, -0.35, 0])
xlim([1,N])
ylim([0, pi])
xlabel("Points")
ylabel("Phase Resp.")
saveas(f, 'hw05_4b.eps', 'epsc');