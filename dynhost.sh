#!/bin/bash

# Path variables
PATH_LOG=/var/log/dynhostovh.log

declare -a domaines

# Domains declaration
domaines[0]='subdomain.domain.com;username;password'


for domaine in "${domaines[@]}"
do
#---------------------------------------------------------
  IFS=";" read -r -a arr <<< "${domaine}"
  HOST="${arr[0]}"
  LOGIN="${arr[1]}"
  PASSWORD="${arr[2]}"
# --------------------------------------------------------
# Get current IPv4 and corresponding configured
  HOST_IP=$(dig +short $HOST A)
  CURRENT_IP=$(curl -m 5 -4 ifconfig.co 2>/dev/null)
  if [ -z "$CURRENT_IP" ]
  then
    CURRENT_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
  fi
  CURRENT_DATETIME=$(date -R)

  # Update dynamic IPv4, if needed
  if [ -z "$CURRENT_IP" ] || [ -z "$HOST_IP" ]
  then
    echo "[$CURRENT_DATETIME]: No IP retrieved" >> $PATH_LOG
  else
    if [ "$HOST_IP" != "$CURRENT_IP" ]
    then
      RES=$(curl -m 5 -L --location-trusted --user "$LOGIN:$PASSWORD" "https://www.ovh.com/nic/update?system=dyndns&hostname=$HOST&myip=$CURRENT_IP")
      echo "[$CURRENT_DATETIME]: IPv4 has changed - request to OVH DynHost: $RES" >> $PATH_LOG
    fi
  fi
done


