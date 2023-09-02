#!/bin/bash

# Setup:
# cd into the root directory
# chmod +x scripts/autotesh.sh 
#
# Usage:
# scripts/autotest.sh                         # run all tests
# scripts/autotest.sh -f <test_feature.py>    # run a specific test_file
# scripts/autotest.sh -s                      # run with logs and print statements (for debug)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$DIR/.."

# default variables
TEST_PATH="/docker-app/app/tests/"
SHOW_STDOUT=""

# parse command line args
while getopts ":f:s" opt; do
  case ${opt} in
    f )
      TEST_PATH="/docker-app/app/tests/$OPTARG";;
    s )
      SHOW_STDOUT="-s";;
    \? )
      echo "Usage: $0 [-f specific_test_file] [-s]"
      exit 1;;
    : )
      echo "Option -$OPTARG requires an argument." >&2
      exit 1;;
  esac
done

echo "=== Running Tests"

docker compose build web > /dev/null
echo "=== Built container"
 
docker compose up -d
echo "=== Container Running"

docker compose run -T web pytest $SHOW_STDOUT $TEST_PATH
echo "=== Ran Tests"
