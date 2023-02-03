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


%% The Long Sssss
exp_100    = exp(-(linspace(0, 6.66, 100)    .^ 2));
exp_10_000 = exp(-(linspace(0, 6.66, 10_000) .^ 2));

erf_100    = erf(linspace(0, 6.66, 100));
erf_10_000 = erf(linspace(0, 6.66, 10_000));

diff_exp_100    = diff(exp_100)    ./ diff(linspace(0, 6.66, 100));
diff_exp_10_000 = diff(exp_10_000) ./ diff(linspace(0, 6.66, 10_000));
diff_erf_100    = diff(erf_100)    ./ diff(linspace(0, 6.66, 100));
diff_erf_10_000 = diff(erf_10_000) ./ diff(linspace(0, 6.66, 10_000));

diff_mse_100    = mean((diff_exp_100    - diff_erf_100)    .^ 2);  % 0.3832
diff_mse_10_000 = mean((diff_exp_10_000 - diff_erf_10_000) .^ 2);  % 0.3833

dx_100    = (6.66 - 0) / (100 - 1);
dx_10_000 = (6.66 - 0) / (10_000 - 1);

cumsum_exp_100      = (2 / sqrt(pi)) * (cumsum(exp_100)      * dx_100);
cumsum_exp_10_000   = (2 / sqrt(pi)) * (cumsum(exp_10_000)   * dx_10_000);
cumtrapz_exp_100    = (2 / sqrt(pi)) * (cumtrapz(exp_100)    * dx_100);
cumtrapz_exp_10_000 = (2 / sqrt(pi)) * (cumtrapz(exp_10_000) * dx_10_000);

cumsum_mse_100      = mean((cumsum_exp_100      - erf_100)    .^ 2);  % 1.9687e-03
cumsum_mse_10_000   = mean((cumsum_exp_10_000   - erf_10_000) .^ 2);  % 1.9210e-07
cumtrapz_mse_100    = mean((cumtrapz_exp_100    - erf_100)    .^ 2);  % 1.6877e-08
cumtrapz_mse_10_000 = mean((cumtrapz_exp_10_000 - erf_10_000) .^ 2);  % 1.6373e-16

plot(linspace(0, 6.66, 10_000), cumtrapz_exp_10_000);
title("Cool Title");
% cumtrapz() nets a better estimate as it uses a trapezoidal integration method
