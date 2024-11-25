# Aptos testnet Autodeploy

This action lets you provide a publish command and an address to check on testnet.

Use this action to keep your package deployed on testnet.

Example:

```yaml
name: Publish Check

on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master
  schedule:
    - cron: '* * * * *' # Every minute

jobs:
  testnet-autodeploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v2

      - name: Check and Publish
        uses: jillxuu/aptos-testnet-deploy@master # Can use a pinned commit hash
        with:
          package_dir: example/aptos-testnet-autodeploy
          check_address: "0x7fd244ebf577f646130c97de424c480ce761729130d5fb433b7dd312574eaddc"
          named_addresses: module_addr=0x7fd244ebf577f646130c97de424c480ce761729130d5fb433b7dd312574eaddc
          private_key: ${{ secrets.PRIVATE_KEY }}
          upgrade_allowed: true

```
