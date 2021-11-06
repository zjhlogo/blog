# 常用 Docker 镜像

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
docker volume create portainer_data
docker run -d --network macvlan_1 --ip=192.168.10.2 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

## gitlab

git 代码托管仓库

```bash
docker run --detach --restart always --name gitlab --privileged --network macvlan_1 --ip=192.168.10.3 --hostname gitlab.zjhlogo.io --env GITLAB_OMNIBUS_CONFIG=" nginx['redirect_http_to_https'] = true; " -v /home/ubuntu/nas/persistence/gitlab/config:/etc/gitlab -v /home/ubuntu/nas/persistence/gitlab/logs:/var/log/gitlab -v /home/ubuntu/nas/persistence/gitlab/data:/var/opt/gitlab yrzr/gitlab-ce-arm64v8:latest

# 调整配置文件 /etc/gitlab/gitlab.rb
# gitlab-ctl reconfigure
# gitlab-ctl restart

# 安装 zerotier
curl -s https://install.zerotier.com | bash
# 可能会报错 could not resolve host 'xxx', 需添加 host -> /etc/hosts xxx.xxx.xxx.xxx 'xxx'

zerotier-one -d
zerotier-cli join 0cccb752f7c070e8

# 带 zerotier 的 gitlab
docker run -d --network macvlan_1 --ip=192.168.10.3 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --device=/dev/net/tun --hostname gitlab.zjhlogo.io --name gitlab --restart always -v /home/pi/nas/gitlab-ce/config:/etc/gitlab -v /home/pi/nas/gitlab-ce/logs:/var/log/gitlab -v /home/pi/nas/gitlab-ce/data:/var/opt/gitlab zjhlogo/gitlab
```

## LDAP

**LDAP** stands for Lightweight Directory Access Protocol. As the name suggests, it is a lightweight client-server protocol for accessing directory services, specifically X. 500-based directory services. **LDAP** runs over TCP/IP or other connection oriented transfer services.

```bash
#!/bin/bash
docker run -d --network macvlan_1 --ip=192.168.10.4 --name ldap-service --hostname ldap.zjhlogo.io osixia/openldap
docker run -d --network macvlan_1 --ip=192.168.10.5 --name phpldapadmin-service --hostname phpldapadmin.zjhlogo.io --link ldap.zjhlogo.io:ldap-host --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host osixia/phpldapadmin

PHPLDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" phpldapadmin.zjhlogo.io)

echo "Go to: https://$PHPLDAP_IP"
echo "Login DN: cn=admin,dc=example,dc=org"
echo "Password: admin"
```

## MySQL

MySQL is the world's most popular open source database. With its proven performance, reliability and ease-of-use, MySQL has become the leading database choice for web-based applications, covering the entire range from personal projects and websites, via e-commerce and information services, all the way to high profile web properties including Facebook, Twitter, YouTube, Yahoo! and many more.

```bash
docker run -d --privileged --network macvlan_1 --ip=192.168.10.6 --name mysql -e MYSQL_ROOT_PASSWORD=12345tgb -v /home/pi/nas/persistence/mysql/data:/var/lib/mysql --restart always biarms/mysql
```

## Mariadb

```bash
docker run -d --privileged --network macvlan_1 --ip=192.168.10.7 --name=mariadb -e PUID=1000 -e PGID=1000 -e MYSQL_ROOT_PASSWORD=12345tgb -e TZ=Asia/Hong_Kong -v /home/pi/nas/persistence/mariadb:/config --restart always ghcr.io/linuxserver/mariadb
```

## PIWIGO

Manage your photo library. Piwigo is open source photo gallery software for the web. Designed for organisations, teams and individuals.

```bash
docker run -d --privileged --network macvlan_1 --ip=192.168.10.8 --name piwigo -e PUID=1000 -e PGID=1000 -e TZ=Asia/Hong_Kong -v /home/pi/nas/persistence/piwigo/config:/config -v /home/pi/nas/persistence/piwigo/gallery:/gallery --restart always ghcr.io/linuxserver/piwigo
```


## Lychee

```bash
docker run -d --privileged --network macvlan_1 --ip=192.168.10.9 --name=lychee -v /home/pi/nas/persistence/lychee/conf:/conf -v /home/pi/nas/persistence/lychee/uploads:/uploads -v /home/pi/nas/persistence/lychee/sym:/sym -e PUID=1000 -e PGID=1000 -e PHP_TZ=Asia/Hong_Kong -e DB_CONNECTION=mysql -e DB_HOST=192.168.10.7 -e DB_PORT=3306 -e DB_DATABASE=lychee -e DB_USERNAME=lychee -e DB_PASSWORD=lychee12345tgb lycheeorg/lychee

# enter mariadb and create databases
create database lychee;
create user 'lychee'@'%' identified by 'lychee12345tgb';
grant all privileges on lychee.* to 'lychee'@'%';

```

## nginx-php7

```ba
docker run -d --network macvlan_1 --ip=192.168.10.10 --name nginx-php7 -v /home/ubuntu/nas/persistence/nginx-php7/wwwroot:/data/wwwroot --restart always skiychan/nginx-php7
```

