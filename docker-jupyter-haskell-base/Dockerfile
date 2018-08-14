
FROM infratop/jupyter-icsharp:177037d09156


ARG IMAGE_ARG_FILESERVER


USER root

# https://github.com/gibiansky/IHaskell
RUN set -ex \
  && echo "jovyan ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jovyan \
  && apt -y update \
  && apt -y install libblas-dev libcairo2-dev libgeoip-dev libicu-dev libmagic-dev liblapack-dev libpango1.0-dev \
                    libsnappy-dev libtinfo-dev libzmq3-dev python3-dev \
  && apt-get -y -q purge python3-pip python-pip-whl \
  && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin
# python3-pip python3-setuptools python-pip-whl


USER jovyan

RUN set -ex \
  && ${ARIA2C_DOWNLOAD} -d $(pwd) -o get-pip.py https://bootstrap.pypa.io/get-pip.py \
  && python3 get-pip.py \
  && pip3 install --upgrade setuptools wheel \
  && pip3 install pysocks \
  && curl -sSL https://get.haskellstack.org/ | sh


ARG ALL_PROXY


#x https://github.com/gibiansky/IHaskell
RUN set -ex \
  && echo ALL_PROXY ${ALL_PROXY} \
  && echo ===== Install haskell ===== \
  && git clone https://github.com/gibiansky/IHaskell \
  && cd IHaskell \
  && mkdir $HOME/.stack \
  && pip3 install -r requirements.txt

COPY --chown=1000:1000 docker /

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
  && if [ ! -f $HOME/.stack/programs/x86_64-linux/ghc-8.4.3.tar.xz ]; then \
         ${ARIA2C_DOWNLOAD} -d $HOME/.stack/programs/x86_64-linux -o ghc-8.4.3.tar.xz ${IMAGE_ARG_FILESERVER:-https://downloads.haskell.org}/~ghc/8.4.3/ghc-8.4.3-x86_64-deb8-linux.tar.xz; \
     else \
         echo '\n\
package-indices:\n\
- name: Tsinghua\n\
  download-prefix: http://mirrors.tuna.tsinghua.edu.cn/hackage/package/\n\
  http: http://mirrors.tuna.tsinghua.edu.cn/hackage/01-index.tar.gz\n\
setup-info: "http://mirrors.tuna.tsinghua.edu.cn/stackage/stack-setup.yaml"\n\
urls:\n\
  latest-snapshot: http://mirrors.tuna.tsinghua.edu.cn/stackage/snapshots.json\n\
  lts-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/lts-haskell/\n\
  nightly-build-plans: http://mirrors.tuna.tsinghua.edu.cn/stackage/stackage-nightly/\n\
' >> $HOME/.stack/config.yaml; \
     fi \
  && stack install gtk2hs-buildtools -v \
  && rm -f $HOME/.stack/programs/x86_64-linux/ghc-8.4.3.tar.xz


USER root
