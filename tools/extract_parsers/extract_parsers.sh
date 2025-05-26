#!/bin/bash
# Copy parser sources and minimal dependencies to a standalone directory.
# Usage: ./extract_parsers.sh <destination_directory>
set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <destination_directory>" >&2
    exit 1
fi

DEST="$1"
mkdir -p "$DEST/limbo"

cp -r "$(dirname "$0")"/../../limbo/parsers "$DEST/limbo/"
cp -r "$(dirname "$0")"/../../limbo/math "$DEST/limbo/"
cp -r "$(dirname "$0")"/../../limbo/string "$DEST/limbo/"
cp -r "$(dirname "$0")"/../../limbo/preprocessor "$DEST/limbo/"
cp -r "$(dirname "$0")"/../../limbo/thirdparty "$DEST/limbo/"

cat > "$DEST/CMakeLists.txt" <<'CMAKE'
cmake_minimum_required(VERSION 3.7)
project(LimboParsers)
set(INSTALL_LIMBO ON CACHE BOOL "")
add_subdirectory(limbo/math)
add_subdirectory(limbo/string)
add_subdirectory(limbo/preprocessor)
add_subdirectory(limbo/thirdparty)
add_subdirectory(limbo/parsers)
CMAKE

echo "Standalone parser sources copied to $DEST"

