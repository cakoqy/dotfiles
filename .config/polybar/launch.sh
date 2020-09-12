#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=DVI-D-0 ~/usr/src/polybar/build/bin/polybar -q example &
MONITOR=DVI-I-1 ~/usr/src/polybar/build/bin/polybar -q example &
MONITOR=HDMI-0 ~/usr/src/polybar/build/bin/polybar -q example &

echo "Bars launched..."
