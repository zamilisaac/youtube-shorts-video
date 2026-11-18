#!/usr/bin/env bash
# Remove dead air / pauses from talking-head footage (jump-cut style).
# Usage: ./cut-silence.sh input.mp4 [output.mp4] [margin]
# Needs: pip install auto-editor
set -e
IN="$1"; OUT="${2:-${1%.*}_cut.mp4}"; MARGIN="${3:-0.15s}"
auto-editor "$IN" --margin "$MARGIN" --output "$OUT" --no-open
