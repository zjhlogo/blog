# MySQL基础

## 登入
``` bash
$ mysql -u root -p
```

## 创建数据库
``` bash
$ create database xxx;
```

## 创建用户
``` bash
# '%' any remote login
# 'localhost' only localhost login
# '192.168.x.x' only ip login

$ create user 'username'@'%' identified by 'password';
```

## 授权使用数据库
``` bash
$ grant all on xxx.* to 'username'@'%';
```

