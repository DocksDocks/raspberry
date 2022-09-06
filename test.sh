#!/bin/bash
if [ $1 -eq 0 ]; 
then
  $SWAP = 0
elif [ $1 -lt 0 ]; 
then
  $SWAP = 100
elif [ $1 -gt 8 ];
then
  SWAP=$((1024*8)) 
else
  SWAP=$(( 1024 * $1))
fi


if [ $SWAP -eq 0 ];
then
    echo "Was set to default"
else
    echo "Changed successfuly to ${SWAP}MB"
 fi
