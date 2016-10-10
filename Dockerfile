FROM lsiobase/alpine
MAINTAINER phendryx

RUN \
# install runtime packages
 apk add --no-cache \
	ca-certificates \
	curl \
	libffi \
	libxml2 \
	libxslt \
	nginx \
	nodejs \
	openssl \
	ruby \
	zlib && \

# install build packages
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	automake \
	g++ \
	gcc \
	git \
	libffi-dev \
	libxml2-dev \
	libxslt-dev \
	make \
	ruby-bundler \
	ruby-dev \
	zlib-dev && \

# installing phantomjs via npm.
 npm -g install \
	phantomjs-prebuilt && \

# install github-dockerhub-sync
 echo 'gem: --no-document' > \
	/etc/gemrc && \
 git clone https://github.com/phendryx/github-dockerhub-sync.git \
	/opt/github-dockerhub-sync/ && \
 cd /opt/github-dockerhub-sync && \
 gem install bundler && \
 bundle install && \

# clean up
 apk del --purge \
	build-dependencies && \
 find /root -name . -o -prune -exec rm -rf -- {} +

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
