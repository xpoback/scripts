#!/bin/bash

for (( ; ; ))
do
  MEMORY_USAGE=`free | grep Mem | awk '{print $3/$2 * 100}'`
  MEMORY_USAGE=${MEMORY_USAGE%.*}

  if (( $(echo "$MEMORY_USAGE > 75" |bc -l) )); then
    notify-send 'Memory alert' "Memory usage is $MEMORY_USAGE%"
  fi

  if (( $(echo "$MEMORY_USAGE > 90" |bc -l) )); then
    zenity --warning --text="Danger of freezing!" --title="Memory alert!"
  fi

  sleep 10
done
