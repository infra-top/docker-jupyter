
FROM infratop/jupyter-cling:177037d09156


ARG IMAGE_ARG_FILESERVER


USER root

# https://github.com/zabirauf/icsharp
RUN set -ex \
  && echo ===== Install icsharp ===== \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
  && apt -y update \
  && apt-get -y install binutils ca-certificates-mono fsharp mono-vbnc mono-devel mono-complete mono-dbg mono-runtime-dbg nuget referenceassemblies-pcl \
  && cert-sync /etc/ssl/certs/ca-certificates.crt \
  && yes | certmgr -ssl -m https://go.microsoft.com \
  && yes | certmgr -ssl -m https://nugetgallery.blob.core.windows.net \
  && yes | certmgr -ssl -m https://nuget.org \
  && mozroots --import --machine --sync \
  && mono --version \
  && apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin \
  && mkdir /icsharp \
  && chown -R $NB_USER /icsharp \
  && chown -R $NB_USER $HOME/.config/


USER jovyan

# https://github.com/zabirauf/icsharp
# https://github.com/zabirauf/icsharp/issues/46
# https://github.com/gyurisc/icsharp.kernel/releases/download/v1.0-beta/icsharp_kernel_v1.0.zip
RUN set -ex; \
  mkdir -p icsharp; \
  ${ARIA2C_DOWNLOAD} -d $(pwd)/icsharp -o icsharp_kernel_v1.0.zip ${IMAGE_ARG_FILESERVER:-https://github.com}/gyurisc/icsharp.kernel/releases/download/v1.0-beta/icsharp_kernel_v1.0.zip; \
  cd icsharp; \
  unzip icsharp_kernel_v1.0.zip; \
  rm -f icsharp_kernel_v1.0.zip; \
  mono icsharp.exe; \
  cd ..;

# following script not work
# https://github.com/zabirauf/icsharp
# issue: Unable to find version '1.9.2' of package 'xunit.runners'
# see: https://github.com/zabirauf/icsharp/issues/38
# see: https://github.com/3Dcube/docker-jupyter-icsharp/blob/master/Dockerfile
# Build scriptcs
#RUN set -ex \
#  && git clone --recursive https://github.com/zabirauf/icsharp.git /icsharp \
#  && cd /icsharp/Engine \
#  && mozroots --import --sync --quiet \
#  && mono ./.nuget/NuGet.exe restore ./ScriptCs.sln \
#  && mkdir -p artifacts/Release/bin
## Build iCSharp
#RUN cd /icsharp \
#  && mozroots --import --sync --quiet \
#  && mono ./.nuget/NuGet.exe restore ./iCSharp.sln \
#  && mkdir -p build/Release/bin \
#  && xbuild ./iCSharp.sln /property:Configuration=Release /nologo /verbosity:normal
## Copy files safely
#RUN for line in $(find ./*/bin/Release/*); do cp $line ./build/Release/bin; done
## Install kernel
#COPY docker/kernel.json /icsharp/kernel-spec/kernel.json
#RUN jupyter-kernelspec install --user kernel-spec


USER root
