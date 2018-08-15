
FROM infratop/jupyter-icsharp:177037d09156


USER jovyan

# https://github.com/ansible/ansible-jupyter-kernel
RUN set -ex \
  && echo ===== Install ansible ===== \
  && pip install ansible-kernel \
  && python3 -m ansible_kernel.install --sys-prefix

# http://calysto.github.io/
# https://github.com/Calysto/calysto_scheme
# https://github.com/Calysto/calysto_prolog
# http://du.zoomquiet.io/2017-10/scheme-in-jupyter/
RUN set -ex \
  && echo ===== Install calysto prolog scheme ===== \
  && pip install --upgrade calysto \
  && pip install --upgrade calysto-scheme --user \
  && python3 -m calysto_scheme install --user \
  && pip install --upgrade calysto_prolog --user \
  && python3 -m calysto_prolog install --user

# https://github.com/takluyver/bash_kernel
RUN set -ex; \
  pip install bash_kernel; \
  python -m bash_kernel.install;

#x https://github.com/akabe/ocaml-jupyter
#RUN set -ex \
#  && echo ===== Install ocaml ===== \
#  && jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter"


USER root
