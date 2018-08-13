
FROM infratop/jupyter-ierl:177037d09156

ARG IMAGE_ARG_FILESERVER

USER root

# see: https://github.com/docker-library/golang/blob/4e30a6bb9f410004a8ecd2336e589f441b7398ec/1.9/stretch/Dockerfile
# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.9.7
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN set -eux; \
	\
# this "case" statement is generated via "update.sh"
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
		amd64) goRelArch='linux-amd64'; goRelSha256='88573008f4f6233b81f81d8ccf92234b4f67238df0f0ab173d75a302a1f3d6ee' ;; \
		armhf) goRelArch='linux-armv6l'; goRelSha256='83b165d617807d636d2cfe07f34920ab6e5374a07ab02d60edcaec008de608ee' ;; \
		arm64) goRelArch='linux-arm64'; goRelSha256='68f48c29f93e4c69bbbdb335f473d666b9f8791643f4003ef45283a968b41f86' ;; \
		i386) goRelArch='linux-386'; goRelSha256='c689fdb0b4f4530e48b44a3e591e53660fcbc97c3757ff9c3028adadabcf8378' ;; \
		ppc64el) goRelArch='linux-ppc64le'; goRelSha256='66cc2b9d591c8ef5adc4c4454f871546b0bab6be1dcbd151c2881729884fbbdd' ;; \
		s390x) goRelArch='linux-s390x'; goRelSha256='7148ba7bc6f40b342d35a28b0cc43dd8f2b2acd7fb3e8891bc95b0f783bc8c9f' ;; \
		*) goRelArch='src'; goRelSha256='582814fa45e8ecb0859a208e517b48aa0ad951e3b36c7fff203d834e0ef27722'; \
			echo >&2; echo >&2 "warning: current architecture ($dpkgArch) does not have a corresponding Go binary release; will be building from source"; echo >&2 ;; \
	esac; \
	\
	url="https://${IMAGE_ARG_FILESERVER:-golang.org/dl}/go${GOLANG_VERSION}.${goRelArch}.tar.gz"; \
#	wget -O go.tgz "$url"; \
    ${ARIA2C_DOWNLOAD} -d $(pwd) -o go.tgz "$url"; \
	echo "${goRelSha256} *go.tgz" | sha256sum -c -; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	if [ "$goRelArch" = 'src' ]; then \
		echo >&2; \
		echo >&2 'error: UNIMPLEMENTED'; \
		echo >&2 'TODO install golang-any from jessie-backports for GOROOT_BOOTSTRAP (and uninstall after build)'; \
		echo >&2; \
		exit 1; \
	fi; \
	\
	export PATH="/usr/local/go/bin:$PATH"; \
	go version; \
	mkdir -p "$GOPATH/src" "$GOPATH/bin"; chown -R $NB_USER "$GOPATH"; chmod -R 777 "$GOPATH"

ENV LGOPATH /lgo
RUN mkdir -p $LGOPATH; chown -R $NB_USER "$LGOPATH"; chmod -R 777 "$LGOPATH"

USER jovyan

# go 1.9+
# https://github.com/gopherdata/gophernotes
RUN set -ex \
 && go get -u github.com/cosmos72/gomacro \
 && go get -u github.com/gopherdata/gophernotes \
 && mkdir -p $(jupyter --data-dir)/kernels/gophernotes \
 && cp $GOPATH/src/github.com/gopherdata/gophernotes/kernel/* $(jupyter --data-dir)/kernels/gophernotes

# go 1.9+
# https://github.com/yunabe/lgo
# see: https://github.com/yunabe/lgo/blob/master/docker/image/Dockerfile

# Support UTF-8 filename in Python (https://stackoverflow.com/a/31754469)
ENV LC_CTYPE=C.UTF-8

RUN set -ex; \
  git config --global http.sslVerify true; \
  go get -u github.com/xkeyideal/glide; \
  mkdir -p ${HOME}/.glide; \
  cd $GOPATH; \
  glide init --skip-import --non-interactive;

## Fetch lgo repository, Install packages used from example notebooks
RUN set -ex; \
  cd $GOPATH; \
  glide mirror set https://golang.org/x/net https://github.com/golang/net --base golang.org/x/net --vcs git; \
  glide mirror set https://golang.org/x/sys/unix https://github.com/golang/sys --base golang.org/x/sys --vcs git; \
  glide mirror set https://golang.org/x/sys/windows https://github.com/golang/sys --base golang.org/x/sys --vcs git; \
  glide mirror set https://golang.org/x/exp/rand https://github.com/golang/exp -- base golang.org/x/exp --vcs git; \
  glide mirror set https://golang.org/x/tools/container/intsets https://github.com/golang/tools --base golang.org/x/tools --vcs git; \
  glide mirror set https://golang.org/x/image/font https://github.com/golang/image --base golang.org/x/image --vcs git; \
  glide mirror set https://golang.org/x/image/draw https://github.com/golang/image --base golang.org/x/image --vcs git; \
  glide mirror set https://golang.org/x/image/math/fixed https://github.com/golang/image --base golang.org/x/image --vcs git; \
  glide mirror set https://golang.org/x/image/math/f64 https://github.com/golang/image --base golang.org/x/image --vcs git; \
  glide mirror set https://golang.org/x/image/tiff https://github.com/golang/image --base golang.org/x/image --vcs git; \
  glide mirror set https://golang.org/x/image https://github.com/golang/image --base golang.org/x/image --vcs git; \
  glide mirror set https://gonum.org/v1/netlib https://github.com/gonum/netlib --base gonum.org/v1/netlib --vcs git; \
  glide mirror set https://gonum.org/v1/gonum https://github.com/gonum/gonum --base gonum.org/v1/gonum --vcs git; \
  glide mirror set https://gonum.org/v1/plot https://github.com/gonum/plot --base gonum.org/v1/plot --vcs git; \
  go get github.com/yunabe/lgo/cmd/lgo; \
#  go get -d github.com/yunabe/lgo/cmd/lgo-internal; \
  glide get github.com/yunabe/lgo/cmd/lgo-internal; \
#  go get -u github.com/nfnt/resize gonum.org/v1/gonum/... gonum.org/v1/plot/... github.com/wcharczuk/go-chart
  glide get --non-interactive github.com/nfnt/resize gonum.org/v1/gonum/... gonum.org/v1/plot/... github.com/wcharczuk/go-chart

## Install lgo
RUN set -ex; \
  cd $GOPATH; \
  go get github.com/golang/glog; \
  go get github.com/pebbe/zmq4; \
  cp -r /go/vendor/golang.org /go/src/github.com/yunabe/lgo/vendor/golang.org; \
  lgo install;

RUN set -ex; \
  cd $GOPATH; \
  glide get github.com/golang/freetype; \
  glide get golang.org/x/image; \
  cp -r /go/vendor/github.com/nfnt /go/src/github.com/; \
  cp -r /go/vendor/github.com/wcharczuk /go/src/github.com/; \
  cp -r /go/vendor/github.com/golang /go/src/github.com/; \
  cp -r /go/vendor/golang.org /go/src/; \
  lgo installpkg github.com/nfnt/resize gonum.org/v1/gonum/... gonum.org/v1/plot/... github.com/wcharczuk/go-chart; \
  $GOPATH/src/github.com/yunabe/lgo/bin/install_kernel;

USER root
