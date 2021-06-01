#!/bin/bash
HOME=/home/sis 
cd ${HOME}
git clone --branch stable https://github.com/facebookresearch/habitat-sim.git

source ${HOME}/pyenv_pyrobot_python3/bin/activate 

cd ${HOME}/habitat-sim

pip install -r requirements.txt

sudo apt-get update && sudo apt-get install -y libjpeg-dev libglm-dev libgl1-mesa-glx libegl1-mesa-dev mesa-utils xorg-dev freeglut3-dev

python setup.py install

deactivate
# # Lab
# git clone --branch stable https://github.com/facebookresearch/habitat-lab.git  

# # test data
# cd ${HOME}/habitat-lab
# wget http://dl.fbaipublicfiles.com/habitat/habitat-test-scenes.zip && \
# unzip habitat-test-scenes.zip && rm habitat-test-scenes.zip"    

# # Lab 
# /bin/bash -c "cd ${HOME}/habitat-lab/ && pip3 install -r requirements.txt"

# /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
# sudo pip3 install Cython \
#                     dataclasses \
#                     lmdb==0.98 \
#                     tb-nightly==2.6.0a20210531 \
#                     webdataset==0.1.40 \
#                     opencv-python"

# /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \    
# pip3 uninstall gym -y && pip3 install gym==0.17.3"

# /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
# cd ${HOME}/habitat-lab && \
# sudo python3 setup.py develop --all"

# /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
# pip3 list |grep habitat"

# catkin_make
# ENV ORBSLAM2_LIBRARY_PATH=/home/${USER}/low_cost_ws/src/pyrobot/robots/LoCoBot/locobot_navigation/orb_slam2_ros

# /bin/bash -c "source ${HOME}/pyenv_pyrobot_python3/bin/activate && \
# cd ${HOME}/low_cost_ws/ && \
# source /opt/ros/melodic/setup.bash && \
# catkin_make --cmake-args -DPYTHON_EXECUTABLE=$(which python) -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so"

# echo "source ${HOME}/catkin_ws/devel/setup.bash" >> ~/.bashrc
