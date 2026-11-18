# Shorts toolkit (TikTok / Reels / YouTube Shorts)

Everything is set to **1080x1920, 30 fps**. All assets are local, so renders work offline.

## What's inside

| Folder | What it is |
|---|---|
| `remotion-shorts/` | Remotion 4.0.539 project (React). Composition `Short`, 15 s placeholder template with scene transitions, SFX on cuts, music bed, TikTok-style word captions, and a safe-area guide. |
| `hyperframes-shorts/` | HyperFrames 0.8.230 project (HTML + GSAP). Portrait canvas, local fonts, GSAP vendored, SFX wired in. |
| `tools/` | ffmpeg / Python helpers for raw footage. |
| `remotion-shorts/public/sfx/` (also `hyperframes-shorts/sfx/`) | 14 original sound effects. |

### Remotion packages installed
`@remotion/transitions` (fade, slide, wipe, flip, clock-wipe…), `@remotion/media` (Audio/Video), `@remotion/captions`, `@remotion/install-whisper-cpp`, `@remotion/shapes`, `@remotion/paths`, `@remotion/noise`, `@remotion/motion-blur`, `@remotion/layout-utils`, `@remotion/animation-utils`, `@remotion/lottie` + `lottie-web`, `@remotion/three` + `three` + `@react-three/fiber`, `@remotion/fonts`, `@remotion/google-fonts`, `@remotion/renderer`, Tailwind v4, plus `gsap` and `framer-motion`.

### Template components (`remotion-shorts/src/components`)
- `SafeArea`: keeps content clear of the TikTok/Reels UI (top bar, right-hand buttons, bottom caption). Turn on `showSafeArea` in Studio to see the guide.
- `PopText`: big spring-in text for hooks.
- `WordCaptions`: 3-words-at-a-time captions with the active word highlighted. Feed it the JSON from `tools/transcribe.py`.

### Fonts (OFL, free for commercial use)
Anton, Bebas Neue, Inter, Montserrat. Stored as .woff2 in `public/fonts` and `hyperframes-shorts/fonts`.

### Sound effects (you own these)
`whoosh`, `swoosh-fast`, `pop`, `click`, `ding`, `success`, `error-buzz`, `riser`, `impact`, `glitch`, `typing`, `shutter`, `thump`, `bed-ambient` (15 s music bed).
They were synthesized from scratch with ffmpeg (`tools/make-sfx.sh`), so there's no license or attribution needed. Re-run the script to regenerate or tweak them.
For more free sounds: Pixabay Sound Effects, Mixkit, and freesound.org (filter by CC0). Check each sound's license before using it.

## Quick start

```bash
./setup.sh                       # one-time install on your machine

cd remotion-shorts
npm run dev                      # Remotion Studio in the browser, edit props live
npm run render                   # -> out/short.mp4

cd ../hyperframes-shorts
npm run dev                      # HyperFrames preview
npm run render                   # -> renders/*.mp4
```

## Footage helpers (`tools/`)

```bash
tools/reframe-9x16.sh in.mp4 out.mp4 blur   # horizontal -> vertical (blur bg) or "crop"
tools/cut-silence.sh talk.mp4               # jump-cut out the pauses (auto-editor)
python3 tools/transcribe.py talk.mp4        # word timestamps JSON + .srt (faster-whisper)
tools/loudnorm.sh in.mp4                    # -14 LUFS for social platforms
tools/export-tiktok.sh in.mp4               # upload-safe H.264 / AAC / faststart export
```

Typical flow for a talking-head short: cut-silence, then reframe, then transcribe, then drop the clip + captions JSON into Remotion, then render, loudnorm, and export.

## Licensing notes
- Remotion is free for individuals and companies of up to 3 people; larger companies need a license (remotion.pro/license).
- HyperFrames, GSAP (free incl. all plugins since 2025), Three.js, Lottie, framer-motion, ffmpeg, auto-editor, faster-whisper: free/open source.
