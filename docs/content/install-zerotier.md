---
title: 安装配置 zerotier moon 服务器
date: 2020-12-13 06:25:49
tags:
- linux
- zerotier
---
## 公网服务的配置Moon节点

- 安装 `moon`

```bash
curl -s https://install.zerotier.com/ | sudo bash
sudo zerotier-cli join <network id> # 加入到你创建好的网络
```

- 生成`moon`配置文件

```bash
cd /var/lib/zerotier-one
sudo zerotier-idtool initmoon identity.public > moon.json
```

- 修改配置文件`moon.json`

```bash
sudo vim moon.json # 找到对应行修改内容
# "stableEndpoints": [ "x.x.x.x/9993" ] 改为自己的公网IP地址, 端口 9993, UDP
```

- 生成`moon`签名并保存到本地，后续会需要

```bash
# 执行该命令后,会在在/var/lib/zerotier-one目录下生成一个类似000000xxxxx.moon的文件
sudo zerotier-idtool genmoon moon.json
```

- 使`moon`配置文件生效

```bash
sudo mkdir /var/lib/zerotier-one/moons.d
sudo mv 000000xxxxx.moon /var/lib/zerotier-one/moons.d/
```

- 重启服务器生效

```bash
sudo service zerotier-one restart #服务重启命令
```

## 内网客户端节点配置

- 在安装目录下创建'moons.d'文件夹，并拷贝`000000xxxxx.moon`文件到目录下

```bash
sudo mkdir /var/lib/zerotier-one/moons.d
sudo cp 000000xxxxx.moon /var/lib/zerotier-one/moons.d/
```

- 执行命令加入`moon`节点网络

```bash
sudo zerotier-cli orbit 000000xxxxx 000000xxxxx #没错，这个值要输入两遍
```

- 之后，你的信令就会经过这台中转服务器进行转发，查看是否存在MOON服务器，可以执行命令进行查看

```bash
sudo zerotier-cli listpeers
200 listpeers <ztaddr> <path> <latency> <version> <role>
200 listpeers 03039b5eee x.x.x.x/9993;xxxx;xxxx 24 1.6.2 MOON # 有这条信息说明成功连接到moon服务器
...
# 如果没有moon节点，说明配置上有问题，请重新检查以上步骤
# 如果发现有moon节点但是没有显示公网ip(如下)，说明连接失败，请查看公网服务器是否屏蔽端口9993
200 listpeers 0574833e73 - -1 - MOON
```



