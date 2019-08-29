---
title: Install node.js
date: 2019-08-24 15:15:44
tags:
---
## 安装步骤

### 从[官网](https://nodejs.org/en/download/)下载并解压对应安装包

下载安装包
``` bash
$ wget https://nodejs.org/dist/v10.16.3/node-v10.16.3-linux-armv7l.tar.xz
```

解压安装包
``` bash
$ tar -xvf node-v10.16.3-linux-armv7l.tar.xz
```

### 配置链接

配置node链接
``` bash
$ sudo ln /home/pi/node-v10.16.3-linux-armv7l/bin/node /usr/local/bin/node
```

配置npm链接
``` bash
$ sudo ln -s /home/pi/node-v10.16.3-linux-armv7l/lib/node_modules/npm/bin/npm /usr/local/bin/npm
```

### 修改 npm 链接内容

``` bash
$ sudo nano /usr/local/bin/npm
```

修改 bashdir 和 NPM_CLI_JS 变量
``` bash
...
basedir="/home/pi/node-v10.16.3-linux-armv7l"
...
NPM_CLI_JS="$basedir/lib/node_modules/npm/bin/npm-cli.js"
...
```

大功告成
