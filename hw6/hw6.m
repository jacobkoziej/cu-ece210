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


%% 1
f_s       = 44.1e3;
f_nyquist = f_s / 2;

b_o  = dictionary;
a_o  = dictionary;
n_o  = dictionary;
Wn_o = dictionary;

Wp = [f_s/6,   f_s/3] / f_nyquist;
Ws = [f_s/7, f_s/2.5] / f_nyquist;
Rp = 1;
Rs = 50;
[n, Wn] = buttord(Wp, Ws, Rp, Rs);
[b, a]  = butter(n, Wn);

b_o('Butterworth')  = {b};
a_o('Butterworth')  = {a};
n_o('Butterworth')  = n;
Wn_o('Butterworth') = {Wn};

Wp = [f_s/7, f_s/2.5] / f_nyquist;
Ws = [f_s/6,   f_s/3] / f_nyquist;
Rp = 1;
Rs = 50;
[n, Wn] = ellipord(Wp, Ws, Rp, Rs);
[b, a]  = ellip(n, Rp, Rs, Wn);

b_o('Elliptic')  = {b};
a_o('Elliptic')  = {a};
n_o('Elliptic')  = n;
Wn_o('Elliptic') = {Wn};

Wp = f_s/9 / f_nyquist;
Ws = f_s/8 / f_nyquist;
Rp = 5;
Rs = 40;
[n, Wn] = cheb1ord(Wp, Ws, Rp, Rs);
[b, a]  = cheby1(n, Rp, Wp);

b_o('Chebyshev Type I')  = {b};
a_o('Chebyshev Type I')  = {a};
n_o('Chebyshev Type I')  = n;
Wn_o('Chebyshev Type I') = {Wn};

Wp = f_s/3 / f_nyquist;
Ws = f_s/4 / f_nyquist;
Rp = 5;
Rs = 40;
[n, Wn] = cheb2ord(Wp, Ws, Rp, Rs);
[b, a]  = cheby2(n, Rs, Ws);

b_o('Chebyshev Type II')  = {b};
a_o('Chebyshev Type II')  = {a};
n_o('Chebyshev Type II')  = n;
Wn_o('Chebyshev Type II') = {Wn};
