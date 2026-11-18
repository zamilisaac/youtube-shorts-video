import "./index.css";
import { Composition } from "remotion";
import { ShortTemplate, shortSchema, defaultShortProps } from "./ShortTemplate";

// Vertical 9:16 for TikTok / Reels / YouTube Shorts
export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="Short"
      component={ShortTemplate}
      schema={shortSchema}
      defaultProps={defaultShortProps}
      durationInFrames={30 * 15}
      fps={30}
      width={1080}
      height={1920}
    />
  );
};
