---
title: 常用 Docker 镜像
date: 2020-09-26 08:15:19
tags:
- docker
- gitlab
---

## 准备工作

```bash
# 创建 macvlan 网络模式, 该模式下 container 可以访问宿主同网段的ip但不能访问宿主ip, 宿主也无法访问内部的 container
# --subnet 192.168.10.0/8 定义网段
# --gateway 192.168.10.1 指定网关
# -o parent=eth0 指定绑定的网卡
docker network create --driver macvlan --subnet 192.168.10.0/8 --gateway 192.168.10.1 -o parent=eth0 macvlan_1
```

## portainer

docker web管理终端

```bash
sudo docker pull portainer/portainer
sudo docker volume create portainer_data
sudo docker run -d --network macvlan_1 --ip=192.168.10.2 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

## gitlab

git 代码托管仓库

```bash
sudo docker pull ulm0/gitlab:latest
sudo docker run -d --network macvlan_1 --ip=192.168.10.3 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --device=/dev/net/tun --hostname gitlab.zjhlogo.io --name gitlab --restart always -v /home/pi/nas/gitlab-ce/config:/etc/gitlab -v /home/pi/nas/gitlab-ce/logs:/var/log/gitlab -v /home/pi/nas/gitlab-ce/data:/var/opt/gitlab ulm0/gitlab

# 调整配置文件 /etc/gitlab/gitlab.rb
# gitlab-ctl reconfigure
# gitlab-ctl restart

# 安装 zerotier
curl -s https://install.zerotier.com | bash
zerotier-cli join 565799d8f665b8d4
```
