#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
echo "Enter tag for this build:"

# shellcheck disable=SC2162
read tag
docker build --tag="$tag" .

# Step 2:
#List docker images
docker image ls

# Step 3:
# Run the app
docker run -p 8501:8501 --rm --name=btc-roc "$tag"
