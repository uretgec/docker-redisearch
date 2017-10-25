# docker-redisearch
RediSearch Dockerfile

# Usage
- redis.conf file copy into "docker_volume_name" folder.
- Download redis.conf file: http://download.redis.io/redis-stable/redis.conf

Default Conf Run
```
$ docker run -d --name docker_redisearch -v <docker_volume_name>:/data uretgec/redisearch
```

Advanced Conf Run
```
$ docker run -d --name docker_redisearch -v <docker_volume_name>:/data -v <redis_conf_file>:/usr/local/etc/redis/redis.conf uretgec/redisearch
```

