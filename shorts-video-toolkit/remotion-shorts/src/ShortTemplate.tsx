import { loadAllFonts } from "./fonts";
loadAllFonts();
import { AbsoluteFill, Sequence, staticFile } from "remotion";
import { Audio } from "@remotion/media";
import { TransitionSeries, linearTiming, springTiming, TransitionPresentation } from "@remotion/transitions";
import { fade } from "@remotion/transitions/fade";
import { slide } from "@remotion/transitions/slide";
import { wipe } from "@remotion/transitions/wipe";
import { z } from "zod";
import { SafeArea } from "./components/SafeArea";
import { PopText } from "./components/PopText";
import { WordCaptions } from "./components/WordCaptions";

// Placeholder-only template. Edit props in Remotion Studio's right panel or pass --props.
export const shortSchema = z.object({
  scenes: z.array(z.object({ text: z.string(), bg: z.string() })),
  showSafeArea: z.boolean(),
});

export const defaultShortProps: z.infer<typeof shortSchema> = {
  scenes: [
    { text: "Scene 1 hook", bg: "#111111" },
    { text: "Scene 2", bg: "#1f3a5f" },
    { text: "Scene 3", bg: "#3d1f5f" },
    { text: "Call to action", bg: "#111111" },
  ],
  showSafeArea: false,
};

const SCENE = 105; // frames per scene (3.5s @30fps)
const T = 15; // transition length

export const ShortTemplate: React.FC<z.infer<typeof shortSchema>> = ({ scenes, showSafeArea }) => {
  const presentations: TransitionPresentation<Record<string, unknown>>[] = [slide({ direction: "from-right" }), wipe({ direction: "from-left" }), fade()] as TransitionPresentation<Record<string, unknown>>[];
  return (
    <AbsoluteFill style={{ backgroundColor: "#000" }}>
      <TransitionSeries>
        {scenes.flatMap((s, i) => {
          const items = [
            <TransitionSeries.Sequence key={`s${i}`} durationInFrames={SCENE}>
              <AbsoluteFill style={{ backgroundColor: s.bg }}>
                <SafeArea debug={showSafeArea}>
                  <AbsoluteFill style={{ justifyContent: "center", alignItems: "center" }}>
                    <PopText text={s.text} />
                  </AbsoluteFill>
                </SafeArea>
              </AbsoluteFill>
            </TransitionSeries.Sequence>,
          ];
          if (i < scenes.length - 1) {
            items.push(
              <TransitionSeries.Transition
                key={`t${i}`}
                presentation={presentations[i % presentations.length]}
                timing={i % 2 ? linearTiming({ durationInFrames: T }) : springTiming({ durationInFrames: T })}
              />,
            );
          }
          return items;
        })}
      </TransitionSeries>

      {/* SFX on each cut */}
      {scenes.slice(1).map((_, i) => (
        <Sequence key={i} from={(i + 1) * (SCENE - T)} durationInFrames={20}>
          <Audio src={staticFile("sfx/whoosh.wav")} volume={0.8} />
        </Sequence>
      ))}
      <Sequence durationInFrames={20}><Audio src={staticFile("sfx/impact.wav")} /></Sequence>
      <Audio src={staticFile("sfx/bed-ambient.wav")} volume={0.25} />

      {/* Example captions slot — replace with real transcript words */}
      <AbsoluteFill style={{ justifyContent: "flex-end", paddingBottom: 480 }}>
        <WordCaptions words={[]} />
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
