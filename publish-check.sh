#!/bin/bash

ACTION_PATH="${ACTION_PATH}"
PACKAGE_DIR="${PACKAGE_DIR}"
CHECK_ADDRESS="${CHECK_ADDRESS}"
NAMED_ADDRESSES="${NAMED_ADDRESSES}"
PRIVATE_KEY="${PRIVATE_KEY}"
UPGRADE_ALLOWED="${UPGRADE_ALLOWED}"
testnet_URL="https://fullnode.testnet.aptoslabs.com/"
testnet_FAUCET_URL="https://faucet.testnet.aptoslabs.com/"

http_code=$(
  curl --write-out '%{http_code}' \
       --silent \
       --output /dev/null \
       ${testnet_URL}v1/accounts/$CHECK_ADDRESS/resource/0x1::code::PackageRegistry
)

if [ $http_code -eq 404 ] || [ "$UPGRADE_ALLOWED" = "true" ]; then
  nix-shell $ACTION_PATH/shell.nix --command "aptos init \
    --private-key=$PRIVATE_KEY \
    --network=testnet \
    --assume-yes"
  nix-shell $ACTION_PATH/shell.nix --command "aptos account fund-with-faucet \
    --account="$CHECK_ADDRESS" \
    --url="$testnet_URL" \
    --faucet-url="$testnet_FAUCET_URL""
  nix-shell $ACTION_PATH/shell.nix --command "aptos move publish \
    --package-dir="$PACKAGE_DIR" \
    --named-addresses="$NAMED_ADDRESSES" \
    --url="$testnet_URL" \
    --assume-yes"
elif [ $http_code -eq 200 ]; then
  echo "Package is already published at $CHECK_ADDRESS"
else
  echo "An unexpected error occurred. HTTP status code: $http_code"
fi
