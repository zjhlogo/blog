# 在树莓派上安装 Nodejs

## 安装步骤
- 下载安装包 [官网](https://nodejs.org/en/download/)
``` bash
wget https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-armv7l.tar.xz
```

- 解压安装包
``` bash
tar -xvf node-v12.18.3-linux-armv7l.tar.xz
sudo mv node-v12.18.3-linux-armv7l /usr/local/node
```

- 配置链接
``` bash
# make soft link for node
sudo ln -s /usr/local/node/bin/node /usr/bin/node
# make soft link for npm
sudo ln -s /usr/local/node/bin/npm /usr/bin/npm
```

