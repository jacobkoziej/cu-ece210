% SPDX-License-Identifier: GPL-3.0-or-later
%
% hw6.m -- homework #6
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

clc;
clear;
close all;


% f_s = 44.1 kHz
%
% Class             | Type     | R_{pass} | R_{stop} | f_{pass}       | f_{stop}
% ------------------+----------+----------+----------+----------------+---------------
% Butterworth       | bandpass | 1 dB     | 50 dB    | f_s/6, f_s/3   | f_s/7, f_s/2.5
% Elliptic          | bandstop | 1 dB     | 50 dB    | f_s/7, f_s/2.5 | f_s/6, f_s/3
% Chebyshev Type I  | lowpass  | 5 dB     | 40 dB    | f_s/9          | f_s/8
% Chebyshev Type II | highpass | 5 dB     | 40 dB    | f_s/3          | f_s/4
