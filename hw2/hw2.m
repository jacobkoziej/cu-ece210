% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw2.m -- homework #2
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
close;
close all;


%% Space
A         = reshape(exp(0:63), 8, 8);
B         = A(3:6, 3:6);
B_geomean = prod(B(:)) ^ (1 / numel(B));
A(:, 1)   = flipud(A(:, 1));
A(4:5, :) = [ ];


%% Speed
funky = @(a, b) sin(abs(a + j*b)) ./ abs(a + j*b);

n    = 10_000;
step = 1_000*pi / n;

% Elapsed time is 5150.45 seconds.
disp("loop with no preallocation")
tic;
for a = 0:n
	for b = 0:n
		C(a + 1, b + 1) = funky(a*step, b*step);
	end
end
toc;

% Elapsed time is 3151.23 seconds.
disp("loop with preallocation")
tic;
C = zeros(n, n);
for a = 0:n
	for b = 0:n
		C(a + 1, b + 1) = funky(a*step, b*step);
	end
end
toc;

% Elapsed time is 11.5094 seconds.
disp("meshgrid")
tic;
a = linspace(0, 1_000*pi, 10_000);
b = linspace(0, 1_000*pi, 10_000);
[AA, BB] = meshgrid(a, b);
C = funky(AA, BB);
toc;

% Elapsed time is 6.91401 seconds.
disp("broadcasting")
tic;
a = linspace(0, 1_000*pi, 10_000);
b = a';
C = funky(a, b);
toc;

surf(C(1:50, 1:50));
title("Cool Title");
xlabel("Funky x-axis");
ylabel("Funky y-axis");
