#!/usr/bin/env zsh

exec 2>/dev/null

/opt/cisco/anyconnect/bin/vpn stats | awk '
/Connection State:/ { state=$3 }
/Duration:/         { duration=$2 }
/Profile Name:/     { profile=$3 }
END {
  class = (state == "Connected") ? "connected" : (state == "Disconnected") ? "disconnected" : "reconnecting"
  printf("{\"text\":\"%s\",\"alt\":\"VPN state\",\"class\":\"%s\",\"tooltip\":\"Profile: %s\\nDuration: %s\"}\n",
         state, class, profile, duration)
}'
