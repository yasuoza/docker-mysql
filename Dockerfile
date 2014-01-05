FROM ubuntu:quantal
MAINTAINER Yasuharu Ozaki "http://github.com/yasuoza"

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN ! DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor mysql-server pwgen

# Add image configuration and scripts
ADD run.sh /run.sh
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh

ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD my.cnf /etc/mysql/conf.d/my.cnf


VOLUME ["/var/lib/mysql"]

EXPOSE 3306
CMD ["/run.sh"]
