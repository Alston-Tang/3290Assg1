function B = imgaussfilt(A, sigma)
% IMGAUSSFILT  Octave compatibility shim for MATLAB's imgaussfilt.
%   B = IMGAUSSFILT(A) filters image A with a 2-D Gaussian smoothing kernel
%   with standard deviation 0.5 (MATLAB's default).
%   B = IMGAUSSFILT(A, SIGMA) uses the given standard deviation.
%
%   This mirrors MATLAB's default behaviour: the kernel size is
%   2*ceil(2*SIGMA)+1 and borders are handled with symmetric ('replicate')
%   padding. It lets code written for the MATLAB Image Processing Toolbox
%   run unmodified under GNU Octave (with the `image` package loaded).

    if nargin < 2 || isempty(sigma)
        sigma = 0.5;
    end

    ksize = 2 * ceil(2 * sigma) + 1;
    h = fspecial('gaussian', ksize, sigma);
    B = imfilter(A, h, 'replicate', 'same');
end
