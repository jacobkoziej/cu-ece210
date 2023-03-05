% SPDX-License-Identifier: GPL-3.0-or-later
%
% gram_schmidt.m -- gram–schmidt
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

function phi = gram_schmidt(psi)
	[~, c] = size(psi);

	phi = psi;

	for j = 1:c
		phi(:, j) = psi(:, j) / norm(psi(:, j));
	end
end
