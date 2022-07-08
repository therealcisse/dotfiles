#!/bin/sh

# If called from Hammerspoon where the UID environment variable is not
# set, grab the UID ourselves.
if [ -z "$UID" ]; then
  UID=$(id -u)
fi

# In Hammerspoon, $PATH will be too minimal(/usr/bin:/bin:/usr/sbin:/sbin)
# to find the `dry` executable.
PATH=$PATH:$HOME/bin

# Depends on /private/etc/sudoers.d/karabiner-sudoers:
sudo launchctl load /Library/LaunchDaemons/org.pqrs.karabiner.karabiner_grabber.plist
sudo launchctl load /Library/LaunchDaemons/org.pqrs.karabiner.karabiner_observer.plist

launchctl enable gui/"$UID"/org.pqrs.karabiner.karabiner_console_user_server
launchctl bootstrap gui/"$UID" /Library/LaunchAgents/org.pqrs.karabiner.karabiner_console_user_server.plist
launchctl enable gui/"$UID"/org.pqrs.karabiner.karabiner_console_user_server

# Turn key repeat back on:
if command -v dry &> /dev/null; then
  # 0.016667 = Aim for 60 fps, 0.033333 = Aim for 30 fps
  dry 0.0166666666667 > /dev/null
fi

echo "🐣 Karabiner-Elements bootstrapped"
