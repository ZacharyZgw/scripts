FROM ubuntu:16.04
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade

#RUN apt-get install -y httpd
RUN apt-get install -y apache2
