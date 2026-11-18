import { AbsoluteFill } from "remotion";

// Keeps content clear of TikTok/Reels UI (top bar, right action rail, bottom caption area).
export const SAFE = { top: 220, bottom: 420, left: 60, right: 160 };

export const SafeArea: React.FC<{ children: React.ReactNode; debug?: boolean }> = ({ children, debug }) => (
  <AbsoluteFill
    style={{
      paddingTop: SAFE.top,
      paddingBottom: SAFE.bottom,
      paddingLeft: SAFE.left,
      paddingRight: SAFE.right,
      outline: debug ? "4px dashed rgba(255,0,0,0.6)" : undefined,
      outlineOffset: -4,
    }}
  >
    {children}
  </AbsoluteFill>
);
