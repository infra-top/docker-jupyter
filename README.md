# docker-jupyter


```bash
docker-compose -f docker-compose_jupyter-base.yml build --pull

docker-compose -f docker-compose_jupyter-ijulia.yml build --pull

docker-compose -f docker-compose_jupyter-python2.yml build --pull

docker-compose -f docker-compose_jupyter-ijavascript.yml build --pull

docker-compose -f docker-compose_jupyter-iruby.yml build --pull

docker-compose -f docker-compose_jupyter-ierl.yml build --pull

docker-compose -f docker-compose_jupyter-golang.yml build --pull

docker-compose -f docker-compose_jupyter-cling.yml build --pull

docker-compose -f docker-compose_jupyter-java.yml build --pull

#docker-compose -f docker-compose_jupyter-perl.yml build --pull

#docker-compose -f docker-compose_jupyter-icsharp.yml build --pull
```


```bash
docker network create --driver=bridge --ipv6 --ipam-driver=default --subnet=172.16.238.0/24 --subnet=2001:3984:3989::/64 local-network

# start up
docker-compose up

# find URL with token in console e.g. https://(58c8a3d0fa05 or 127.0.0.1):8888/?token=eb8a19a4dc33cd4ac5dfc3aaf98fad7a5312a669422a5a96

# shutdown
docker-compose stop

# destroy
docker-compose down -v
```



[github.com/jupyter/docker-stacks](https://github.com/jupyter/docker-stacks)

[Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/)

[Selecting an Image](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html)

[Jupyter kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

## TODOs

https://medium.com/eliiza-ai/swift-4-1-in-a-jupyter-notebook-725601f79c68
https://github.com/ligee/kotlin-jupyter
https://github.com/pprzetacznik/IElixir
