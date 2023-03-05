% SPDX-License-Identifier: GPL-3.0-or-later
%
% is_orthonormal.m -- check for orthonormal column vectors
% Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

function orthonormal = is_orthonormal(A)
	[~, c] = size(A);

	orthonormal = false;

	for i = 1:c
		for j = (i + 1):c
			if dot(A(:, i), A(:, j))
				return;
			end
		end
	end

	for i = 1:c
		if eps(norm(A(:, i)) - 1) > eps(1)
			return;
		end
	end

	orthonormal = true;
end
