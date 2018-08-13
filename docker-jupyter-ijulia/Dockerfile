
FROM infratop/jupyter-base:177037d09156


USER root

ARG IMAGE_ARG_JULIA_VERSION

# https://github.com/JuliaLang/IJulia.jl
# see: https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/Dockerfile
# Julia dependencies
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_PKGDIR=/opt/julia

# https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz
# https://support.slickedit.com/outbound/cmake/cmake-3.7.2/cmake-3.7.2-Linux-x86_64.tar.gz
RUN set -ex; \
  apt -y update; \
#  apt-get -y --no-install-recommends install cmake; \
  mkdir -p /opt/julia/v0.6/CMakeWrapper/deps/downloads; \
  ${ARIA2C_DOWNLOAD} -d /opt/julia/v0.6/CMakeWrapper/deps/downloads -o cmake-3.7.2-Linux-x86_64.tar.gz http://fileserver.infra.top/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz; \
  mkdir -p /opt/julia-${IMAGE_ARG_JULIA_VERSION:-0.6.2}; \
  cd /tmp; \
  wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${IMAGE_ARG_JULIA_VERSION:-0.6.2} | cut -d. -f 1,2`/julia-${IMAGE_ARG_JULIA_VERSION:-0.6.2}-linux-x86_64.tar.gz; \
  echo "dc6ec0b13551ce78083a5849268b20684421d46a7ec46b17ec1fab88a5078580 *julia-${IMAGE_ARG_JULIA_VERSION:-0.6.2}-linux-x86_64.tar.gz" | sha256sum -c -; \
  tar xzf julia-${IMAGE_ARG_JULIA_VERSION:-0.6.2}-linux-x86_64.tar.gz -C /opt/julia-${IMAGE_ARG_JULIA_VERSION:-0.6.2} --strip-components=1; \
  rm /tmp/julia-${IMAGE_ARG_JULIA_VERSION:-0.6.2}-linux-x86_64.tar.gz; \
  rm -f /opt/julia/v0.6/CMakeWrapper/deps/downloads/cmake-3.7.2-Linux-x86_64.tar.gz; \
  apt -q -y autoremove && apt -q -y clean && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia
# Show Julia where conda libraries are \
RUN set -ex \
  && mkdir -p /etc/julia && \
  echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
  # Create JULIA_PKGDIR \
  mkdir -p $JULIA_PKGDIR && \
  chown $NB_USER $JULIA_PKGDIR && \
  fix-permissions $JULIA_PKGDIR


USER jovyan

# https://github.com/JuliaLang/IJulia.jl
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.
# https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.0-patch1/src/hdf5-1.10.0-patch1.tar.gz
RUN set -ex; \
  mkdir -p /opt/julia/v0.6/HDF5/deps/downloads; \
  ${ARIA2C_DOWNLOAD} -d /opt/julia/v0.6/HDF5/deps/downloads -o hdf5-1.10.0-patch1.tar.gz http://fileserver.infra.top/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.0-patch1/src/hdf5-1.10.0-patch1.tar.gz; \
  julia -e 'Pkg.init()'; \
  julia -e 'Pkg.update()'; \
  (test $TEST_ONLY_BUILD || julia -e 'Pkg.add("HDF5")'); \
  julia -e 'Pkg.add("Gadfly")'; \
  julia -e 'Pkg.add("RDatasets")'; \
  julia -e 'Pkg.add("IJulia")'; \
  # Precompile Julia packages \
  julia -e 'using IJulia'; \
  # move kernelspec out of home \
  mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/; \
  chmod -R go+rx $CONDA_DIR/share/jupyter && \
  rm -rf $HOME/.local; \
  rm -f /opt/julia/v0.6/HDF5/deps/downloads/hdf5-1.10.0-patch1.tar.gz; \
  fix-permissions $JULIA_PKGDIR $CONDA_DIR/share/jupyter


USER root
