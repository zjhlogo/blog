# 常用 Docker 镜像

## 准备工作

```bash
# 创建自定义 bridge 网络，这样才能自己指定ip
docker network create --driver bridge --subnet=111.111.111.0/24 --gateway=111.111.111.1 zjhlogo_net
```

## portainer

docker web管理终端

```bash
docker volume create portainer_data
docker run -d --network zjhlogo_net --ip=111.111.111.2 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

## gitlab

git 代码托管仓库

```bash
docker run --detach --restart always --name gitlab --privileged --network zjhlogo_net --ip=111.111.111.3 --hostname gitlab.zjhlogo.io -p 2222:22 -v /home/ubuntu/nas/persistence/gitlab/config:/etc/gitlab -v /home/ubuntu/nas/persistence/gitlab/logs:/var/log/gitlab -v /home/ubuntu/nas/persistence/gitlab/data:/var/opt/gitlab yrzr/gitlab-ce-arm64v8:latest
```

## LDAP

**LDAP** stands for Lightweight Directory Access Protocol. As the name suggests, it is a lightweight client-server protocol for accessing directory services, specifically X. 500-based directory services. **LDAP** runs over TCP/IP or other connection oriented transfer services.

```bash
#!/bin/bash
docker run -d --network zjhlogo_net --ip=111.111.111.4 --name ldap-service --hostname ldap.zjhlogo.io osixia/openldap
docker run -d --network zjhlogo_net --ip=111.111.111.5 --name phpldapadmin-service --hostname phpldapadmin.zjhlogo.io --link ldap.zjhlogo.io:ldap-host --env PHPLDAPADMIN_LDAP_HOSTS=ldap-host osixia/phpldapadmin

PHPLDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" phpldapadmin.zjhlogo.io)

echo "Go to: https://$PHPLDAP_IP"
echo "Login DN: cn=admin,dc=example,dc=org"
echo "Password: admin"
```

## MySQL

MySQL is the world's most popular open source database. With its proven performance, reliability and ease-of-use, MySQL has become the leading database choice for web-based applications, covering the entire range from personal projects and websites, via e-commerce and information services, all the way to high profile web properties including Facebook, Twitter, YouTube, Yahoo! and many more.

```bash
docker run -d --privileged --network zjhlogo_net --ip=111.111.111.6 --name mysql -e MYSQL_ROOT_PASSWORD=12345tgb -v /home/pi/nas/persistence/mysql/data:/var/lib/mysql --restart always biarms/mysql
```

## Mariadb

```bash
docker run -d --privileged --network zjhlogo_net --ip=111.111.111.7 --name=mariadb -e PUID=1000 -e PGID=1000 -e MYSQL_ROOT_PASSWORD=12345tgb -e TZ=Asia/Hong_Kong -v /home/pi/nas/persistence/mariadb:/config --restart always ghcr.io/linuxserver/mariadb
```

## PIWIGO

Manage your photo library. Piwigo is open source photo gallery software for the web. Designed for organisations, teams and individuals.

```bash
docker run -d --privileged --network zjhlogo_net --ip=111.111.111.8 --name piwigo -e PUID=1000 -e PGID=1000 -e TZ=Asia/Hong_Kong -v /home/pi/nas/persistence/piwigo/config:/config -v /home/pi/nas/persistence/piwigo/gallery:/gallery --restart always ghcr.io/linuxserver/piwigo
```

## Lychee

```bash
docker run -d --privileged --network zjhlogo_net --ip=111.111.111.9 --name=lychee -v /home/pi/nas/persistence/lychee/conf:/conf -v /home/pi/nas/persistence/lychee/uploads:/uploads -v /home/pi/nas/persistence/lychee/sym:/sym -e PUID=1000 -e PGID=1000 -e PHP_TZ=Asia/Hong_Kong -e DB_CONNECTION=mysql -e DB_HOST=111.111.111.7 -e DB_PORT=3306 -e DB_DATABASE=lychee -e DB_USERNAME=lychee -e DB_PASSWORD=lychee12345tgb lycheeorg/lychee

# enter mariadb and create databases
create database lychee;
create user 'lychee'@'%' identified by 'lychee12345tgb';
grant all privileges on lychee.* to 'lychee'@'%';
```

## nginx-php7

```bash
docker run -d --network zjhlogo_net --ip=111.111.111.10 --name nginx-php7 -v /home/ubuntu/nas/persistence/nginx-php7/wwwroot:/data/wwwroot --restart always skiychan/nginx-php7
```

## latex

```shell
docker run -d --network zjhlogo_net --ip=111.111.111.11 --name sharelatex --restart always sdanaipat/sharelatex
```

## carlibre-web

```shell
docker run -d --network zjhlogo_net --ip=111.111.111.12 --name calibre-web -e PUID=1000 -e PGID=1000 -e DOCKER_MODS=linuxserver/calibre-web:calibre `#optional` -e OAUTHLIB_RELAX_TOKEN_SCOPE=1 `#optional` -v /home/ubuntu/nas/persistence/carlibre-web/config:/config -v /home/ubuntu/nas/persistence/carlibre-web/books:/books --restart always linuxserver/calibre-web
```

## memos
```shell
docker run -d --network zjhlogo_net --ip=111.111.111.13 --name memos -v /home/ubuntu/nas/persistence/memos:/var/opt/memos --restart always neosmemo/memos
```

## nextcloud
```shell
docker run -d --network zjhlogo_net --ip=111.111.111.14 --name nextcloud -e APACHE_DISABLE_REWRITE_IP=1 -e OVERWRITEHOST=192.168.10.110 -e NEXTCLOUD_TRUSTED_DOMAINS=192.168.10.110 -p 2284:80 -v /home/ubuntu/nas/persistence/nextcloud:/var/www/html --restart always nextcloud
```
