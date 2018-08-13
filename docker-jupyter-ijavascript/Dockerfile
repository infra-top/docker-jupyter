
FROM infratop/jupyter-python2:177037d09156


USER root

# https://github.com/n-riesco/ijavascript
RUN set -ex \
  && echo ===== Install ijavascript ===== \
  && apt -y update \
  && apt -y install nodejs npm


USER jovyan

# https://github.com/n-riesco/ijavascript
RUN set -ex \
  && echo ===== Install ijavascript ===== \
  && npm install -g ijavascript \
  && ijsinstall


USER root
