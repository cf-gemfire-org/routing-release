#!/bin/bash

set -e

PACKAGE="$1"

if [[ -n "${PACKAGE}" ]]; then
  pushd "./src/code.cloudfoundry.org/${PACKAGE}"
    echo "Testing component: ${PACKAGE}"
    ./bin/test -flakeAttempts 3
  popd
else
  for component in cf-tcp-router multierror route-registrar routing-api routing-api-cli uaa-go-client; do
    pushd src/code.cloudfoundry.org/${component}
      echo "Testing component: ${component}..."
      ./bin/test --flakeAttempts=3
    popd
  done
fi
