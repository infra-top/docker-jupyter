
FROM infratop/jupyter-ijavascript:177037d09156


USER root

# https://github.com/SciRuby/iruby
RUN set -ex \
  && echo ===== Install iruby ===== \
  && apt -y update \
  && apt -y install libtool libffi-dev ruby ruby-dev make \
  && apt -y install libzmq3-dev libczmq-dev \
  && gem install cztop iruby \
  && apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin


USER jovyan

RUN set -ex; \
  iruby register --force;


USER root
