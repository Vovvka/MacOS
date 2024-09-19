#!/bin/bash

# Path to the script you want to execute
SCRIPT_PATH="/path/to/your/google_chrome_install.command"

# Assign execute permissions to the script
chmod +x "$SCRIPT_PATH"

# Use spctl to bypass Gatekeeper for this script
sudo spctl --add "$SCRIPT_PATH"

# Open the .command script
open "$SCRIPT_PATH"


#!/bin/bash

# Define the folder where your .command files are stored
FOLDER_PATH="/path/to/your/folder"

# Find all .command files in the folder and subfolders and assign execute permissions
find "$FOLDER_PATH" -type f -name "*.command" -exec chmod +x {} \;

echo "Execute permissions have been assigned to all .command files in $FOLDER_PATH."
