#!/bin/bash

# Use the first argument as the IP address, second as the GUI command
export DISPLAY=$1:0
export GDK_BACKEND=x11

# Execute the GUI command passed as the second argument
exec $2
