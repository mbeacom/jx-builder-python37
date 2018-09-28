FROM jenkinsxio/builder-base:latest

RUN yum update  -y

# Install build pre-requisites
RUN yum -y install gcc openssl-devel bzip2-devel libffi-devel

# Install Python 3.7
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz && \
    tar xzf Python-3.7.0.tgz && \
    cd Python-3.7.0 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    rm /usr/src/Python-3.7.0.tgz && \
    cd ../ && \
    rm -rf /usr/src/Python-3.7.0

# Link Python 3.7 binary as default Python 3
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python3
RUN yum -y remove gcc openssl-devel bzip2-devel

CMD ["python3", "--version"]
