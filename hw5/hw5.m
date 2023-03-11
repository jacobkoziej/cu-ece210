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


%% Pole-y Moley
load 'handel.mat'
[y, fs] = audioread('handel.mat');
soundsc(y, fs);

% this appears to be a elliptic filter
[b, a] = zp2tf(                                                         ...
	[.74*exp(.76j); .74*exp(-.76j); .96*exp(1.24j); .96*exp(1.24)], ...
	[exp(2.06j); exp(-2.06j); exp(1.43j); exp(-1.43j)],             ...
	.1);
[H, w] = freqz(b, a);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2, 1, 1);
plot(w, Hdb);
xlabel("Frequency (rad)");
ylabel("|H| (dB)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Magnitude Response");

subplot(2, 1, 2);
plot(w, Hph);
xlabel("Frequency (rad)");
ylabel("Phase (deg)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Phase Response");
