% DSP HW 14
% Q. 3

% --------- clear -----------
close all; 
clear all;
clc;

% --------- (a) -------------

% Coefficients of the numerator and denominator
b = [1, 3]; % Numerator coefficients
a = [1, 0.5]; % Denominator coefficients

% Plot the system H1(z)
fvtool(b, a, 'Analysis', 'freq'); % Frequency response (a-1)


% Minimum phase and all-pass decomposition
[b_min, a_min] = rceps(b); % Minimum phase system
[b_ap, a_ap] = deal(b ./ b_min, a ./ a_min); % All-pass system

% Plot minimum phase and all-pass components
fvtool(b_min, a_min, 'Analysis', 'freq'); % Minimum phase response (a-2)
fvtool(b_ap, a_ap, 'Analysis', 'freq'); % All-pass response (a-3)


% ----------- (b) ------------
% Define the comb filter coefficients
b_comb = [1, 0, 0, 0, 1]; % Comb filter numerator
a_comb = [1]; % Denominator (no poles)

% Plot the comb filter
fvtool(b_comb, a_comb, 'Analysis', 'freq'); % Frequency response

