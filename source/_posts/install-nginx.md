---
title: 安装nginx
date: 2020-09-29 21:26:02
tags:
- nginx
- raspberry pi
---

## nginx 的安装

```bash
sudo apt-get install nginx
```

第一次安装好`nginx`服务器后，默认的网页根目录在`/var/www/html`；配置文件在`/etc/nginx/nginx.conf`

## 修改默认用户

```bash
# 修改 user www-data -> user pi
sudo nano /etc/nginx/nginx.conf
```

##  修改根目录

```bash
# 修改 root /var/www/html; -> root /home/pi/nas;
sudo nano /etc/nginx/sites-enabled/default
```

## 重新启动nginx

```bash
sudo service nginx restart
```

