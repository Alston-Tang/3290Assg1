function outfilename = websave(filename, url, varargin)
% WEBSAVE  Octave compatibility shim for MATLAB's websave.
%   OUTFILENAME = WEBSAVE(FILENAME, URL) downloads the content at URL and
%   saves it to FILENAME, returning the saved path. Implemented on top of
%   Octave's urlwrite so code written for MATLAB runs unmodified.

    [~, success, msg] = urlwrite(url, filename);
    if ~success
        error('websave:downloadFailed', 'Failed to download %s: %s', url, msg);
    end
    outfilename = filename;
end
