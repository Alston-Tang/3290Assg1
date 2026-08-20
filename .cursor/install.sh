#!/usr/bin/env bash
# Idempotent environment bootstrap for the 3290 Assignment 1 (MATLAB) repo.
#
# The assignment is written for MATLAB, which is proprietary and unavailable in
# Cloud Agents. GNU Octave (with the `image` package) is a MATLAB-compatible,
# open-source substitute that runs the multi-scale alignment pipeline unmodified
# (via the compatibility shims in .cursor/octave-compat and the repo .octaverc).
set -euo pipefail

if ! command -v octave >/dev/null 2>&1; then
    echo "Octave not found; installing octave + octave-image..."
    sudo apt-get update -qq
    sudo apt-get install -y --no-install-recommends octave octave-image
else
    echo "Octave already installed: $(octave --version | head -1)"
fi

# Sanity check: confirm Octave can load the image package and the shims resolve.
QT_QPA_PLATFORM=offscreen octave --no-gui --eval "
    pkg load image;
    addpath(fullfile('$(pwd)', '.cursor', 'octave-compat'));
    assert(exist('imgaussfilt') == 2, 'imgaussfilt shim missing');
    assert(exist('websave') == 2, 'websave shim missing');
    assert(exist('imread') > 0, 'imread unavailable');
    disp('Octave environment ready.');
"
