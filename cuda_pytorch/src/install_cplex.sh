#!/bin/bash

# Ensure the script runs in interactive mode
set -e

# Define the local installation file path
SOURCE_PATH="/data/cls1-srv2-pool/cplex_studio2211.linux_x86_64.bin"
DEST_PATH="./cplex_studio2211.linux_x86_64.bin"

# Check if the source file exists
if [ ! -f "$SOURCE_PATH" ]; then
    echo "Error: Installation file $SOURCE_PATH does not exist. Please check the path."
    exit 1
fi

# Copy the file to the current directory
echo "Copying file: $SOURCE_PATH -> $DEST_PATH"
cp "$SOURCE_PATH" "$DEST_PATH"

echo "File successfully copied to $DEST_PATH"

# Modify permissions to make the file executable
chmod +x "$DEST_PATH"
echo "Permissions updated: $DEST_PATH is now executable."

# Ask for user confirmation before executing the file
echo "Preparing to execute $DEST_PATH..."
read -p "Confirm execution? (y/n): " execute_confirm
if [[ "$execute_confirm" != "y" ]]; then
    echo "Execution canceled."
    exit 1
fi

# Execute the installation file
"$DEST_PATH"
