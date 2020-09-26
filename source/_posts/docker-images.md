---
title: 常用 Docker 镜像
date: 2020-09-26 08:15:19
tags:
- docker
- gitlab
---

## gitlab

git 代码托管仓库

```bash
sudo docker pull ulm0/gitlab:latest
sudo docker run -d --hostname gitlab.example.com -p 1443:443 -p 1080:80 -p 1022:22 --name gitlab --restart always -v /home/pi/nas/db/gitlab/config:/etc/gitlab -v /home/pi/nas/db/gitlab/logs:/var/log/gitlab -v /home/pi/nas/db/gitlab/data:/var/opt/gitlab ulm0/gitlab
```

## portainer

docker web管理终端

```bash
sudo docker pull portainer/portainer
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

