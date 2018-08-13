
FROM infratop/jupyter-ijulia:177037d09156

USER jovyan

# https://stackoverflow.com/questions/30492623/using-both-python-2-x-and-python-3-x-in-ipython-notebook
RUN set -ex; \
  conda create -n py27 python=2.7 -y;

RUN set -ex; \
  echo ===== Install ipykernel =====; \
  bash -c "source activate py27; conda install ipykernel -y; ipython kernel install --user;";


USER root
