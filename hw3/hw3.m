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


%% I Need a Vactation
d = 256;
a = 1:d;
b = a';

% moon
A = true(d);
A(sqrt((a - 99).^2 + (b - 99).^2) >= 29) = 0;

% so true!!
B = true(d);
A(sqrt((a - 62).^2 + (b - 62).^2) >= 58) = 0;

% vertical waves
C = true(d);
C(a - 4*sin(b/10) <= 200) = 0;

% blue static
S = rand(a(end), b(end), 3);
S(:, :, 1:2) = 0;

% more moon action
M = A & B.';

% setting the scene
Z = (C .* S) + M;

imshow(Z);
