## Contenedor
# Construir, SOLO PRIMERA VEZ
```bash
HOST_UID=$(id -u) HOST_GID=$(id -g) docker compose up -d --build
```
# Correr contenedor
```bash
docker start ubuntu20_foxy	==> Arrancar contenedor
docker stop ubuntu20_foxy	==> Parar contenedor

docker exec -it ubuntu20_foxy bash	==> Abrir terminal (ROS 2 Foxy se carga automáticamente)
```

