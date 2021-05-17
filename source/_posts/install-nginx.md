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
# 修改 user www-data -> user pi, 注意如果修改了默认用户会导致 php7.3-fpm 无法正确运行，应该是权限的问题
sudo nano /etc/nginx/nginx.conf
```

## 修改根目录

```bash
# 修改 root /var/www/html; -> root /home/pi/nas;
sudo nano /etc/nginx/sites-enabled/default
```

## 重新启动nginx

```bash
sudo service nginx restart
```

## 安装 php
```bash
sudo apt install php7.3-fpm php7.3-cli php7.3-curl php7.3-gd php7.3-cgi
```

## 配置
```bash
# 修改配置
sudo nano /etc/nginx/sites-enabled/default

# 改 index index.html index.htm index.nginx-debian.html;
index index.php index.html index.htm index.nginx-debian.html;

# pass PHP scripts to FastCGI server
location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php7.3-fpm.sock;
}
```

## 重启服务
```bash
sudo service nginx restart
```
