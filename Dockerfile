FROM redis:latest as builder

ENV LIBDIR /var/lib/redis/modules
ENV DEPS "python python-setuptools python-pip wget unzip build-essential"
# Set up a build environment
RUN set -ex;\
    deps="$DEPS";\
    apt-get update; \
	apt-get install -y --no-install-recommends $deps;\
    pip install rmtest;

# Build the source
ADD ./src /src
WORKDIR /src
RUN set -ex;\
    deps="$DEPS";\
    make all -j 4; \
    make test;

# Package the runner
FROM redis:latest
ENV LIBDIR /var/lib/redis/modules
WORKDIR /data
RUN set -ex;\
    mkdir -p "$LIBDIR";
COPY --from=builder /src/redisearch.so  "$LIBDIR"

COPY redis.conf /usr/local/etc/redis/redis.conf
CMD ["redis-server", "/usr/local/etc/redis/redis.conf", "--loadmodule", "/var/lib/redis/modules/redisearch.so"]