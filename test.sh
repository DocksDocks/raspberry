#!/bin/bash
if [[ "$1" -gt "4"]]; then
    SWAP=$((1024*4)) 
else
 SWAP=$(( 1024 * $1))
fi
echo "Testing... swap size: $SWAP"
