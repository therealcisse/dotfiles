#!/bin/sh

# If called from Hammerspoon where the UID environment variable is not
# set, grab the UID ourselves.
if [ -z "$UID" ]; then
  UID=$(id -u)
fi

# In Hammerspoon, $PATH will be too minimal(/usr/bin:/bin:/usr/sbin:/sbin)
# to find the `dry` executable.
PATH=$PATH:$HOME/bin

# For good measure, turn off key repeat:
if command -v dry &> /dev/null; then
  dry 300 > /dev/null
fi

launchctl bootout gui/"$UID" /Library/LaunchAgents/org.pqrs.karabiner.karabiner_console_user_server.plist
launchctl disable gui/"$UID"/org.pqrs.karabiner.karabiner_console_user_server

# Depends on /private/etc/sudoers.d/karabiner-sudoers:
sudo launchctl unload /Library/LaunchDaemons/org.pqrs.karabiner.karabiner_observer.plist
sudo launchctl unload /Library/LaunchDaemons/org.pqrs.karabiner.karabiner_grabber.plist

echo "💀 Karabiner-Elements killed"
