#!/bin/bash

# One of the bandit levels had the user uncompress # a file after 
# running xxd -r.  File had to be #uncompressed multiple times in 
# different formats, and I didn't want to do that manually. 

set -euxo pipefail

rm unhex
cp unhex.txt unhex

while true; do
    # Tried using the --extension flag in `file` to get
    # `tar`, `gzip`, `bzip2` instead of a whole string. But it only 
    # returned '[filename]: ???', not sure why
    file_type="$(file unhex)"
    # These if-statements took me a while, not used to doing these 
    # without [] or [[]]. Should refresh my memory on this.
    if echo \"$file_type\" | grep -q 'tar' ; then
        tar -f unhex -xv --to-stdout > unhex.tar
        mv unhex.tar unhex
    elif echo "$file_type" | grep -q 'gzip' ; then
        mv unhex unhex.gz
        gzip -df unhex.gz 
    elif echo "$file_type" | grep -q 'bzip2' ; then
        mv unhex unhex.bz2
        bzip2 -df unhex.bz2
    else
        echo "done"
        break;
    fi;
done
