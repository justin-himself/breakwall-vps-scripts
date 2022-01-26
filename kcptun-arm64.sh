LISTEN_PORT=2333
TARGET_PORT=2444
PASSWORD=password
CRYPT=xor
VERSION=20210922
DIR=$PWD

apt install wget 
cd /tmp
wget https://github.com/xtaci/kcptun/releases/download/v$VERSION/kcptun-linux-arm64-$VERSION.tar.gz
tar -xzvf kcptun-linux-arm64-$VERSION.tar.gz
mv server_linux_arm64 /bin/kcptun
chmod +x /bin/kcptun
cd $DIR

# http://www.cloudy.pub/2018/03/30/kcptun配置和架设/

cat << EOF > start_kcptun.sh
#!/bin/sh
cd $DIR
/bin/kcptun -l ":$LISTEN_PORT" -c $DIR/server-config.json > kcptun.log 2>&1 &
echo "Kcptun started."
EOF

cat << EOF > stop_kcptun.sh
#!/bin/sh
PID=`ps -ef | grep kcptun | grep -v grep | awk '{print $2}'`
if [ "" != "$PID" ]; then
 echo "killing $PID"
 kill -9 $PID
else
 echo "Kcptun not running!"
fi
EOF


cat << EOF > restart_kcptun.sh
#!/bin/sh
cd $DIR
echo "Stopping Kcptun..."
sh stop.sh
sh start.sh
echo "Kcptun started."
EOF

cat << EOF > server-config.json
{
"listen": ":$LISTEN_PORT",
"target": "127.0.0.1:$TARGET_PORT",
"key": "$PASSWORD",
"crypt": "$CRYPT",
"mode": "fast2",
"mtu": 1350,
"sndwnd": 2048,
"rcvwnd": 2048,
"datashard": 10,
"parityshard": 3,
"dscp": 0,
"nocomp": false,
}
EOF

cd /etc/init.d
cat << EOF > /etc/init.d/kcptun.sh
#!/bin/sh
### BEGIN INIT INFO
# Provides:          root
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts kcptun service
# Description:       starts kcptun service
### END INIT INFO

sh $DIR/start_kcptun.sh
EOF
chmod +x /etc/init.d/kcptun.sh
update-rc.d kcptun.sh defaults
