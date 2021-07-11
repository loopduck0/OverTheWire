#!/bin/bash

# This was made when doing bandit 14 -> bandit 15 because I didn't 
# realize the path to the password was in bandit 13 -> bandit 14 so
# I thought I needed to send the whole ssh key to localhost 30000.
# Also, I couldn't copy the ssh key with scp because of filesystem 
# permissions.  This script is the result.
#
# https://unix.stackexchange.com/questions/590265/running-a-script-on-a-remote-system-without-copying-the-script-there
#
# Usage:  
# cat path/to/scripts/remote_nc_file.sh | ssh -i [bandit14 ssh key] bandit14@bandit.labs.overthewire.org -p 2220
#

# Read to EOF to avoid dealing with annoying character issues
#https://stackoverflow.com/questions/1167746/how-to-assign-a-heredoc-value-to-a-variable-in-bash
read -r -d '' SECRET_TO_NC <<'EOF'
<<< Insert password before running >>>
<<< Originally tried using this to send ssh key >>>
EOF

# Sanity check
echo "Running on $(hostname)"

# Send secret to localhost 30000
# Be sure to use quotes around the variable
cat <(echo "$SECRET_TO_NC") - | nc localhost 30000
