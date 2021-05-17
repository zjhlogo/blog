# 在树莓派上安装外置硬盘

## 插上硬盘，查看状态
``` bash
$ sudo fdisk -l
```

## 先建一个目录 ，让树莓派挂载在创建的目录
``` bash
$ mkdir nas
```

## 然后按照我们的希望挂载
``` bash
$ sudo mount /dev/sda1 /home/pi/nas
```

## 安装NTFS格式可读写软件（可选）
``` bash
$ sudo apt-get install ntfs-3g
$ modprobe fuse # 加载内核模块
```

## 让移动硬盘开机自动挂载
``` bash
$ sudo nano /etc/fstab
```

最后一行添加
```
/dev/sda1 /home/pi/nas auto defaults,noatime,umask=0000 0 0
```

说明：

* `/dev/sda1`代表物理硬盘设备文件路径，a表示第一个硬盘，1表示第一个分区。不同设备、不同接口路径会有不同。可以用`sudo fdisk -l`查看所有设备文件路径
* auto 硬盘文件系统格式，auto表示自动检测
* umask=0000 0 0
   * 前面四个0就是对所有人,可读可写可执行
   * 后面两个0:
      * 第一个代表dump, 0是不备份
      * 第二个代表fsck检查的顺序, 0表示不检查

## 挂载全部硬盘
``` bash
$ sudo mount -a
```

## 卸载硬盘
``` bash
$ sudo umount /home/pi/nas
```
