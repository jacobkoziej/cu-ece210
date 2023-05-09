% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw7.m -- homework #7
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
clear;
close all;


%% Cheating at Calculus

%% 1
syms x y(x);

eq = diff(y) == y^2 * x^3;
S_1 = dsolve(eq, y(0) == 1);
S_2 = dsolve(eq, y(0) == 2);
S_3 = dsolve(eq, y(0) == 3);

figure;
hold on;
title('1');
fplot(S_1, [0, 4]);
fplot(S_2, [0, 4]);
fplot(S_3, [0, 4]);


%% 2
syms h(t) t;

H = laplace(5*dirac(t) + heaviside(t) + exp(-t/2)*sin(3*t));
H

h = ilaplace(H);
h


%% 3
syms a t x y z;

F(x, y, z) = [(3 + a^2)*x*z; z*exp(y); exp(y) - x^2*exp(pi*a)];

r = [
	(1 - 2*cos(t))*cos(3*t);
	(1 - 2*cos(t))*sin(3*t);
	sin(t);
];

val = int(dot(F(r(1), r(2), r(3)), diff(r, t)), t, -pi, pi);

figure;
title('3');
fplot(val, a, [-3, 1]);


%% It Ain't Magic

%% 1
syms x, y;

f(x, y) = 1 - x^2 - y^2;

mF = matlabFunction(f);


%% 2
tic;
int(int(mF, y, [-sqrt(1 - x^2), sqrt(1 - x^2)]), x, 0, 1)
toc;
% Elapsed time is 0.052290 seconds.

tic;
% there will be no trapz() approximation for my sanity <3
toc;
% Elapsed time is 0.000030 seconds. <-- see how much faster this is!
