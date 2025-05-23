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
# TODO: Configure project and environment variables


###############################################
# BUILD
###############################################
echo "================= 0909 BUILD START 0909 ================="
# TODO: Build the project if needed. Note that we are developing the project and making changes to it, even if it has been build before, we need to build it again.
python -m pip install -e .
echo "================= 0909 BUILD END 0909 ================="
