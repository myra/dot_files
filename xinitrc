numlockx &

autocutsel -selection PRIMARY -fork &

# Source scripts in /etc/X11/xinit/xinitrc.d/
#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#    for f in /etc/X11/xinit/xinitrc.d/*; do
#        [ -x "$f" ] && . "$f"
#    done
#    unset f
#fi

#exec openbox-session
exec ck-launch-session dbus-launch openbox-session


