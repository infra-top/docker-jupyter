
FROM infratop/jupyter-iruby:177037d09156


ARG IMAGE_ARG_FILESERVER


USER root

# https://github.com/filmor/ierl
RUN set -ex \
  && echo ===== Install ierl ===== \
  && apt -y update \
  && apt -y install erlang \
  && apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

RUN set -ex \
 && ${ARIA2C_DOWNLOAD} -d $(pwd) -o ierl ${IMAGE_ARG_FILESERVER:-https://github.com}/filmor/ierl/releases/download/v0.3.1/ierl \
 && chmod +x ierl \
 && ./ierl install erlang
