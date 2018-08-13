
FROM jupyter/all-spark-notebook:177037d09156

USER jovyan


# https://github.com/takluyver/bash_kernel
RUN set -ex; \
  pip install bash_kernel;

# https://github.com/ansible/ansible-jupyter-kernel
RUN set -ex \
  && echo ===== Install ansible ===== \
  && pip install ansible-kernel \
  && python -m ansible_kernel.install --sys-prefix


#x https://github.com/akabe/ocaml-jupyter
#RUN set -ex \
#  && echo ===== Install ocaml ===== \
#  && jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter"


USER root
