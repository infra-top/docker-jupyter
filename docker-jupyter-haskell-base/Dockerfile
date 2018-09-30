
#FROM fpco/stack-build:lts-11.21
#FROM jupyter/datascience-notebook:2bfbb7d17524
FROM infratop/jupyter-icsharp:177037d09156


ARG IMAGE_ARG_FILESERVER


ENV ARIA2C_DOWNLOAD aria2c --file-allocation=none -c -x 10 -s 10 -m 0 --console-log-level=notice --log-level=notice --summary-interval=0


USER root


RUN set -ex \
  && apt-get -y update \
  && apt-get -y install apt-transport-https \
  && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin


#COPY --from=jupyter/datascience-notebook:2bfbb7d17524 / /
#COPY --from=fpco/stack-build:lts-11.21 / /

RUN curl -sSL https://get.haskellstack.org/ | sh

## https://github.com/commercialhaskell/stack/blob/master/etc/dockerfiles/stack-build/lts-11.0/Dockerfile
#ARG GHC_VERSION=8.2.2
#ARG LTS_SLUG=lts-11.21
#ARG PID1_VERSION=0.1.0.1
#ARG STACK_VERSION=1.6.5
#ARG BOOTSTRAP_COMMIT=13ab2b86779c98598e96af7f4c4b9653ba280be5
#ARG DEBIAN_FRONTEND=noninteractive
#
##
## Set encoding to UTF-8 and PATH to find GHC and cabal/stack-installed binaries.
##
#ENV LANG=C.UTF-8 \
#    LC_ALL=C.UTF-8 \
#    PATH=/root/.cabal/bin:/root/.local/bin:/opt/ghc/$GHC_VERSION/bin:$PATH
#
##
## Use Stackage's debian-bootstrap.sh script to install system libraries and
## tools required to build any Stackage package.
##
#RUN set -ex \
#  && wget -qO- https://raw.githubusercontent.com/fpco/stackage/$BOOTSTRAP_COMMIT/debian-bootstrap.sh | bash
#
##
## Create symlink to help tools find GHC documentation
##
#RUN ln -s ghc /opt/ghc/$GHC_VERSION/share/doc/ghc-$GHC_VERSION
#
##
## Use 'stack' to install basic Haskell tools like alex, happy, and cpphs. We
## remove most of the STACK_ROOT afterward to save space, but keep the 'share'
## files that some of these tools require.
##
#RUN stack --system-ghc --resolver=$LTS_SLUG --local-bin-path=/usr/local/bin install \
#        cabal-install happy alex cpphs gtk2hs-buildtools hscolour && \
#    cd $HOME/.stack && \
#    find . -type f -not -path './snapshots/*/share/*' -exec rm '{}' \; && \
#    find . -type d -print0 |sort -rz |xargs -0 rmdir 2>/dev/null || true
#
##
## Install 'pid1' init daemon
##
#RUN wget -O- "https://github.com/fpco/pid1/releases/download/pid1%2F$PID1_VERSION/pid1-$PID1_VERSION-linux-x86_64.tar.gz" | tar xzf - -C /usr/local && \
#    chown root:root /usr/local/sbin && \
#    chown root:root /usr/local/sbin/pid1
#
##
## Install Stack
##
##wget -qO- https://github.com/commercialhaskell/stack/releases/download/v$STACK_VERSION/stack-$STACK_VERSION-linux-x86_64.tar.gz | tar xz --wildcards --strip-components=1 -C /usr/local/bin '*/stack'
#RUN set -ex \
#  && ${ARIA2C_DOWNLOAD} -d $(pwd) -o stack.tar.gz https://github.com/commercialhaskell/stack/releases/download/v$STACK_VERSION/stack-$STACK_VERSION-linux-x86_64.tar.gz \
#  && tar xz --wildcards --strip-components=1 -C /usr/local/bin '*/stack' stack.tar.gz \
#  && rm -f stack.tar.gz
#
##
## Set up pid1 entrypoint and default command
##
#ENTRYPOINT ["/usr/local/sbin/pid1"]
#CMD ["bash"]


