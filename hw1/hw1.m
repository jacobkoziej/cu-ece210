% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw1.m -- homework #1
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
close;
close all;


%% Scale-'ers
a = abs(sin(pi / 3) + j / sec(-5 * pi / 3));
l = 8 ^ (1 / 3);
u = (2 * sum((1:80) / factorial(6))) ^ (1 / 2);
m = (imag(floor(log(66 ^ (7j / 2))))) ^ 2;


%% Mother...?
A = [
	a;
	l;
	u;
	m;
];
F = [
	A(1, 1), A(2, 1);
	A(3, 1), A(4, 1);
];
T = transpose(F);
B = inv(T * F);
C = [
	T, F;
	F, T;
];


%% Cruelty
B_mean     = mean(B);
C_row_mean = mean(C, 2);


%% Odd Types
% regular matrix addition
T + F;
% cool that you can add to each element
T + 1;
% looks like we assume that if we have a dimension mismatch that the
% missing elements are zero
C + A;


%% Not What It Seems...
funky = @(k) sum(linspace(0, 10, k) .^ 2) / k;

% it looks like we've found a convoluted way to approximate 100/3
k_3       = funky(3);
k_5       = funky(5);
k_10      = funky(10);
k_300     = funky(300);
k_1000000 = funky(1000000);
