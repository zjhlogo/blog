---
title: 在树莓派上安装samba服务
date: 2019-08-25 20:09:44
tags:
- samba
- raspberry pi
---

## 安装Samba
```bash
$ sudo apt-get install samba samba-common-bin
```

## 配置Samba
```bash
$ sudo nano /etc/samba/smb.conf
```

在文件最下面加上以下内容，这里设置 ` /home/pi/nas/share ` 为共享文件夹
```
[share]
   comment = share folder  # 共享文件夹说明
   path = /home/pi/nas/share # 共享文件夹目录
   read only = yes # 只读
   guest ok = yes # guest访问，无需密码
   browseable = yes # 可见
```

## 重启Samba服务
```bash
$ sudo service smbd restart
```

配置完成后即可从局域网内其他电脑访问共享文件夹，Windows下访问目录为 ` \\IP\Folder `，例如：
```
\\192.168.1.2\share
```

## 添加用户
把本地已有的用户添加为samba用户，这里以用户名 ` pi ` 为例
```bash
$ sudo smbpasswd -a pi
```

配置完成后即可从局域网内其他电脑访问用户目录 `/home/pi/ `
```
\\raspberrypi4\pi
```
