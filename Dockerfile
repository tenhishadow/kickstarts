FROM centos:7

RUN yum update -y && rm -rf /var/cache/yum
RUN yum -y install epel-release
RUN yum -y install pykickstart

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]
