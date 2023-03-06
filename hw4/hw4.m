% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw4.m -- homework #4
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
close;
close all;


%% Shooting the Schmidt
% testing </3


%% De-Gauss, Re-Gauss
x  = linspace(0, 2*pi, 1000);
y1 = sin(x);
y2 = gauss(x,      0, 1);
y3 = gauss(x,   pi/2, 1);
y4 = gauss(x,     pi, 1);
y5 = gauss(x, 3*pi/4, 1);
y6 = gauss(x,   2*pi, 1);

V = [y2', y3', y4', y5', y6'];
S = gram_schmidt(V);

y7 = ortho_proj(y1, S);

subplot(2, 1, 1);
plot(x, y1);
title('\(sin(x)\)', 'Interpreter', 'latex');
xlabel('\(x\)', 'Interpreter', 'latex');
ylabel('\(y\)', 'Interpreter', 'latex');

subplot(2, 1, 2);
plot(x, y7);
title('\(sin(x)\) projection into \(S\)', 'Interpreter', 'latex');
xlabel('\(x\)', 'Interpreter', 'latex');
ylabel('\(y\)', 'Interpreter', 'latex');
