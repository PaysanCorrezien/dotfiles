#!/bin/bash

kitty --class=qrcp-files -e bash -c 'qrcp receive; read -t 60 -n1 -s -r -p "Press any key to close this window or wait 60 seconds..."'


