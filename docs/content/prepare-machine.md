# 树莓派重装准备工作

## 初始化树莓派

- 挂载硬盘
- 安装samba服务
- 安装zerotier网络服务
- 安装 python
- 安装 docker, docker-compose

复制下列脚本到树莓派，然后以管理员方式运行

```bash
#!/bin/bash
echo ======================================================
echo upgrade packages ...
echo ======================================================
apt update
apt upgrade

echo ======================================================
echo setting up hard drivers...
echo ======================================================
mkdir /home/pi/nas
cat <<EOT >> /etc/fstab
/dev/sda1 /home/pi/nas auto defaults,noatime 0 0
EOT
mount -a

echo ======================================================
echo setting up samba...
echo ======================================================
apt install -y samba samba-common-bin
cat <<EOT >> /etc/samba/smb.conf
[share]
    comment = share folder
    path = /home/pi/nas/share
    read only = yes
    guest ok = yes
    browseable = yes
EOT
smbpasswd -a pi
service smbd restart

echo ======================================================
echo setting up zerotier...
echo ======================================================
curl -s https://install.zerotier.com | bash
zerotier-cli join 0cccb752f7c070e8

echo ======================================================
echo setting up python...
echo ======================================================
apt-get install -y libffi-dev libssl-dev
apt-get install -y python3 python3-pip

echo ======================================================
echo setting up docker...
echo ======================================================
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
usermod -aG docker pi
docker run hello-world
pip3 -v install docker-compose

```

