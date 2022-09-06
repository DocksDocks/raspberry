#!/bin/bash
[[ ${1} -gt 4]] && SWAP=$((1024*4)) || SWAP=$(( 1024 * $1))
echo "Testing... swap size: $SWAP"
