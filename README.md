# DS215j-optware-bootstrap
Synology DS215j optware manual bootstrap guide.
# Introduction
There's no xsh bootstrap for the ds215j,So this is a small guide to setup manually the optware environment. 
# Upload script
Download ```openware.sh``` and upload to```/usr/local/etc/rc.d/``` directory 
then  make it executable```chmod +x /usr/local/etc/rc.d/optware.sh```
# Install
Run this command
```
/usr/local/etc/rc.d/optware.sh start
```
# Set path
Add the following line to /etc/profile:
```
PATH=/opt/bin:/opt/sbin:$PATH
```
# Finish
Thanks [André](http://freshest.me/bootstrap-ds215j/)


[My blog](https://stray.love)


If you upgrade the system?  Ok optware is always there.
