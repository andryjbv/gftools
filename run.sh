#!/bin/bash
### COMMON SETUP; DO NOT MODIFY ###
set -e

# Ensure script runs from its directory so relative paths work
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
export PYTHONPATH="$SCRIPT_DIR/app/Lib:$PYTHONPATH"

# Ensure version file exists for scripts that import it
if [ ! -f "$SCRIPT_DIR/app/Lib/gftools/_version.py" ]; then
  echo "version = '0.0.0'" > "$SCRIPT_DIR/app/Lib/gftools/_version.py"
fi

# --- CONFIGURE THIS SECTION ---
# Replace this with your command to run all tests
run_all_tests() {
  echo "Running all tests..."
  set +e
  pushd "$SCRIPT_DIR/app" >/dev/null
  export GH_TOKEN=${GH_TOKEN:-dummy_token}
  pytest -vv tests --ignore=tests/push/test_servers.py --ignore=tests/test_gfgithub.py \
    > "$SCRIPT_DIR/stdout.txt" 2> "$SCRIPT_DIR/stderr.txt"
  popd >/dev/null
  set -e
  return 0
}

# Replace this with your command to run specific test files
run_selected_tests() {
  local test_files=("$@")
  echo "Running selected tests: ${test_files[@]}"
  set +e
  pushd "$SCRIPT_DIR/app" >/dev/null
  # Strip leading 'app/' from paths if present
  local adjusted_tests=()
  for test in "${test_files[@]}"; do
    if [[ "$test" == app/* ]]; then
      adjusted_tests+=("${test#app/}")
    else
      adjusted_tests+=("$test")
    fi
  done
  pytest -vv "${adjusted_tests[@]}" > "$SCRIPT_DIR/stdout.txt" 2> "$SCRIPT_DIR/stderr.txt"
  popd >/dev/null
  set -e
  return 0
}
# --- END CONFIGURATION SECTION ---


### COMMON EXECUTION; DO NOT MODIFY ###

# No args is all tests
if [ $# -eq 0 ]; then
  run_all_tests
  exit $?
fi

# Handle comma-separated input
if [[ "$1" == *","* ]]; then
  IFS=',' read -r -a TEST_FILES <<< "$1"
else
  TEST_FILES=("$@")
fi

# Run them all together
run_selected_tests "${TEST_FILES[@]}"
