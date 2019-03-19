# DNS 配置

echo -e 'nameserver 223.6.6.6' >> /etc/resolv.conf
echo -e 'nameserver 8.8.8.8' >> /etc/resolv.conf

systemctl restart network

# 修改时间
rm -f /etc/localtime
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate cn.pool.ntp.org

echo -e "*/10 * * * * /usr/sbin/ntpdate cn.pool.ntp.org" >> /var/spool/cron/root

# 安装工具
yum install -y wget curl telnet

# 关闭 SELINUX
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0

# 配置文件
export LANG="en_US.UTF-8"
echo -e 'LANG="en_US.UTF-8"\nSYSFONT="latarcyrheb-sun16"' >> /etc/sysconfig/i18n
source /etc/sysconfig/i18n

sh ./centos-init.sh
