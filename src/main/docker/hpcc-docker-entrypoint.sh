#!/usr/local/bin/dumb-init /bin/sh
/usr/bin/ssh-keygen -A
/etc/init.d/hpcc-init start
exec /usr/sbin/sshd -D
