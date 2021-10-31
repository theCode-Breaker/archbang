#!/bin/bash

DE="openbox-session"

systemctl --user import-environment DISPLAY

# Dbus fix
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

/usr/bin/xdg-user-dirs-update

if grep -q i3 /proc/cmdline; then
	DE="i3"
fi

exec $DE

