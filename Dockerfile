FROM phusion/baseimage:0.9.16
MAINTAINER Rex Addiscentis <raddiscentis@addiscent.com>

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y php5-fpm php5-cli php5-curl php5-mysqlnd

RUN sed -i '/^cgi.fix_pathinfo /c cgi.fix_pathinfo = 0;' /etc/php5/fpm/php.ini
RUN sed -i '/^default_charset /c default_charset = "UTF-8"' /etc/php5/fpm/php.ini
RUN sed -i '/^listen /c listen = 9000' /etc/php5/fpm/pool.d/www.conf
RUN sed -i '/^daemonize /c daemonize = no' /etc/php5/fpm/php-fpm.conf


RUN mkdir -p /etc/service/php-fpm
ADD start.sh /etc/service/php-fpm/run
RUN chmod +x /etc/service/php-fpm/run

EXPOSE 9000

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
