# 在树莓派上安装 Samba 服务

## 安装Samba
``` bash
$ sudo apt-get install samba samba-common-bin
```

## 配置Samba
``` bash
$ sudo nano /etc/samba/smb.conf
```

在文件最下面加上以下内容，这里设置 ` /home/zjhlogo/nas/share ` 为共享文件夹
```
[share]
   comment = share folder
   path = /mnt/disk/downloads/share
   read only = yes
   guest ok = yes
   browseable = yes
```

## 重启Samba服务
``` bash
$ sudo service smbd restart
```

配置完成后即可从局域网内其他电脑访问共享文件夹，Windows下访问目录为 ` \\IP\Folder `，例如：
```
\\192.168.1.2\share
```

## 添加用户
把本地已有的用户添加为samba用户，这里以用户名 `zjhlogo` 为例
``` bash
$ sudo smbpasswd -a zjhlogo
```

给管理员添加写入权限

```bash
$ sudo nano /etc/samba/smb.conf

[share]
   comment = share folder
   path = /mnt/disk
   read only = yes
   guest ok = no
   browseable = yes
   valid users = zjhlogo
```

配置完成后即可从局域网内其他电脑访问共享目录
