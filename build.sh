#!/bin/sh
# Common Setup, DO NOT MODIFY
cd /app
set -e

# COMPLETE THE FOLLOWING SECTIONS
###############################################
# PROJECT DEPENDENCIES AND CONFIGURATION
###############################################
# TODO: Install project dependencies if needed based on relevant config/lock files in the repo.
# Note that we are developing the project, even if dependencies have been installed before, we need to install again to accommodate the changes we made.
pip install --no-cache-dir --upgrade pip
pip install --no-cache-dir -e ".[test]"

# Configure environment variables needed by some helper scripts. These defaults
# ensure the tools behave predictably during local development.
export GFTOOLS_SUBSETTER=${GFTOOLS_SUBSETTER:-pyftsubset}


###############################################
# BUILD
###############################################
echo "================= 0909 BUILD START 0909 ================="
# Reinstall the package to ensure any local changes are reflected
python -m pip install -e .
echo "================= 0909 BUILD END 0909 ================="
