# Shorts Video Toolkit

Starter kit for making vertical videos (TikTok, Reels, YouTube Shorts) with code. Everything is 1080x1920, 30 fps, and all fonts and sound effects are local, so it works offline.

- `remotion-shorts/` — Remotion (React) template: scene transitions, pop-in hook text, word-by-word captions, TikTok safe-area guide.
- `hyperframes-shorts/` — the same idea in HTML + GSAP (HyperFrames).
- `tools/` — helpers for raw footage: make horizontal video vertical, cut silences, transcribe to word timings, loudness for social apps.
- `skills/install-extra-skills.sh` — installs extra video skills for Claude Code.

## How to run

Needs Node.js 18+, ffmpeg and Python 3.

```bash
./setup.sh               # one-time install
cd remotion-shorts
npm run dev              # opens Remotion Studio in the browser
npm run render           # makes out/short.mp4
```

Full details: see [GUIDE.md](GUIDE.md).

## Notes
- Sound effects were made from scratch with ffmpeg (`tools/make-sfx.sh`), so no licence issues. Fonts are OFL (free).
- `node_modules` is not included. `npm install` brings it back.
