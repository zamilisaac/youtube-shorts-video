#!/usr/bin/env bash
# Final export with upload-safe settings: 1080x1920, 30fps, H.264 High, yuv420p, AAC 48k, faststart.
# Usage: ./export-tiktok.sh input.mp4 [output.mp4]
set -e
IN="$1"; OUT="${2:-${1%.*}_upload.mp4}"
ffmpeg -y -i "$IN" -vf "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2,fps=30,format=yuv420p" \
  -c:v libx264 -profile:v high -crf 18 -preset slow -c:a aac -b:a 192k -ar 48000 -movflags +faststart "$OUT"
