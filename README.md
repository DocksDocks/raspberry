# Raspberry Pi - Utilities
Trying to make a few utilities for raspberry pi



## Using swap_change.sh - Change your swap size

Usage:
```
sudo sh swap_change.sh 2 
```
And '2' being your swap size in GB

The default swap limit of raspberry is 2GB if you want to change it you can do it by using limit_swap_change.sh

## Using limit_swap_change.sh - Change your swap limit

Reminder - If you use this command it will go back to the default size of your swap size which is 100MB so you need to use the 'swap_change.sh' to get back at what you want.

Usage:
```
sudo sh limit_Swap_change.sh 4
```
And '4' being your swap limit size in GB
