
FROM jupyter/all-spark-notebook:177037d09156

ARG IMAGE_ARG_APT_MIRROR


#${ARIA2C_DOWNLOAD} -d ${out_dir} -o ${out_file} ${url}
# wget -q -O ${out_dir}/${out_file} ${url}
# curl -o ${out_dir}/${out_file} ${url}
ENV ARIA2C_DOWNLOAD aria2c --file-allocation=none -c -x 10 -s 10 -m 0 --console-log-level=notice --log-level=notice --summary-interval=0


USER root

RUN set -ex \
  && echo ===== Install utils for $(whoami), pwd $(pwd) ===== \
  && sed -i "s/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/${IMAGE_ARG_APT_MIRROR:-archive.ubuntu.com}\/ubuntu\//g" /etc/apt/sources.list \
  && apt -y update \
  && apt-get -y --no-install-recommends install apt-transport-https apt-utils aria2 autoconf automake \
  binutils bison bzip2 ca-certificates curl dirmngr dnsutils fonts-dejavu gcc gfortran git gnupg gnupg2 gnupg1 \
  libcurl4-openssl-dev libffi-dev libncurses-dev libreadline-dev libxslt-dev libssl-dev libtool libxml2-dev libxrender1 libxslt1-dev libyaml-dev \
  make mercurial ntp openssh-client openssl python3-pip \
  software-properties-common sqlite3 sudo tar tzdata unzip vim wget xz-utils zip zlib1g-dev \
  && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin
