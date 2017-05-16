FROM shipsun/centos6.8
MAINTAINER nginx proxy Image <543999860@qq.com>
LABEL name="nginx proxy Image" \
    vendor="shipSun" \
    build-date="2017-05-09"

RUN yum -y install wget unzip zip gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel


RUN cd /home/ && wget http://nginx.org/download/nginx-1.12.0.tar.gz
# Default command
#ENTRYPOINT ["/bin/bash","/usr/local/nginx/sbin/nginx"]
USER root
RUN groupadd www
RUN useradd -g www -s /bin/nologin www
RUN cd /home && tar zxvf nginx-1.12.0.tar.gz && cd /home/nginx-1.12.0 && ./configure \
--user=www \
--group=www \
--prefix=/usr/local/nginx \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-threads && make && make install && cd .. && rm -rf nginx-1.12.0.tar.gz nginx-1.12.0 && rm -rf /usr/local/nginx/conf/nginx.conf

RUN cd /home/ && wget https://github.com/shipSun/nginx/archive/master.zip
RUN cd /home/ && unzip master.zip && cd /home/nginx-master && mv /home/nginx-master/nginx.conf /usr/local/nginx/conf && mv /home/nginx-master/upstream.conf /usr/local/nginx/conf && mv /home/nginx-master/vhost /usr/local/nginx/conf && cd .. && rm -rf master.zip nginx-master

EXPOSE 80