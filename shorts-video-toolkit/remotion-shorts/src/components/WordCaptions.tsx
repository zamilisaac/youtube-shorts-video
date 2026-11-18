import { useCurrentFrame, useVideoConfig } from "remotion";

export type Word = { text: string; startMs: number; endMs: number };

// TikTok-style captions: shows a few words at a time, highlights the active word.
// Feed it words from @remotion/captions / whisper (see scripts/transcribe.py).
export const WordCaptions: React.FC<{ words: Word[]; perPage?: number; highlight?: string }> = ({
  words, perPage = 3, highlight = "#FFD400",
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const ms = (frame / fps) * 1000;
  const idx = words.findIndex((w) => ms >= w.startMs && ms < w.endMs);
  if (idx === -1) return null;
  const pageStart = Math.floor(idx / perPage) * perPage;
  const page = words.slice(pageStart, pageStart + perPage);
  return (
    <div style={{ fontFamily: "Montserrat, sans-serif", fontWeight: 900, fontSize: 84, textAlign: "center", textTransform: "uppercase", WebkitTextStroke: "3px #000", paintOrder: "stroke" }}>
      {page.map((w, i) => (
        <span key={i} style={{ color: pageStart + i === idx ? highlight : "#fff", margin: "0 12px", display: "inline-block", transform: pageStart + i === idx ? "scale(1.12)" : undefined }}>
          {w.text}
        </span>
      ))}
    </div>
  );
};
