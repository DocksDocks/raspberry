if [ $1 -eq 0 ]; 
then
  SWAP = $((0))
elif [ $1 -lt 0 ]; 
then
  SWAP=$((100))
elif [ $1 -gt 8 ];
then
  SWAP=$((1024*8)) 
else
  SWAP=$(( 1024 * $1))
fi


if [ $SWAP -gt 0 ];
then
    sudo dphys-swapfile swapoff && \
    printf "# /etc/dphys-swapfile - user settings for dphys-swapfile package\n
    # author Neil Franklin, last modification 2010.05.05\n
    # copyright ETH Zuerich Physics Departement\n
    #   use under either modified/non-advertising BSD or GPL license\n
    \n
    # this file is sourced with . so full normal sh syntax applies\n
    \n
    # the default settings are added as commented out CONF_*=* lines\n
    \n
    \n
    # where we want the swapfile to be, this is the default\n
    #CONF_SWAPFILE=/var/swap\n
    \n
    # set size to absolute value, leaving empty (default) then uses computed value\n
    #   you most likely don't want this, unless you have an special disk situation\n
    CONF_SWAPSIZE=100\n
    \n
    # set size to computed value, this times RAM size, dynamically adapts,\n
    #   guarantees that there is enough swap without wasting disk space on excess\n
    #CONF_SWAPFACTOR=2\n
    \n
    # restrict size (computed and absolute!) to maximally this limit\n
    #   can be set to empty for no limit, but beware of filled partitions!\n
    #   this is/was a (outdated?) 32bit kernel limit (in MBytes), do not overrun it\n
    #   but is also sensible on 64bit to prevent filling /var or even / partition\n
    CONF_MAXSWAP=$SWAP" >> /etc/dphys-swapfile && \
    sudo dphys-swapfile setup && \
    sudo dphys-swapfile swapon && \
    echo "Swap limit to ${SWAP}MB was successful"
else
    sudo dphys-swapfile swapoff && \
    printf "# /etc/dphys-swapfile - user settings for dphys-swapfile package\n
    # author Neil Franklin, last modification 2010.05.05\n
    # copyright ETH Zuerich Physics Departement\n
    #   use under either modified/non-advertising BSD or GPL license\n
    \n
    # this file is sourced with . so full normal sh syntax applies\n
    \n
    # the default settings are added as commented out CONF_*=* lines\n
    \n
    \n
    # where we want the swapfile to be, this is the default\n
    #CONF_SWAPFILE=/var/swap\n
    \n
    # set size to absolute value, leaving empty (default) then uses computed value\n
    #   you most likely don't want this, unless you have an special disk situation\n
    CONF_SWAPSIZE=100\n
    \n
    # set size to computed value, this times RAM size, dynamically adapts,\n
    #   guarantees that there is enough swap without wasting disk space on excess\n
    #CONF_SWAPFACTOR=2\n
    \n
    # restrict size (computed and absolute!) to maximally this limit\n
    #   can be set to empty for no limit, but beware of filled partitions!\n
    #   this is/was a (outdated?) 32bit kernel limit (in MBytes), do not overrun it\n
    #   but is also sensible on 64bit to prevent filling /var or even / partition\n
    #CONF_MAXSWAP=$SWAP" >> /etc/dphys-swapfile && \
    sudo dphys-swapfile setup && \
    sudo dphys-swapfile swapon && \
    echo "Swap limit back to system default was successful"
 fi
