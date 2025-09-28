#!/bin/bash

cp $PWD/kmonad.plist $HOME/Library/LaunchAgents/ca.nicholasbruce.kmonad.plist

chown root:wheel /Library/LaunchDaemons/ca.nicholasbruce.kmonad.plist

chmod 644 /Library/LaunchDaemons/ca.nicholasbruce.kmonad.plist

launchctl load /Library/LaunchDaemons/ca.nicholasbruce.kmonad.plist

