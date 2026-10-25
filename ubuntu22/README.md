# Ubuntu 22.04 — ROS 2 Humble

Ejecuta los siguientes comandos desde la carpeta `ubuntu22`.

## 1. Construir y crear el contenedor por primera vez

```bash
HOST_UID=$(id -u) HOST_GID=$(id -g) docker compose up -d --build
```

## 2. Arrancar el contenedor

```bash
docker start ubuntu22_humble
```

## 3. Abrir una terminal

```bash
docker exec -it ubuntu22_humble bash
```

## 4. Parar el contenedor

```bash
docker stop ubuntu22_humble
```

## Permisos para abrir ventanas gráficas

Si no tienes permisos para abrir ventanas gráficas desde el contenedor, ejecuta
este comando en una terminal del **host**, fuera del contenedor, y vuelve a abrir
la aplicación gráfica:

```bash
xhost +SI:localuser:$(id -un)
```
