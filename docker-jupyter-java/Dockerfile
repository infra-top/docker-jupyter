
FROM infratop/jupyter-perl:177037d09156


ARG IMAGE_ARG_FILESERVER


USER jovyan

# https://github.com/scijava/scijava-jupyter-kernel
RUN set -ex; \
  conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/; \
  conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/; \
  conda config --set show_channel_urls yes; \
  conda install scijava-jupyter-kernel -c conda-forge -y;


USER root

#COPY --from=cirepo/java-oracle:9.0.4-alpine-3.8-archive /data/root /
COPY --from=cirepo/java-oracle:10.0.1-alpine-3.8-archive /data/root /

# JAVA_HOME breaks spylon-kernel (Scala)
#ENV JAVA_HOME /usr/lib/jvm/java-10-oracle
#ENV PATH ${JAVA_HOME}/bin:${PATH}

# https://github.com/SpencerPark/IJava
RUN set -ex; \
  mkdir -p .ijava; \
  ${ARIA2C_DOWNLOAD} -d $(pwd)/.ijava -o ijava-1.1.1.zip ${IMAGE_ARG_FILESERVER:-https://github.com}/SpencerPark/IJava/releases/download/v1.1.1/ijava-1.1.1.zip; \
  cd .ijava; \
  unzip ijava-1.1.1.zip; \
  python3 install.py --sys-prefix; \
  sed -i 's#"java",#"/usr/lib/jvm/java-10-oracle/bin/java",#' /opt/conda/share/jupyter/kernels/java/kernel.json;
