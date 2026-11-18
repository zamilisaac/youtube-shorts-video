#!/usr/bin/env bash
# Installs the shorts toolkit on your own machine (macOS / Linux / WSL).
# Prereqs: Node.js 20+ (https://nodejs.org), Python 3.9+, ffmpeg (brew install ffmpeg / apt install ffmpeg)
set -e
cd "$(dirname "$0")"
command -v node >/dev/null || { echo "Install Node.js 20+ first"; exit 1; }
command -v ffmpeg >/dev/null || { echo "Install ffmpeg first (brew install ffmpeg)"; exit 1; }
npm install -g hyperframes
(cd remotion-shorts && npm install)
(cd hyperframes-shorts && npm install)
python3 -m pip install --user auto-editor faster-whisper moviepy pydub
chmod +x tools/*.sh tools/*.py remotion-shorts/scripts/*.sh
echo "Done. Try: cd remotion-shorts && npm run dev"
