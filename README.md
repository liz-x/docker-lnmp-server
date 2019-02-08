# DOCKER-LNMP-SERVER

## 初始化

``` shell
cd /

# 拉取项目
git clone https://github.com/liz-x/docker-server.git websvr
cd websvr
rm -rf .git*

# 系统初始化（ECS 版）
sudo sh ./centosInit.sh
```

## 启动服务

``` shell
# Demo 服务
cd /websrv/compose/demo
docker-compose up -d

[root@zsky ~] \# curl localhost
Hello World.
```

