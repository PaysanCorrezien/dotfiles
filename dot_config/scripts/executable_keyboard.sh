#!/bin/bash

layout=$(setxkbmap -query | grep layout | awk '{print $2}')

if [ "$layout" = "us" ]
then
    setxkbmap fr
else
    setxkbmap us altgr-intl
fi

