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


%% 2
i     = 1;
plots = length(keys(n_o)');

figure;

for k = keys(n_o)'
	b = b_o(k);
	b = b{1};
	a = a_o(k);
	a = a{1};

	[h, w] = freqz(b, a);

	H_dB = 20*log10(h);
	H_deg = rad2deg(unwrap(angle(h)));

	subplot(plots, 2, i);
	plot(w, H_dB);
	title(strcat('Magnitude Response (', k, ')'));
	xlabel('Frequency [rad]');
	ylabel('|H| [dB]');
	xlim([0, pi]);
	xticks([0, pi/2, pi]);
	xticklabels({'0', '\pi/2', '\pi'})

	i = i + 1;

	subplot(plots, 2, i);
	plot(w, H_deg);
	title(strcat('Phase Response (', k, ')'));
	xlabel('Frequency [rad]');
	ylabel('Phase [deg]');
	xlim([0, pi]);
	xticks([0, pi/2, pi]);
	xticklabels({'0', '\pi/2', '\pi'})

	i = i + 1;
end


%% 3
s = 2;

noise = wgn(f_s*s, 1, 1);

y_o = dictionary;

for k = keys(n_o)'
	b = b_o(k);
	b = b{1};
	a = a_o(k);
	a = a{1};
	y = filter(b, a, noise);

	y_o(k) = {y};
end


%% 4
n = length(y); 

i     = 1;
plots = length(keys(n_o)');

figure;
sgtitle('Fourier Transform of Gaussian Noise');

for k = keys(y_o)'
	y = y_o(k);
	y = y{1};

	S = fft(y, n);
	S = fftshift(abs(S)) / n;

	f = f_s .* (-n/2:n/2) ./ n;
	f = f(2:end);

	subplot(plots, 1, i);
	plot(f, S);
	title(k);
	xlabel('Frequency [Hz]');
	ylabel('|S|');

	i = i + 1;
end
