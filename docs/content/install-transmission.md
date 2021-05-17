# 在树莓派上安装 Transmission

## 安装transmission

``` bash
sudo apt update
sudo apt install transmission-deamon
```

## 修改用户

``` bash
sudo service transmission-daemon stop
sudo nano /etc/init.d/transmission-daemon # change USER=pi
sudo nano /lib/systemd/system/transmission-daemon.service # change USER=pi

sudo chown -R pi:pi /etc/transmission-daemon/ # optional
sudo chown -R pi:pi /var/lib/transmission-daemon/ # optional

sudo systemctl daemon-reload # reload service config files
sudo service transmission-daemon start
```

## 修改transmission配置表

重启transmission服务后，transmission会在`home/pi/.config/`下新建配置表文件`transmission-deamon`. 所以必须重新配置配置表

``` bash
nano /home/pi/.config/transmission-daemon/setting.json # 修改 rpc-whitelist-enable: false
sudo service transmission-daemon reload
sudo service transmission-daemon restart
```

## 安装transmission扩展

可以安装[transmission-web-control](https://github.com/ronggang/transmission-web-control)增强`transmission-daemon`功能

``` bash
wget https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control.sh
chmod +x install-tr-control.sh
./install-tr-control-cn.sh
```

