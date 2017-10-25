FROM redislabs/redisearch:latest

COPY redis.conf /usr/local/etc/redis/redis.conf
CMD ["redis-server", "/usr/local/etc/redis/redis.conf", "--loadmodule", "/var/lib/redis/modules/redisearch.so"]