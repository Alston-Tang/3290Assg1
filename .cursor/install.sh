#!/usr/bin/env bash
# Idempotent environment bootstrap for the 3290 Assignment 1 (MATLAB) repo.
#
# The assignment is written for MATLAB, which is proprietary and unavailable in
# Cloud Agents. GNU Octave (with the `image` package) is a MATLAB-compatible,
# open-source substitute that runs the multi-scale alignment pipeline unmodified
# (via the compatibility shims in .cursor/octave-compat and the repo .octaverc).
set -euo pipefail

# Octave pulls in a large dependency chain (MPI/RDMA/PETSc/...). The apt mirror
# used in Cloud Agents occasionally returns a transient "400 Bad Request" for a
# single .deb, which leaves a broken, half-configured install. Make the install
# resilient by (a) letting apt retry each download several times and (b)
# repairing any partial state with dpkg --configure / apt --fix-broken before
# retrying the whole install.
APT_OPTS=(-y --no-install-recommends -o Acquire::Retries=8)

octave_ready() {
    command -v octave >/dev/null 2>&1 && octave --version >/dev/null 2>&1
}

install_octave() {
    local attempt
    for attempt in 1 2 3 4 5; do
        echo "apt install attempt ${attempt}..."
        sudo apt-get update -qq -o Acquire::Retries=8 || true
        # Recover from any previous partial/broken install.
        sudo dpkg --configure -a || true
        sudo apt-get "${APT_OPTS[@]}" --fix-broken install || true
        # fonts-freefont-otf provides FreeSans.otf, which Octave's plotting
        # (imshow/print) needs to render axis text; without it imshow errors
        # with "ft_text_renderer: invalid bounding box" in offscreen/headless mode.
        sudo apt-get "${APT_OPTS[@]}" install octave octave-image fonts-freefont-otf || true
        if octave_ready; then
            return 0
        fi
        echo "apt install attempt ${attempt} did not yield a working octave; retrying..."
        sleep $((attempt * 5))
    done
    echo "Failed to install a working octave after multiple attempts." >&2
    return 1
}

if octave_ready; then
    echo "Octave already installed: $(octave --version | head -1)"
else
    echo "Octave not found; installing octave + octave-image..."
    install_octave
fi

# Sanity check: confirm Octave can load the image package, the shims resolve,
# and headless plotting (imshow) actually renders -- the assignment scripts call
# imshow before imwrite, so a missing font would break them at runtime.
QT_QPA_PLATFORM=offscreen octave --no-gui --eval "
    pkg load image;
    addpath(fullfile('$(pwd)', '.cursor', 'octave-compat'));
    assert(exist('imgaussfilt') == 2, 'imgaussfilt shim missing');
    assert(exist('websave') == 2, 'websave shim missing');
    assert(exist('imread') > 0, 'imread unavailable');
    f = figure('visible', 'off');
    imshow(rand(16, 16, 3));
    print(f, fullfile(tempdir(), 'octave_imshow_smoke.png'), '-dpng');
    close(f);
    disp('Octave environment ready.');
"
