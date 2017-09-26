#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

# merge in defaults and keymaps

[[ -f $sysresources ]] && xrdb -merge $sysresources

[[ -f $sysmodmap ]] && xmodmap $sysmodmap

[[ -f "$userresources" ]] && xrdb -merge -I$HOME "$userresources"

[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# change touchpad behaviour
xinput set-prop 'DLL075B:01 06CB:76AF Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'DLL075B:01 06CB:76AF Touchpad' 'libinput Natural Scrolling Enabled' 1

# finally, start i3 window manager
exec i3
