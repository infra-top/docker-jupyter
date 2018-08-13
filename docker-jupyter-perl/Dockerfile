
FROM infratop/jupyter-golang:177037d09156


USER root

ENV PATH /usr/lib/perl6/site/bin:${PATH}

# https://github.com/bduggan/p6-jupyter-kernel
RUN set -ex; \
  echo ===== Install ierl =====; \
  apt -y update; \
  apt -y install libatomic-ops-dev libtommath-dev libuv1-dev perl6; \
  git clone https://github.com/ugexe/zef.git; \
  cd zef; \
  perl6 -I. bin/zef install .; \
  cd ..; \
  rm -rf zef; \
  zef install Jupyter::Kernel; \
  apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin


USER jovyan

RUN set -ex; \
  jupyter-kernel.p6 --generate-config;


USER root
