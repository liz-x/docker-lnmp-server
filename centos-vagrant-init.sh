#### 基础配置 ####

# 修改时间
yum -y install ntpdate deltarpm

rm -f /etc/localtime
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate cn.pool.ntp.org

echo -e "*/10 * * * * /usr/sbin/ntpdate cn.pool.ntp.org" >> /var/spool/cron/root

# 配置文件
export LANG="en_US.UTF-8"
echo -e 'LANG="en_US.UTF-8"\nSYSFONT="latarcyrheb-sun16"' >> /etc/sysconfig/i18n
source /etc/sysconfig/i18n

# 取消邮件提示
echo 'unset MAILCHECK' >> /etc/profile && source /etc/profile


#### YUM 源 ####

# 阿里镜像
# https://opsx.alibaba.com/mirror
# http://mirrors.aliyun.com/repo/

# 安装 curl 与 EPEL 源
yum install -y curl epel-release

# 备份 CentOS-Base.repo
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

# 使用阿里 YUM 源
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 使用阿里 EPEL 源
wget -O /etc/yum.repos.d/epel-7.repo http://mirrors.aliyun.com/repo/epel-7.repo

# 清除 YUM 缓存 && 更新 YUM 缓存
yum clean all && yum makecache


#### 添加 www-data 组和用户 ####
groupadd -g 33 www-data

# -s：指定用户所用的 shell，/sbin/nologin，表示不登录。
# -M：不创建用户主目录
useradd -u 33 -g www-data -s /sbin/nologin -M www-data

sudo usermod -aG vagrant www-data

#### 安装 Docker ####

# 安装 Docker
# 官方文档：https://docs.docker.com/install/linux/docker-ce/centos/
# 阿里文档：https://yq.aliyun.com/articles/110806/

cd /tmp/

curl -fsSL https://get.docker.com | sh -s docker --mirror Aliyun
sudo usermod -aG docker www-data

sudo systemctl start docker
sudo systemctl enable docker

# 配置镜像加速器(七牛)
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://reg-mirror.qiniu.com"]
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


#### 清理缓存文件 ####
yum clean all
rm -rf /tmp/* /var/tmp/* /var/cache/*
