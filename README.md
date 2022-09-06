# Raspberry Pi - Utilities
Trying to make a few utilities for raspberry pi

## Useful information 

I limited in the scripts 'swap_change.sh' and 'limit_swap_change.sh' a maximum amount of 8GB for safety reasons.

## Swap

### Using swap_change.sh - Change your swap size

Usage:
```
sudo sh swap_change.sh 2 
```
And '2' being your swap size in GB

The default swap limit of raspberry is 2GB if you want to use more than that you can do it by using 'limit_swap_change.sh'

Reminder - Using this script will back your limit to 2GB

### Using limit_swap_change.sh - Increase your swap limit



Usage:
```
sudo sh limit_swap_change.sh 4
```
And '4' being in GB your swap size and limit that you want.

Use this to go back to default:
```
sudo sh limit_swap_change.sh 0
```
