FROM ros:humble-ros-base-jammy

ARG DEBIAN_FRONTEND=noninteractive

ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=1000

USER root

# Herramientas comunes a ambas imagenes.
RUN apt-get update && apt-get install -y \
    sudo \
    python3-pip \
    cmake \
    curl \
    wget \
    nano \
    vim \
    less \
    tree \
    htop \
    iputils-ping \
    net-tools \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

# Paquetes especificos de ROS Humble.
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd \
        --uid ${USER_UID} \
        --gid ${USER_GID} \
        --create-home \
        --shell /bin/bash \
        ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" \
        > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN echo "source /opt/ros/humble/setup.bash" \
    >> /home/${USERNAME}/.bashrc

USER ${USERNAME}

WORKDIR /home/${USERNAME}/carpeta_compartida

CMD ["bash"]
