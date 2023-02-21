% SPDX-License-Identifier: GPL-3.0-or-later
%
% deriv.m -- numerical differentiation
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

function ret = deriv(y, x)
	ret = diff(y) ./ diff(x);
end
