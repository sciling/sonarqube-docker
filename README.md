# Introduction
This project aims at providing a sonarqube image that can be used to develop python projects.
It comes with a set of plugins preinstalled that can be seen at [configure-sonarqube.sh](configure-sonarqube.sh)
in the PLUGIN_LIST variable.
More plugins can be added to the list if necessary.


# Getting Started
To build the image just:
```
docker compose build
```

Sonarqube depends on an ElasticSearch instance that runs inside the same container.
For ElasticSearch to work you need to adjust `vm.max_map_count` like this:
```bash
# https://stackoverflow.com/a/50371108
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```


To run a local instance:
```
docker compose up -d
```

The service is not protected by https so it is recommended to use a reverse proxy with a SSL to protect
the service.
