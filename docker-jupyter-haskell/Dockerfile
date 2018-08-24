
FROM infratop/jupyter-haskell-base:177037d09156


ARG IMAGE_ARG_FILESERVER
ARG ALL_PROXY


USER jovyan

# https://github.com/gibiansky/IHaskell
RUN set -ex \
  && cd IHaskell \
  && stack install --fast

ENV PATH /home/jovyan/.local/bin:${PATH}

RUN set -ex; \
  cd IHaskell; \
  ihaskell install --stack;


USER root
