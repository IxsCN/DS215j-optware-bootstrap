#!/bin/sh
#
# Optware setup
# Alternatives Optware Startup und Shutdown Script #/usr/local/etc/rc.d/optware.sh
#

case $1 in
start)
	 
	if test ! -h /volume1/@optware -a ! -d /volume1/@optware; then
     
	mkdir /volume1/@optware
	cd /volume1/@optware
	feed=http://ipkg.nslu2-linux.org/feeds/optware/cs08q1armel/cross/unstable
	ipk_name=`wget -qO- $feed/Packages | awk '/^Filename: ipkg-opt/ {print $2}'`
	wget $feed/$ipk_name
	tar -xOvzf $ipk_name ./data.tar.gz | tar -C / -xzvf -
	mkdir -p /opt/etc/ipkg
	echo "src cross $feed" > /opt/etc/ipkg/feeds.conf
	mv /opt/* /volume1/@optware
	rm /opt -rf
	echo "optware had been installed into /volume1/@optware "
	fi

	[ ! -h /opt -a ! -d /opt ] && ln -s /volume1/@optware /opt
	for i in /opt/etc/init.d/S??* ;do
#
               # Ignore dangling symlinks (if any).
               [ ! -f "$i" ] && continue
#
               case "$i" in
                  *.sh)
                       # Source shell script for speed.
                       (
                               trap - INT QUIT TSTP
                               set start
                               . $i
                       )
                       ;;
                  *)
                       # No sh extension, so fork subprocess.
                       $i start
                       ;;
               esac
	done
	echo "optware  had been initialized"
       ;;
#
stop)
#
       for i in /opt/etc/init.d/S??* ;do
#
               # Ignore dangling symlinks (if any).
               [ ! -f "$i" ] && continue
#
               case "$i" in
                  *.sh)
                       # Source shell script for speed.
                       (
                               trap - INT QUIT TSTP
                               set stop
                              . $i
                       )
                       ;;
                  *)
                       # No sh extension, so fork subprocess.
                       $i stop                       ;;
               esac
         done
         ;;
#
*)
         echo "Usage: $0 [start|stop]"
         ;;
esac
#
# End
