#!/bin/bash
USER=$(whoami)
HOUR=$(date +%H)

if [ $HOUR -lt 6 ]; then
    echo "Good night, $USER"
elif [ $HOUR -lt 12 ]; then
    echo "Good morning, $USER"
elif [ $HOUR -lt 17 ]; then
    echo "Good afternoon, $USER"
elif [ $HOUR -lt 21 ]; then
    echo "Good evening, $USER"
else
    echo "Good night, $USER"
fi

