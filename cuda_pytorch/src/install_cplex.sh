#!/bin/bash

# Ensure the script runs in interactive mode
set -e

# Check if an IP address is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <IPv4 Address>"
    exit 1
fi

IP_ADDRESS=$1
REMOTE_USER="speed"
REMOTE_PATH="Downloads/cplex_studio2211.linux_x86_64.bin"
LOCAL_PATH="./cplex_studio2211.linux_x86_64.bin"

echo "Copying file from ${REMOTE_USER}@${IP_ADDRESS}:${REMOTE_PATH} to ${LOCAL_PATH}..."
# Execute SCP for remote copying
scp "${REMOTE_USER}@${IP_ADDRESS}:${REMOTE_PATH}" "${LOCAL_PATH}"
if [ $? -ne 0 ]; then
    echo "SCP failed. Please check the network or permissions."
    exit 1
fi

echo "File successfully copied to ${LOCAL_PATH}"

# Modify permissions
chmod +x "${LOCAL_PATH}"
echo "Permissions updated: ${LOCAL_PATH} is now executable."

# Execute the file
echo "Preparing to execute ${LOCAL_PATH}..."
read -p "Confirm execution? (y/n): " execute_confirm
if [[ "$execute_confirm" != "y" ]]; then
    echo "Execution canceled."
    exit 1
fi

"${LOCAL_PATH}"
