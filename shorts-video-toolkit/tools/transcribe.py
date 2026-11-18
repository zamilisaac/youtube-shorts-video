#!/usr/bin/env python3
"""Word-level transcript for TikTok-style captions.
Usage: python3 transcribe.py input.mp4 [captions.json] [model]
Writes [{text,startMs,endMs}, ...] which plugs straight into the Remotion
<WordCaptions words={...}/> component. Also writes a .srt next to it.
Needs: pip install faster-whisper   (first run downloads the model)
"""
import json, sys
from faster_whisper import WhisperModel

src = sys.argv[1]
out = sys.argv[2] if len(sys.argv) > 2 else src.rsplit(".", 1)[0] + "_captions.json"
model = WhisperModel(sys.argv[3] if len(sys.argv) > 3 else "small", compute_type="int8")
segments, _ = model.transcribe(src, word_timestamps=True, vad_filter=True)
words, srt = [], []
for i, seg in enumerate(segments, 1):
    for w in seg.words or []:
        words.append({"text": w.word.strip(), "startMs": int(w.start * 1000), "endMs": int(w.end * 1000)})
    ts = lambda t: f"{int(t//3600):02}:{int(t%3600//60):02}:{int(t%60):02},{int(t*1000%1000):03}"
    srt.append(f"{i}\n{ts(seg.start)} --> {ts(seg.end)}\n{seg.text.strip()}\n")
json.dump(words, open(out, "w"), indent=1)
open(out.rsplit(".", 1)[0] + ".srt", "w").write("\n".join(srt))
print(f"{len(words)} words -> {out}")
