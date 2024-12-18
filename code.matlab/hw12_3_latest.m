% HW 12
% q. 3

% --------- clear ---------------
close all;
clear all;
clc;

% --------- q.2 ------------------
% Parameters
wo = 0.1; % Normalized notch frequency (omega_c / pi)
bw = 0.001; % Normalized 3 dB bandwidth

% Design the notch filter
[b, a] = iirnotch(wo, bw);

% Visualize the filter properties using FVTool
fvtool(b, a, 'Analysis', 'freq'); % Shows magnitude response and group delay


