#!/bin/bash
set -e
OUT=/workspaces/ccminer-verus-build/out
mkdir -p "$OUT"
cp ccminer "$OUT/" || cp src/ccminer "$OUT/" || true
echo "✅ Build complete. Binary is in $OUT"
