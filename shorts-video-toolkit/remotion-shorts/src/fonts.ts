// Fonts are bundled locally in public/fonts (from @fontsource, OFL licensed) so renders work offline.
// loadFont() blocks rendering until each font is ready.
import { loadFont } from "@remotion/fonts";
import { staticFile } from "remotion";

const fonts: [string, string, string][] = [
  ["Anton", "anton-latin-400-normal.woff2", "400"],
  ["Bebas Neue", "bebas-neue-latin-400-normal.woff2", "400"],
  ["Inter", "inter-latin-400-normal.woff2", "400"],
  ["Inter", "inter-latin-800-normal.woff2", "800"],
  ["Montserrat", "montserrat-latin-700-normal.woff2", "700"],
  ["Montserrat", "montserrat-latin-900-normal.woff2", "900"],
];

export const loadAllFonts = () => {
  for (const [family, file, weight] of fonts) {
    loadFont({ family, url: staticFile(`fonts/${file}`), weight });
  }
}
