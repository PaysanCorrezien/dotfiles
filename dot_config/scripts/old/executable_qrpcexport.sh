#!/bin/bash

# Use zenity to create a file selection dialog
files=$(zenity --file-selection --multiple --separator=" ")

# Start a new terminal window and run qrcp with the selected files
kitty --class=qrcp-files -e bash -c 'printf "\033]0;qrcp-files\033\\"; qrcp '"$files"'; read -n1 -t 60 -s -r -p "Press any key to close this window or wait 60 seconds ..."'
# #!/bin/bash

# # Check if the script is running in a terminal window
# if [ -t 1 ]; then
#     # Use zenity to create a file selection dialog
#     files=$(zenity --file-selection --multiple --separator=" ")

#     # Create a QR code using qrcp
#     qrcp $files
# else
#     # Use i3-msg to open a new terminal window and run the script
#     i3-msg exec "kitty -e $HOME/.config/scripts/qrpcexport.sh"
# fi

