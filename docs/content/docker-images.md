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
docker pull portainer/portainer
docker volume create portainer_data
docker run -d --network macvlan_1 --ip=192.168.10.2 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

## gitlab

git 代码托管仓库

```bash
docker pull ulm0/gitlab:latest
docker run -d --privileged --network macvlan_1 --ip=192.168.10.3 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --device=/dev/net/tun --hostname gitlab.zjhlogo.io --name gitlab --restart always -v /home/pi/nas/gitlab-ce/config:/etc/gitlab -v /home/pi/nas/gitlab-ce/logs:/var/log/gitlab -v /home/pi/nas/gitlab-ce/data:/var/opt/gitlab ulm0/gitlab

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

