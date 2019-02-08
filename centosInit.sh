####------------ ECS 版 ------------####

#### YUM 源 ####

# 阿里镜像
# https://opsx.alibaba.com/mirror
# http://mirrors.aliyun.com/repo/

# 备份 CentOS-Base.repo
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

# 安装 wget
yum install -y wget

# 使用阿里 YUM 源
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 清除 YUM 缓存 && 更新 YUM 缓存
yum clean all && yum makecache

# 安装 EPEL 源
yum install -y epel-release

# 使用阿里 EPEL 源
wget -O /etc/yum.repos.d/epel-7.repo http://mirrors.aliyun.com/repo/epel-7.repo

# 清除 YUM 缓存 && 更新 YUM 缓存
yum clean all && yum makecache


#### 添加 www-data 用户 ####
groupadd www-data
useradd -g www-data www-data

chown -R www-data:www-data /websvr/

echo -e "*/1 * * * * chown -R www-data:www-data /websvr/;" >> /var/spool/cron/root


#### 安装 Docker ####
cd /tmp/

# 安装 Docker
# 官方文档：https://docs.docker.com/install/linux/docker-ce/centos/
# 阿里文档：https://yq.aliyun.com/articles/110806/
curl -fsSL https://get.docker.com | sh -s docker --mirror Aliyun
sudo usermod -aG docker www-data

sudo systemctl start docker
sudo systemctl enable docker

# 配置镜像加速器(阿里)
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://fm9u2lxx.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# 安装 docker-compose
# 官方文档：https://docs.docker.com/compose/install/
#
# 超时解决方法：
# 方法1：
#    ping github-cloud.s3.amazonaws.com
#    hosts：ip github-cloud.s3.amazonaws.com
# 方法2：
#    使用 https://get.daocloud.io
#
# 这里使用方法 2
#
sudo curl -L "https://get.daocloud.io/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
