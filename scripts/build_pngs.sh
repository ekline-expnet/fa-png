#!/bin/bash
whichPython=`which python`
ppath=$PYTHONPATH
curdir=`pwd`
PYTHONPATH=$curdir/node_modules/icon-font-to-png:${ppath-$whichPython}
icon2png=$curdir/node_modules/icon-font-to-png/bin/icon-font-to-png

inputArgs=("$@")

python $icon2png --download font-awesome

pngoutdir=$curdir/images/fa

if [ -d $pngoutdir ]; then
  echo "removing old directory contents"
  rm -rf $pngoutdir/*
fi

for size in 16 32 48 64 80
do for color in "black #000000" "white"
  do
    #  The "--" prevents nasty surprises if $color is null or
    set -- $color
    fcolor=${2-$1}
    echo "creating icons for size=$size, color=$fcolor"
    # echo $fcolor $size
    python $icon2png --ttf fontawesome-webfont.ttf --css font-awesome.css \
      --color $fcolor \
      --size $size \
      --export_dir $pngoutdir/$1/$size ALL

    echo "creating circle-thin wrapped icons for size=$size, color=$fcolor"
    python $icon2png --ttf fontawesome-webfont.ttf --css font-awesome.css \
      --wrapper_icon circle-thin \
      --color $fcolor \
      --size $size \
      --export_dir $pngoutdir/circle/$1/$size ALL
  done
done
