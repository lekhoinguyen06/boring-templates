#!/usr/bin/env bash

# Watch for changes in source files and rebuild
# Install with: brew install watchexec
watchexec -c -e cpp,h --ignore build -- ./dev.sh