import { interpolate, spring, useCurrentFrame, useVideoConfig } from "remotion";

// Big punchy text that springs in. Use for hooks / key lines.
export const PopText: React.FC<{ text: string; color?: string; size?: number; delay?: number }> = ({
  text, color = "#fff", size = 110, delay = 0,
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const s = spring({ frame: frame - delay, fps, config: { damping: 12, stiffness: 180 } });
  const rot = interpolate(s, [0, 1], [-6, 0]);
  return (
    <div
      style={{
        fontFamily: "Anton, sans-serif",
        fontSize: size,
        lineHeight: 1.05,
        color,
        textTransform: "uppercase",
        textAlign: "center",
        transform: `scale(${s}) rotate(${rot}deg)`,
        textShadow: "0 8px 0 rgba(0,0,0,0.35)",
      }}
    >
      {text}
    </div>
  );
};
