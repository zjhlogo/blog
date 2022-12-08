# Linux 基础

## 添加运行路径

```bash
export PATH=$PATH:/usr/local/node/bin
```


## 设置代理
```bash
# 添加到 ~/.bashrc
# Set Proxy
function setproxy()
{
    export {http,https,ftp}_proxy="http://192.168.10.162:10809"
    export {HTTP,HTTPS,FTP}_PROXY="http://192.168.10.162:10809"
}

# Unset Proxy
function unsetproxy()
{
    unset {http,https,ftp}_proxy
    unset {HTTP,HTTPS,FTP}_PROXY
}
```
