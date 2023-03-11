% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw5.m -- homework #5
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
close;
close all;


%% Be Discrete
b = [1/2, 2/3, 3/7];
a = [2,   1/3, 1/2];

% ROCs:
% * {|z| < 1/2}
% * {1/2 < |z| <= oo} (BIBO stable + causal)
zplane(b, a);

[z, p, k] = tf2zp(b, a);

[H, T] = impz(b, a, 1:66);
stem(T, H);

samples = sin(floor((1:55) / 10));

subplot(1, 2, 1);
stem(1:55, filter(b, a, samples));

subplot(1, 2, 2);
stem(1:55, conv(b / a, samples));
