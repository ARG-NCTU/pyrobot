#!/bin/bash
HOME=/home/sis
cd ${HOME}

source ${HOME}/pyenv_pyrobot_python3/bin/activate

############### install habitat sim ##################
git clone --branch v0.1.5 https://github.com/facebookresearch/habitat-sim.git

cd ${HOME}/habitat-sim

pip install -r requirements.txt

sudo apt-get update && sudo apt-get install -y libjpeg-dev libglm-dev libgl1-mesa-glx libegl1-mesa-dev mesa-utils xorg-dev freeglut3-dev

python setup.py install

############### install habitat lab ##################
cd ${HOME}

git clone --branch v0.1.5 https://github.com/facebookresearch/habitat-lab.git

cd ${HOME}/habitat-lab

pip install -r requirements.txt

python setup.py develop --all

wget http://dl.fbaipublicfiles.com/habitat/habitat-test-scenes.zip

unzip habitat-test-scenes.zip && rm habitat-test-scenes.zip

############### deactivate virtual env ##################

cd ${HOME}

deactivate
