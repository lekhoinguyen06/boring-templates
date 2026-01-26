#!/usr/bin/env bash
set -e

# Format all source files
echo "Formatting code..."
find . -name "*.cpp" -o -name "*.h" | grep -v build | xargs -r clang-format -i

# Build with CMake
echo "Building..."
cmake --build build

# Run
echo "Running..."
./build/index save text ./src/copyable