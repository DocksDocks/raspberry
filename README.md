# Raspberry Pi - Utilities
Trying to make a few utilities for raspberry pi

## Useful information 

I limited in the scripts 'swap_change.sh' and 'limit_swap_change.sh' an maximum of 8GB for safety reasons.

## Using swap_change.sh - Change your swap size

Usage:
```
sudo sh swap_change.sh 2 
```
And '2' being your swap size in GB

The default swap limit of raspberry is 2GB if you want to change it you can do it by using limit_swap_change.sh

## Using limit_swap_change.sh - Increase your swap limit



Usage:
```
sudo sh limit_swap_change.sh 4
```
And '4' being in GB the new swap size and limit that you want.

Use this to go back to default:
```
sudo sh limit_swap_change.sh 0
```
