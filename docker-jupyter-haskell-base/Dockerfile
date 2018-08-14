
FROM infratop/jupyter-icsharp:177037d09156


ARG IMAGE_ARG_FILESERVER
ARG ALL_PROXY


USER root

# https://github.com/gibiansky/IHaskell
RUN set -ex \
  && echo ===== Install haskell ===== \
  && apt -y update \
  && apt -y install libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev python3-dev python3-pip python3-setuptools \
  && chown -R root $HOME/.cache \
  && pip3 install --upgrade pip setuptools wheel \
  && curl -sSL https://get.haskellstack.org/ | sh \
  && chown -R jovyan $HOME \
  && apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

#x https://github.com/gibiansky/IHaskell
RUN set -ex \
  && echo ===== Install haskell ===== \
  && git clone https://github.com/gibiansky/IHaskell \
  && cd IHaskell \
  && mkdir $HOME/.stack \
  && chown -R root $HOME/.cache \
  && pip3 install -r requirements.txt \
  && chown -R jovyan $HOME

COPY --chown=root:root docker /

RUN set -ex \
  && chown -R root $HOME/.stack \
  && mkdir -p $HOME/.stack/programs/x86_64-linux \
  && ls -la $HOME/.stack/programs/x86_64-linux \
  && if [ ! -f $HOME/.stack/programs/x86_64-linux/ghc-8.4.3.tar.xz ]; then \
         ${ARIA2C_DOWNLOAD} -d $HOME/.stack/programs/x86_64-linux -o ghc-8.4.3.tar.xz ${IMAGE_ARG_FILESERVER:-https://downloads.haskell.org}/~ghc/8.4.3/ghc-8.4.3-x86_64-deb8-linux.tar.xz; \
     else \
         echo '\npackage-indices:\n\
  - name: Tsinghua\n\
    download-prefix: http://mirrors.tuna.tsinghua.edu.cn/hackage/package/\n\
    http: http://mirrors.tuna.tsinghua.edu.cn/hackage/00-index.tar.gz\n' >> /etc/debconf.txt; \
     fi \
  && stack install gtk2hs-buildtools -v \
  && rm -f $HOME/.stack/programs/x86_64-linux/ghc-8.4.3.tar.xz \
  && chown -R jovyan $HOME/.stack
