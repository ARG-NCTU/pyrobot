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
    tzdata

##################################### setting #####################################
RUN chown -R ${USER}:${USER} ${HOME}/
RUN echo "sis ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

USER ${USER}

WORKDIR ${HOME}

############################# LoCoBot and PyRobot ############################
RUN curl 'https://raw.githubusercontent.com/facebookresearch/pyrobot/master/robots/LoCoBot/install/locobot_install_all.sh' > locobot_install_all.sh && chmod +x locobot_install_all.sh

RUN chmod +x locobot_install_all.sh

RUN ./locobot_install_all.sh -t full -p 3 -l interbotix

RUN rm locobot_install_all.sh

RUN pip install gtsam

############################# Habitat install ##################################
RUN git clone --branch stable https://github.com/facebookresearch/habitat-sim.git
RUN sudo apt-get install -y --no-install-recommends python3-pip ## me
RUN pip3 install --upgrade pip setuptools ## me

RUN /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
    cd ${HOME}/habitat-sim/ && pip3 install -r requirements.txt"

RUN sudo apt-get install -y libjpeg-dev \
    libglm-dev \
    libgl1-mesa-glx \
    libegl1-mesa-dev \
    mesa-utils \
    xorg-dev \
    freeglut3-dev \
    libssl-dev

RUN /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
    cd ${HOME}/habitat-sim/ && sudo python3 setup.py build_ext --parallel 3 install"

RUN /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
    sudo apt install python3-netifaces && sudo pip3 install netifaces"

RUN mv ${HOME}/pyrobot_catkin_ws/src/* ${HOME}/low_cost_ws/src && \
    rm -rf ${HOME}/pyrobot_catkin_ws && rm -r ${HOME}/low_cost_ws/devel ${HOME}/low_cost_ws/build

# Lab
RUN git clone --branch stable https://github.com/facebookresearch/habitat-lab.git  

# test data
RUN /bin/bash -c "cd ${HOME}/habitat-lab && \
    wget http://dl.fbaipublicfiles.com/habitat/habitat-test-scenes.zip && \
    unzip habitat-test-scenes.zip && rm habitat-test-scenes.zip"    

# Lab 
RUN /bin/bash -c "cd ${HOME}/habitat-lab/ && pip3 install -r requirements.txt"

RUN /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
    sudo pip3 install Cython \
                      dataclasses\
                      lmdb==0.98 \
                      tb-nightly \
                      webdataset==0.1.40\
                      opencv-python"

RUN /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \    
    pip3 uninstall gym -y && pip3 install gym==0.17.3"

RUN /bin/bash -c "cd ${HOME}/habitat-lab && \
    sudo python3 setup.py develop --all"

ENV NVIDIA_DRIVER_CAPABILITIES compute,utility,display

LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/lib/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

