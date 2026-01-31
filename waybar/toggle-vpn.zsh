#!/usr/bin/env zsh

source ~/.zsh_funcs/vpn.zsh

state=$(vpn stats | awk '/Connection State:/ {printf $3}')
if [ "$state" != 'Disconnected' ]; then
  vpn disconnect
else
  vpn connect
fi
