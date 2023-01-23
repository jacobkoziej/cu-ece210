% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw1.m -- homework # 1
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
