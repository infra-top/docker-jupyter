
FROM infratop/jupyter-perl:177037d09156


USER root

# https://github.com/gibiansky/IHaskell
#RUN set -ex \
#  && echo ===== Install haskell ===== \
#  && apt -y update \
#  && apt -y install python3-pip libtinfo-dev libzmq3-dev libcairo2-dev libpango1.0-dev libmagic-dev libblas-dev liblapack-dev \
#  && curl -sSL https://get.haskellstack.org/ | sh \
#  && apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

USER jovyan


#x https://github.com/gibiansky/IHaskell
#RUN set -ex \
#  && echo ===== Install haskell ===== \
#  && git clone https://github.com/gibiansky/IHaskell \
#  && cd IHaskell \
#  && pip3 install -r requirements.txt \
#  && stack install gtk2hs-buildtools \
#  && stack install --fast \
#  && ihaskell install --stack


USER root
