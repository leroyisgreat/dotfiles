#!/bin/sh

level=`amixer -c 1 sget Master | awk -F '[\\\[d]' '{print $3}' | awk -F '[-.]' '{print $2}'`
mute=`amixer -c 1 sget Master | awk -F '[\\\[\\\]%]' '{print $7}' | tr -d '[[:space:]]'`
bars=`expr $level / 6`

case $bars in
  10) bar='[░░░░░░░░░░]' ;;
  9)  bar='[█░░░░░░░░░]' ;;
  8)  bar='[██░░░░░░░░]' ;;
  7)  bar='[███░░░░░░░]' ;;
  6)  bar='[████░░░░░░]' ;;
  5)  bar='[█████░░░░░]' ;;
  4)  bar='[██████░░░░]' ;;
  3)  bar='[███████░░░]' ;;
  2)  bar='[████████░░]' ;;
  1)  bar='[█████████░]' ;;
  0)  bar='[██████████]' ;;
  *)  bar='[░░░░!!░░░░]' ;;
esac

if [ "$mute" == 'off' ]; then
    bar='[mute]'
fi

echo "Vol:" $bar

exit 0
