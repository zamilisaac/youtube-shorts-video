#!/usr/bin/env bash
# Reinstall the extra video/animation skills into a fresh cloud box (~/.claude/skills).
# The cloud box is ephemeral, so run this at the start of any thread that needs them.
# Installed 2026-11-08 at XQ's request. Usage: bash install-extra-skills.sh [--with-openmontage]
set -euo pipefail
S="$HOME/.claude/skills"; T="$HOME/tools"; mkdir -p "$S" "$T"
command -v rsync >/dev/null || (apt-get install -y -q rsync || (apt-get update -q && apt-get install -y -q rsync))

clone(){ [ -d "$T/$2" ] || git clone -q --depth 1 "https://github.com/$1" "$T/$2"; }

clone heygen-com/hyperframes hyperframes
clone greensock/gsap-skills gsap-skills
clone majidmanzarpour/threejs-game-skills threejs-game-skills
clone viettranx/3dviz-pro-max 3dviz-pro-max
for d in "$T"/hyperframes/skills/*/ "$T"/gsap-skills/skills/*/ "$T"/threejs-game-skills/skills/*/ "$T"/3dviz-pro-max/skills/*/; do
  [ -f "$d/SKILL.md" ] && rsync -a --exclude .git "$d" "$S/$(basename "$d")/"
done

for r in Vincentwei1021/video-shotcraft Tejashmakwana/motionmaxxing wheresryan22/anatomy achimala/dream-loop; do
  n=${r#*/}; clone "$r" "$n"; rsync -a --exclude .git "$T/$n/" "$S/$n/"
done

# Paper cutout: full papercut-explainer (skills + Remotion library + Python tools + self-test). ~0.7 GB.
clone 0xS4N4TG/papercut-explainer papercut-explainer
(cd "$T/papercut-explainer" && ./install.sh --mode standard --target claude --copy --yes)

# Desktop-only (need Blender on the user's own computer), cloned for reference only:
clone ahujasid/blender-mcp blender-mcp
clone arjun988/blender-skills blender-skills

if [ "${1:-}" = "--with-openmontage" ]; then
  clone calesthio/OpenMontage OpenMontage   # full pipeline; open that folder as the project to use it
fi
echo "Done. Skills in $S:"; ls "$S"
