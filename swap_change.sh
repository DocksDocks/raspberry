sudo dphys-swapfile swapoff && \
dd if=/dev/zero of=/"$1"swap bs=1M count=$((512*2*$1)) && \
mkswap /"$1"swap && \
swapon /"$1"swap && \
echo "/""$1""swap          none  swap sw       0 0" >> /etc/fstab
