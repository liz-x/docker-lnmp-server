# DOCKER-LNMP-SERVER

## 新建 websvr

``` shell
cd /

# 拉取项目
git clone https://github.com/liz-x/docker-server.git websvr
cd websvr

# 删除 git 信息
rm -rf .git*

# 系统初始化（ECS 版）
sudo sh ./centosInit.sh
```



## 目录说明

```shell
# 项目目录
/websvr/www # web 站点
/websvr/ssl # cert key
/websvr/log # svr 日志
/websvr/vhost # 虚拟主机
/websvr/script # 脚本

# docker-compose
/websvr/compose # compose 根目录
/websvr/compose/conf # 基础配置
/websvr/compose/demo # demo 服务

# NMP LOG 目录
/websvr/log/nginx # nginx 日志
/websvr/log/mysql # mysql 日志
/websvr/log/php # php 日志
```



## 启动服务

``` shell
# Demo 服务
cd /websrv/compose/demo
docker-compose up -d

# 容器状态
[root@zsky sky] docker-compose ps

# 测试
[root@zsky ~] curl localhost
Hello World.
```

