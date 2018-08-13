
FROM infratop/jupyter-java:177037d09156


USER jovyan

# https://github.com/QuantStack/xeus-cling
# The safest usage is to create an environment named cling
#RUN set -ex; \
#  echo ===== Install xeus-cling =====; \
#  conda create -n cling; \
#  bash -c "source activate cling; conda install xeus-cling -c QuantStack -c conda-forge;";

RUN set -ex; \
  echo ===== Install xeus-cling =====; \
  conda install xeus-cling -c QuantStack -c conda-forge;

#The following packages were DOWNGRADED:
#pyzmq:         17.1.0-py36hae99301_0 conda-forge --> 17.0.0-cling_0 QuantStack [cling]
#zeromq:        4.2.5-hfc679d8_5      conda-forge --> 4.2.3-cling_3  QuantStack [cling]


USER root
