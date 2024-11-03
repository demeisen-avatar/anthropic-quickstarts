#!/bin/bash
set -e
cd "$(dirname "$0")/computer-use-demo"
docker build -t test .
