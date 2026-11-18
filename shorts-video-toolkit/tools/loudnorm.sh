#!/usr/bin/env bash
# Normalize audio to -14 LUFS (TikTok/YouTube/Instagram loudness target).
# Usage: ./loudnorm.sh input.mp4 [output.mp4]
set -e
IN="$1"; OUT="${2:-${1%.*}_norm.mp4}"
ffmpeg -y -i "$IN" -c:v copy -af "loudnorm=I=-14:TP=-1.5:LRA=11" -c:a aac -b:a 192k "$OUT"
