#!/usr/bin/env bash

echo "\ 
 ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
||h |||e |||l |||l |||o |||       |||t |||h |||e |||r |||e ||
||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
"

### install curl ###

echo "... CURL_INSTALL=$CURL_INSTALL ..."
if [ "$CURL_INSTALL" = 'yes' ]; then
  sudo apt-get install curl -y
else
    echo '... skipped installing curl ...'
fi

### Install pip ###

echo "... INSTALL_PIP=$INSTALL_PIP ..."
if [ "$INSTALL_PIP" = 'yes' ]; then
  echo '... installing pip ...'
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python get-pip.py
else
  echo '... skipped installing pip ...'
fi

### Install Python 3 with Miniconda ###

echo "... MINICONDA_INSTALL=$MINICONDA_INSTALL ..."
if [ "$MINICONDA_INSTALL" = 'yes' ]; then
  echo '... installing miniconda ...'
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
  bash Miniconda3-latest-Linux-x86_64.sh -b
  rm -rf Miniconda3-latest-Linux-x86_64.sh
  export PATH=/home/vagrant/miniconda3/bin:$PATH
  echo '# Miniconda Python' >> .bashrc
  echo "export PATH=/home/vagrant/miniconda3/bin:$PATH" >> .bashrc
else
  echo '... miniconda block skipped ...'
fi

### Install pip packages ###

echo "... INSTALL_PIP_PACKAGES=$INSTALL_PIP_PACKAGES ..."
if [ "$INSTALL_PIP_PACKAGES" = 'yes' ]; then
  echo '... installing packages with pip ...'
  pip install awscli jupyter
else
  echo '... skipped pip packages ...'
fi

### create conda env ###

echo "... CONDA_ENV_REBUILD=$CONDA_ENV_REBUILD ..."
if [ "$CONDA_ENV_REBUILD" = 'yes' ]; then
  echo '... rebuild conda env ...'
  conda env create -f environment.yml
else
  echo '... skipped conda env rebuild ...'
fi

### launch jupyter ###

echo "... LAUNCH_JUPYTER=$LAUNCH_JUPYTER ..."
if [ "$LAUNCH_JUPYTER" = 'yes' ]; then
  echo '... launching jupyter lab in background ...'
  jupyter lab --no-browser --ip 0.0.0.0 &
else
  echo '... skipped launching jupyter ...'
fi
