#!/bin/bash

INSTALL_DIR="/Volumes/Storage_2/Soft/Mac/2024_install/provision/pkgs_copy"

for FILE in "$INSTALL_DIR"/*; do
    # Check if the file is a .pkg file
    if [[ "$FILE" == *.pkg ]]; then
        echo "Installing $FILE in the background..."
        sudo installer -pkg "$FILE" -target / &

    # Check if the file is a .sh script
    elif [[ "$FILE" == *.sh ]]; then
        echo "Running script $FILE..."
        sudo bash "$FILE" &
        
        # Check if the script ran successfully
        if [ $? -eq 0 ]; then
            echo "$FILE executed successfully."
        else
            echo "Failed to execute $FILE."
        fi
    fi
done

# Wait for all background installations to finish
wait

echo "All packages and scripts processed."
