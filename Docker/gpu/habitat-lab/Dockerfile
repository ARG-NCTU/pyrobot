FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO melodic

###################################### user #####################################
ENV SHELL=/bin/bash \
    USER=sis \
    UID=1000 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV HOME=/home/${USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    ${USER} 

RUN echo "root:root" | chpasswd
RUN echo "${USER}:111111" | chpasswd

RUN apt-get update && apt-get install -y \
    curl \
    lsb-release \
    sudo \
    software-properties-common  \
    tzdata \
    git \
    python-pip \
    python3-pip


############################# LoCoBot and PyRobot ############################
RUN curl 'https://raw.githubusercontent.com/facebookresearch/pyrobot/master/robots/LoCoBot/install/locobot_install_all.sh' > locobot_install_all.sh && chmod +x locobot_install_all.sh

RUN chmod +x locobot_install_all.sh

RUN ./locobot_install_all.sh -t sim_only -p 3 -l interbotix

RUN rm locobot_install_all.sh
RUN pip3 install -U pip setuptools
RUN pip3 install gtsam

############################# Habitat ##################################
COPY ./install_habitat.sh ${HOME}
RUN ${HOME}/install_habitat.sh
RUN rm ${HOME}/install_habitat.sh

##################################### setting ###################################################
RUN chown -R ${USER}:${USER} ${HOME}/
RUN echo "${USER} ALL=(ALL)  ALL" > /etc/sudoers

# Support of GPU
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

USER ${USER}

WORKDIR ${HOME}