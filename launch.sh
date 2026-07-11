#!/usr/bin/env bash
set -e
# Run the site locally using docsify
cd "$(dirname "$0")"
exec docsify serve docs