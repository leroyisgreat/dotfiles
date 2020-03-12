#!/bin/sh

# see https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f for
# interesting bash argument parsing done well.

sink=`pactl list short sinks | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,'`
sour=`pactl list short sources | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,'`
if [[ -z $sink ]]
then
  sink=0
fi

while (( "$#" )); do
  case "$1" in
    -s)
      sink=$2
      shift 2
      ;;
    -u)
      notify-send "Sink: $sink
Volume +5%" -t 1000
      pactl -- set-sink-volume $sink +5%
      shift
      ;;
    -d)
      notify-send "Sink: $sink
Volume -5%" -t 1000
      pactl -- set-sink-volume $sink -5%
      shift
      ;;
    -m)
      notify-send "Sink: $sink
Volume Mute Toggle" -t 1000
      pactl set-sink-mute $sink toggle 
      shift
      ;;
    -p)
      notify-send "Source: $sour
Mic Mute Toggle" -t 1000
      pactl set-source-mute $sour toggle 
      shift
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

