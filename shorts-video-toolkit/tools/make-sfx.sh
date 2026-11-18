#!/usr/bin/env bash
# Generates an original, royalty-free SFX pack with ffmpeg only (no downloads).
# Output: public/sfx/*.wav  — safe to use commercially (you own them).
set -e
OUT="${1:-public/sfx}"; mkdir -p "$OUT"
F="ffmpeg -y -hide_banner -loglevel error"
# whoosh: filtered noise with sweeping bandpass + fade
$F -f lavfi -i "anoisesrc=d=0.6:c=pink:a=0.8" -af "highpass=f=300,lowpass=f=4000,afade=t=in:d=0.25,afade=t=out:st=0.3:d=0.3,volume=1.5" "$OUT/whoosh.wav"
$F -f lavfi -i "anoisesrc=d=0.35:c=white:a=0.6" -af "highpass=f=1200,afade=t=in:d=0.12,afade=t=out:st=0.15:d=0.2" "$OUT/swoosh-fast.wav"
# pop
$F -f lavfi -i "sine=f=900:d=0.08" -af "asetrate=44100*1.0,afade=t=out:st=0.01:d=0.07,volume=2" "$OUT/pop.wav"
# click / tick
$F -f lavfi -i "anoisesrc=d=0.02:c=white:a=1" -af "highpass=f=2000,afade=t=out:d=0.02" "$OUT/click.wav"
# ding (two partials)
$F -f lavfi -i "sine=f=1318:d=1.2" -f lavfi -i "sine=f=2637:d=1.2" -filter_complex "[0][1]amix=inputs=2,afade=t=out:st=0.02:d=1.18,volume=2" "$OUT/ding.wav"
# success chime (rising triad)
$F -f lavfi -i "sine=f=523:d=0.15" -f lavfi -i "sine=f=659:d=0.15" -f lavfi -i "sine=f=784:d=0.5" -filter_complex "[0][1][2]concat=n=3:v=0:a=1,afade=t=out:st=0.4:d=0.4" "$OUT/success.wav"
# error buzz
$F -f lavfi -i "aevalsrc='0.4*sgn(sin(2*PI*140*t))':d=0.35" -af "lowpass=f=1500,afade=t=out:st=0.25:d=0.1" "$OUT/error-buzz.wav"
# riser (sweep up)
$F -f lavfi -i "aevalsrc='0.3*sin(2*PI*(200+900*t*t/2)*t)':d=2" -af "afade=t=in:d=1.8,afade=t=out:st=1.9:d=0.1" "$OUT/riser.wav"
# bass drop / impact
$F -f lavfi -i "aevalsrc='0.9*sin(2*PI*(120*exp(-3*t))*t*3)*exp(-2.5*t)':d=1.2" -af "lowpass=f=300,volume=2" "$OUT/impact.wav"
# glitch
$F -f lavfi -i "aevalsrc='0.4*sgn(sin(2*PI*(400+300*sgn(sin(2*PI*30*t)))*t))':d=0.3" -af "acrusher=bits=4:samples=8,afade=t=out:st=0.2:d=0.1" "$OUT/glitch.wav"
# typing (10 keystrokes)
for i in $(seq 0 9); do printf "file 'k.wav'\nfile 's.wav'\n"; done > /tmp/typelist.txt
$F -f lavfi -i "anoisesrc=d=0.025:c=white:a=0.7" -af "bandpass=f=3000,afade=t=out:d=0.025" /tmp/k.wav
$F -f lavfi -i "anullsrc=r=44100:cl=mono" -t 0.07 /tmp/s.wav
(cd /tmp && $F -f concat -safe 0 -i typelist.txt "$OLDPWD/$OUT/typing.wav")
# camera shutter
$F -f lavfi -i "anoisesrc=d=0.03:c=white:a=1" -f lavfi -i "anoisesrc=d=0.05:c=brown:a=1" -filter_complex "[0]afade=t=out:d=0.03[a];[1]adelay=60,afade=t=out:st=0.06:d=0.05[b];[a][b]amix=inputs=2:normalize=0,highpass=f=800" "$OUT/shutter.wav"
# heartbeat-ish low thump
$F -f lavfi -i "aevalsrc='0.9*sin(2*PI*60*t)*exp(-12*t)':d=0.3" "$OUT/thump.wav"
ls -1 "$OUT"
