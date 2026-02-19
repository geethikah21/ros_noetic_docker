FROM osrf/ros:noetic-desktop-full

ARG CUSTOM_UID=1000
ARG CUSTOM_GID=1000
ARG CUSTOM_USERNAME=noetic
ARG DIR=/home/${CUSTOM_USERNAME}/fast_calib_ws

ENV CUSTOM_UID ${CUSTOM_UID}
ENV CUSTOM_GID ${CUSTOM_GID}
ENV CUSTOM_USERNAME ${CUSTOM_USERNAME}

RUN if [ -z "$(getent group  ${CUSTOM_GID})" ] ; then addgroup --gid ${CUSTOM_GID} ${CUSTOM_USERNAME}; fi
RUN if [ -z "$(getent passwd ${CUSTOM_UID})" ] ; then adduser --uid ${CUSTOM_UID} --gid ${CUSTOM_GID} --disabled-password --gecos '' ${CUSTOM_USERNAME}; fi

RUN echo "$CUSTOM_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV DIR ${DIR}

RUN mkdir -p ${DIR}

ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,graphics

RUN chown -R ${CUSTOM_USERNAME}:${CUSTOM_USERNAME} /home/${CUSTOM_USERNAME}

ENV USER ${CUSTOM_USERNAME}
USER ${CUSTOM_USERNAME}

# RUN sudo usermod -aG docker ${CUSTOM_USERNAME}
RUN sudo usermod -aG dialout ${CUSTOM_USERNAME}

WORKDIR ${DIR}

RUN sudo apt update && sudo apt install -y python3-catkin-tools xauth

RUN sudo apt-get update && sudo apt-get install -y \
    tmux \
    libx11-xcb1 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-shape0 \
    libxcb-shm0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxkbcommon-x11-0 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    mesa-utils \
    && sudo rm -rf /var/lib/apt/lists/*

CMD ["bash"]