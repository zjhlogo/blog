---
title: Install samba.js
date: 2019-08-24 15:15:44
tags:
---
## 安装Samba

```bash
$ sudo apt-get install samba samba-common-bin
```

## 配置Samba

```bash
$ sudo nano /etc/samba/smb.conf
```

在文件最下面加上以下内容，这里设置/home/pi/nas为共享文件夹

```
[Public]
   comment = Public Storage  # 共享文件夹说明
   path = /home/pi/Public # 共享文件夹目录
   read only = no # 不只读
   create mask = 0777 # 创建文件的权限
   directory mask = 0777 # 创建文件夹的权限
   guest ok = yes # guest访问，无需密码
   browseable = yes # 可见
```

## 重启Samba服务

```bash
$ sudo service smbd restart
```

## 设置文件夹权限
在Samba配置文件设置过权限后，还需要在系统中将共享文件夹的权限设置为同配置文件中相同的权限，这样才能确保其他用户正常访问及修改文件夹内容

```bash
sudo chmod -R 777 /home/pi/Public/
```

配置完成后即可从局域网内其他电脑访问共享文件夹，Windows下访问目录为\\IP\Folder，例如：

```
\\192.168.1.2\nas
```
