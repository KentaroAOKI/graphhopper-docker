#!/bin/bash

./scripts/make_config.sh

# Start the graphhopper process
java -Xmx8g -jar web/target/graphhopper-web-*-SNAPSHOT.jar server config/config.yml
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to run graphhopper: $status"
  exit $status
fi
