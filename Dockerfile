FROM fedora:rawhide
ENV DEBIAN_FRONTEND noninteractive
ENV PACKAGE ffmpeg
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN dnf install -y gcc gcc-c++ \
    libtool libtool-ltdl \
    make cmake wget \
    git epel-release \
    pkgconfig \
    rpmdevtools \
    automake autoconf \
    yum-utils rpm-build && \
    yum clean all

RUN rpmdev-setuptree && dnf download --source ffmpeg && rpm -ivh *.rpm
RUN cd ~/rpmbuild/ && ls SOURCES/ && ls SPECS/ && cd SPECS/ && yum-builddep -y *.spec && rpmbuild -ba *.spec
