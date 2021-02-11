#!/bin/sh

# Based off of
# https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f

# TODO: replace sed with something more readable, probably awk
snk=`pactl list short sinks | grep 'RUNNING\|IDLE\|SUSPENDED' | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,'`
src=`pactl list short sources | grep 'RUNNING\|IDLE\|SUSPENDED' | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,'`
if [[ -z $snk ]]; then
  snk=0
fi

if [[ -z $src ]]; then
  # For whatever reason, there are two sources where 0 is a dummy
  # TODO: find a more reliable way to do this
  src=1
fi

while (( "$#" )); do
  case "$1" in
    -s)
      snk=$2
      shift 2
      ;;
    -u)
      notify-send "Sink: $snk
Volume +5%" -t 1000
      pactl -- set-sink-volume $snk +5%
      shift
      ;;
    -d)
      notify-send "Sink: $snk
Volume -5%" -t 1000
      pactl -- set-sink-volume $snk -5%
      shift
      ;;
    -m)
      notify-send "Sink: $snk
Volume Mute Toggle" -t 1000
      pactl set-sink-mute $snk toggle 
      shift
      ;;
    -p)
      notify-send "Source: $src
Mic Mute Toggle" -t 1000
      pactl set-source-mute $src toggle 
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done