# F60F4B3D7FA2AF80 is key of repo http://*.download.nvidia.com
RUN set -ex \
  && cat /etc/os-release \
  && echo "jovyan ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jovyan \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F60F4B3D7FA2AF80 \
  && if [ -f /etc/apt/sources.list.d/cuda.list ]; then sed -i 's#deb http:#deb https:#' /etc/apt/sources.list.d/cuda.list; fi \
  && apt-get -y clean \
  && apt-get -y update \
  && apt-get -y install aria2 gnupg \
                    libblas-dev libcairo2-dev libgeoip-dev libffi-dev libgmp-dev \
                    libicu-dev libmagic-dev liblapack-dev libpango1.0-dev libsnappy-dev libtinfo-dev libzmq3-dev \
                    netbase python3-dev wget \
  && ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so /usr/lib/x86_64-linux-gnu/libtinfo.so.6 \
  && ls -la /var/cache/man/ \
  && apt-get -y -q purge python3-pip python-pip-whl \
  && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin
# python3-pip python3-setuptools python-pip-whl


# https://github.com/gibiansky/IHaskell
USER jovyan

RUN set -ex \
  && ${ARIA2C_DOWNLOAD} -d $(pwd) -o get-pip.py https://bootstrap.pypa.io/get-pip.py \
  && python3 get-pip.py \
  && pip3 install --upgrade setuptools wheel \
  && pip3 install pysocks
#  && curl -sSL https://get.haskellstack.org/ | sh

ARG ALL_PROXY

#x https://github.com/gibiansky/IHaskell
RUN set -ex \
  && echo ALL_PROXY ${ALL_PROXY} \
  && echo ===== Install haskell ===== \
  && git clone https://github.com/gibiansky/IHaskell \
  && cd IHaskell \
  && mkdir $HOME/.stack \
  && pip3 install -r requirements.txt

#COPY --chown=1000:1000 docker /
# ${ARIA2C_DOWNLOAD} -d $HOME/.stack/programs/x86_64-linux -o ghc-8.2.2.tar.xz ${IMAGE_ARG_FILESERVER:-https://downloads.haskell.org}/~ghc/8.2.2/ghc-8.2.2-x86_64-deb8-linux.tar.xz
# stack --resolver ghc-8.2.2 setup
# rm -f $HOME/.stack/programs/x86_64-linux/ghc-8.2.2.tar.xz

#package-indices:
#- name: Tsinghua
#  download-prefix: https://mirrors.tuna.tsinghua.edu.cn/hackage/package/
#  http: https://mirrors.tuna.tsinghua.edu.cn/hackage/01-index.tar.gz
#setup-info: "http://mirrors.tuna.tsinghua.edu.cn/stackage/stack-setup.yaml"
#urls:
#  latest-snapshot: http://mirrors.tuna.tsinghua.edu.cn/stackage/snapshots.json
#  lts-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/lts-haskell/
#  nightly-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/stackage-nightly/

RUN set -ex \
  && mkdir -p $HOME/.stack/programs/x86_64-linux \
  && ls -la $HOME/.stack/programs/x86_64-linux \
  && echo '\n\
package-indices:\n\
- name: Tsinghua\n\
  download-prefix: http://mirrors.tuna.tsinghua.edu.cn/hackage/package/\n\
  http: http://mirrors.tuna.tsinghua.edu.cn/hackage/00-index.tar.gz\n\
setup-info: "http://mirrors.tuna.tsinghua.edu.cn/stackage/stack-setup.yaml"\n\
urls:\n\
  latest-snapshot: http://mirrors.tuna.tsinghua.edu.cn/stackage/snapshots.json\n\
  lts-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/lts-haskell/\n\
  nightly-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/stackage-nightly/\n\
' >> $HOME/.stack/config.yaml \
  && cat $HOME/.stack/config.yaml \
  && stack install gtk2hs-buildtools -v


USER root
