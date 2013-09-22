FROM centos

MAINTAINER erickbrower

RUN yum groupinstall -y 'Development Tools'
RUN yum install -y httpd httpd-devel
RUN sed -i.bak -e '192d' /etc/httpd/conf/httpd.conf
RUN cd /tmp && wget http://downloads.jboss.org/mod_cluster/1.2.0.Final/mod_cluster-1.2.0.Final-linux2-x64-ssl.tar.gz
RUN cd /tmp && tar -zxvf mod_cluster-1.2.0.Final-linux2-x64-ssl.tar.gz
RUN cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_advertise.so /usr/lib64/httpd/modules/
RUN cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_manager.so /usr/lib64/httpd/modules/
RUN cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_proxy_cluster.so /usr/lib64/httpd/modules/
RUN cp /tmp/opt/jboss/httpd/lib/httpd/modules/mod_slotmem.so /usr/lib64/httpd/modules/
ADD https://dl.dropboxusercontent.com/s/kwm8sag0l718htl/mod_cluster.conf /etc/httpd/conf.d/mod_cluster.conf
RUN echo 'HOSTNAME=frontend' >> /etc/sysconfig/network
EXPOSE 80 6666 8443 5445 8675

CMD ['/usr/sbin/httpd', '-D', 'FOREGROUND']
