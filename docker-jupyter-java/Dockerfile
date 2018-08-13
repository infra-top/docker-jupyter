
FROM infratop/jupyter-cling:177037d09156

USER root

#COPY --from=cirepo/java-oracle:9.0.4-alpine-3.7-archive /data/root /
COPY --from=cirepo/java-oracle:10.0.1-alpine-3.7-archive /data/root /

ENV JAVA_HOME /usr/lib/jvm/java-10-oracle
ENV PATH ${JAVA_HOME}/bin:${PATH}

# https://github.com/SpencerPark/IJava
RUN set -ex; \
  mkdir -p .ijava; \
  ${ARIA2C_DOWNLOAD} -d $(pwd)/.ijava -o ijava-1.1.1.zip https://github.com/SpencerPark/IJava/releases/download/v1.1.1/ijava-1.1.1.zip; \
  cd .ijava; \
  unzip ijava-1.1.1.zip; \
  python3 install.py --sys-prefix;

# https://github.com/scijava/scijava-jupyter-kernel
RUN set -ex; \
  conda install scijava-jupyter-kernel -c conda-forge -y;
