% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw3.m -- homework #3
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
close;
close all;


%% Space Between
A = reshape(exp(0:63), 8, 8);
A(3:6, 3:6) = 0;
geomean_A = geomean(A(A > 0));

B = sin(linspace(0, 5, 100).*linspace(-5, 0, 100).');
[_, I] = sort(abs(B - 1/2)(:));
[X, Y] = ind2sub(size(B), I);

f   = @(x, y) (1/4).*sqrt(x.^2 + y.^2);
g   = @(x, y) exp(-(1 - x.*y).^2);
vol = integral2(f, -4, 4, -4, 4) - integral2(g, -4, 4, -4, 4);
