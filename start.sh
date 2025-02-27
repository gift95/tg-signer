#!/bin/bash

# Install tg-signer if it's not already installed
pip install -U tg-signer

# This line is for the initial configuration; comment it out after the first run
sleep infinity  # First-time setup; use this for initial configuration

# Uncomment the following line after the first configuration to run tg-signer
# tg-signer run mytasks
