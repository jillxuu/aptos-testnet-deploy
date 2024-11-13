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
          check_address: "0x3cb93ebcabdb73a76c23df00c3176a14efe64b948ca4b319f88561068e77df2d"
          named_addresses: module_addr=0x3cb93ebcabdb73a76c23df00c3176a14efe64b948ca4b319f88561068e77df2d
          private_key: ${{ secrets.PRIVATE_KEY }}
          upgrade_allowed: true

```
