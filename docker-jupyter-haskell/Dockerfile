
FROM infratop/jupyter-haskell-base:177037d09156


ARG IMAGE_ARG_FILESERVER
ARG ALL_PROXY


USER jovyan

# https://github.com/gibiansky/IHaskell
RUN set -ex \
  && cd IHaskell \
  && sudo ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so /usr/lib/x86_64-linux-gnu/libtinfo.so.6 \
  && stack install --fast

ENV PATH /home/jovyan/.local/bin:${PATH}

RUN set -ex; \
  cd IHaskell; \
  ihaskell install --stack;


USER root
