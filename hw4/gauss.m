% SPDX-License-Identifier: GPL-3.0-or-later
%
% gauss.m -- Gaussian function
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

function y = gauss(x, mu, sigma)
	y = 1 / sqrt(2 * pi * sigma.^2) * exp(-(x - mu).^2 / (2 * sigma.^2));
end
