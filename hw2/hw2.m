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
