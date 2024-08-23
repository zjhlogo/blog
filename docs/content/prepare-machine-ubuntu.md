# 树莓派重装准备工作

## 初始化树莓派

- 挂载硬盘
- 安装 docker

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
mkdir /home/zjhlogo/nas
cat <<EOT >> /etc/fstab
/dev/sda1 /home/zjhlogo/nas auto defaults,noatime 0 0
EOT
mount -a

echo ======================================================
echo setting up docker...
echo ======================================================
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
usermod -aG docker zjhlogo
docker run hello-world
```

