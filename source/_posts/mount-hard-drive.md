---
title: 在树莓派上安装外置硬盘
date: 2019-08-25 21:51:44
tags:[unix][raspberry pi]
---
## 插上硬盘，查看状态
```bash
$ sudo fdisk -l
```

## 先建一个目录 ，让树莓派挂载在创建的目录
```bash
$ mkdir nas
```

## 然后按照我们的希望挂载
```bash
$ sudo mount /dev/sda1 /home/pi/nas
```

## 安装NTFS格式可读写软件（可选）
```bash
$ sudo apt-get install ntfs-3g
$ modprobe fuse # 加载内核模块
```
## 让移动硬盘开机自动挂载
```bash
$ sudo nano /etc/fstab
```
最后一行添加
```
/dev/sda1 /home/pi/nas auto defaults, noatime, umask=0000 0 0
```
说明：
* sda1是取决于你的实际情况，a表示第一个硬盘，1表示第一个分区
* umask=0000 0 0
   * 前面四个0就是对所有人,可读可写可执行
   * 后面两个0:
      * 第一个代表dump, 0是不备份
      * 第二个代表fsck检查的顺序, 0表示不检查

## 卸载
```bash
$ sudo umount /home/pi/nas
```
