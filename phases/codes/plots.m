clc; clear; close all;

N = 2^8; % Number of points

% First case: x in S[7][0], i.e., x spans from 0 to 255 in integer steps
x1 = -2^7+1:1:2^7;
y1 = tanh(x1);

% Second case: x in S[4][4], i.e., x spans from 3 to 3 + 255/8 in 1/8 steps
x2 = -2^3+1:1/2^4:2^3;
y2 = tanh(x2);

% Create figure and set size (Width x Height in pixels)
figure('Position', [100, 100, 800, 200]); % [left, bottom, width, height]

% Plotting
subplot(1,2,1);
plot(x1, y1, 'b', 'LineWidth', 1.5);
xlabel('x in S[7][0]');
ylabel('tanh(x)');
title('tanh(x) for x in S[8][0]');
grid on;

subplot(1,2,2);
plot(x2, y2, 'r', 'LineWidth', 1.5);
xlabel('x in S[4][3]');
ylabel('tanh(x)');
title('tanh(x) for x in S[4][3]');
grid on;
