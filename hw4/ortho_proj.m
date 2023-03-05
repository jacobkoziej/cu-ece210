% SPDX-License-Identifier: GPL-3.0-or-later
%
% ortho_proj.m -- project onto vector space
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

function x = ortho_proj(v, S)
	[r, c] = size(S);

	x = zeros(r, 1);

	for j = 1:c
		x = x + dot(v, S(:, j)) / dot(S(:, j), S(:, j)) * S(:, j);
	end
end
