# 安装 Selenium

## chrome 的安装

```bash
sudo apt-get install chromium-browser
```

如果报无法安装 则需要添加源。我是使用的中科大的源，直接就可以安装

```bash
deb http://mirrors.ustc.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi
deb-src http://mirrors.ustc.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi
```

网上是在文件 /etc/apt/sources.list 添加。

## chromium-chromedriver 的安装

```bash
sudo apt-get install chromium-chromedriver
```

## 安装虚拟桌面

```bash
sudo apt-get install xvfb
```

安装完后执行

```bash
Xvfb -ac :7 -screen 0 1280x1024x8 -extension RANDR -nolisten inet6 &

#导入系统 （:7 和上一步的number号相同）
export DISPLAY=:7
```

建议加入到启动项中。因为这个每次重启都需要重新执行一次

## selenium 安装

```bash
pip3 install selenium
```

## 测试

```bash
import selenium

from selenium import webdriver

driver = webdriver.Chrome()
driver.get('http://www.baidu.com')

print(driver.title)

driver.quit()
```

输出结果:

```bash
百度一下，你就知道
```
