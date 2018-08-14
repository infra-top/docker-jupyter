
FROM infratop/jupyter-haskell-base:177037d09156


ARG IMAGE_ARG_FILESERVER
ARG ALL_PROXY


USER root

# https://github.com/gibiansky/IHaskell
RUN set -ex \
  && chown -R root $HOME/.stack \
  && stack install --fast \
  && chown -R jovyan $HOME/.stack


USER jovyan

RUN set -ex; \
  cd IHaskell; \
  ihaskell install --stack;


USER root
