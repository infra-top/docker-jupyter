
FROM infratop/jupyter-java:177037d09156


ARG IMAGE_ARG_FILESERVER


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

RUN set -ex \
  && chown -R root $HOME/.stack \
  && stack install gtk2hs-buildtools \
  && chown -R jovyan $HOME/.stack

RUN set -ex \
  && chown -R root $HOME/.stack \
  && stack install --fast \
  && chown -R jovyan $HOME/.stack


USER jovyan

RUN set -ex; \
  cd IHaskell; \
  ihaskell install --stack;


USER root
