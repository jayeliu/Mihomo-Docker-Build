#!/bin/bash

set -e

SOURCE_DIR="/app"
TARGET_DIR="/config"

mkdir -p "$TARGET_DIR"

for item in "$SOURCE_DIR"/*; do
    name=$(basename "$item")
    [ "$name" = "mihomo" ] && continue
    [[ "$name" == *.sh ]] && continue
    [ ! -e "$TARGET_DIR/$name" ] && cp -r "$item" "$TARGET_DIR/"
done
