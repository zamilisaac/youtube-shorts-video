#!/usr/bin/env bash
# Turn any horizontal/square clip into 1080x1920.
# Usage: ./reframe-9x16.sh input.mp4 output.mp4 [blur|crop]
#   blur (default): fit video in center over a blurred, zoomed copy of itself
#   crop: center-crop to fill the frame
set -e
IN="$1"; OUT="${2:-vertical.mp4}"; MODE="${3:-blur}"
if [ "$MODE" = "crop" ]; then
  VF="scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,setsar=1"
  ffmpeg -y -i "$IN" -vf "$VF" -c:v libx264 -crf 18 -preset medium -c:a aac -b:a 192k "$OUT"
else
  ffmpeg -y -i "$IN" -filter_complex "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=30:5[bg];[0:v]scale=1080:-2[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2,setsar=1" -c:v libx264 -crf 18 -preset medium -c:a aac -b:a 192k "$OUT"
fi
