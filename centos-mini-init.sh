# 修改时间
yum -y install ntpdate

rm -f /etc/localtime
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate cn.pool.ntp.org

echo -e "*/10 * * * * /usr/sbin/ntpdate cn.pool.ntp.org" >> /var/spool/cron/root

# 配置文件
export LANG="en_US.UTF-8"
echo -e 'LANG="en_US.UTF-8"\nSYSFONT="latarcyrheb-sun16"' >> /etc/sysconfig/i18n
source /etc/sysconfig/i18n

source ./centos-init.sh
