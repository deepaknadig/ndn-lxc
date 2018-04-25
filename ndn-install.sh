#!/bin/bash

HOME=/home/ubuntu
NFD=/home/ubuntu/NFD
NDNCXX=/home/ubuntu/ndn-cxx
NDNTOOLS=/home/ubuntu/ndn-tools
NDNTRAFFICGEN=/home/ubuntu/ndn-traffic-generator
NDNNLSR=/home/ubuntu/ChronoSync
TMUX=/home/ubuntu/.tmux

sudo apt install -y software-properties-common
sudo apt install -y git-core nano build-essential
sudo apt install -y build-essential libsqlite3-dev libboost-all-dev libssl-dev pkg-config openssh-server lxc uml-utilities libboost-all-dev libsqlite3-dev libssl-dev libpcap-dev
sudo apt install -y lxc-common tcpdump screen tmux

cd $HOME
if [ ! -d "$TMUX" ]; then
    git clone https://github.com/gpakosz/.tmux.git
fi
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .


# Download ndn-cxx
if [ ! -d "$NDNCXX" ]; then
    git clone https://github.com/named-data/ndn-cxx
fi

# Download NFD
if [ ! -d "$NFD" ]; then
    git clone --recursive https://github.com/named-data/NFD
fi

# Download NDN Tools
if [ ! -d "$NDNTOOLS" ]; then
    git clone https://github.com/named-data/ndn-tools.git
fi

# Download NDN Traffic Generator
if [ ! -d "$NDNTRAFFICGEN" ]; then
    git clone https://github.com/named-data/ndn-traffic-generator.git
fi

# Download NDN NLSR using ChronoSync
if [ ! -d "$NDNNLSR" ]; then
    git clone https://github.com/named-data/ChronoSync.git
fi


sudo apt install -y doxygen graphviz python-sphinx python-pip
sudo pip install sphinxcontrib-doxylink sphinxcontrib-googleanalytics

printf "\n#############################################\n"
printf "INSTALLING NDN-CXX LIBRARIES\n"
printf "#############################################\n"

cd $NDNCXX
./waf configure --with-examples
./waf
sudo ./waf install
sudo ldconfig

printf "\n#############################################\n"
printf "NDN-CXX INSTALLATION COMPLETE.\n"
printf "#############################################\n"


printf "\n#############################################\n"
printf "INSTALLING NFD...\n"
printf "#############################################\n"

cd $NFD

./waf configure
./waf
sudo ./waf install

printf "\n#############################################\n"
printf "NFD INSTALLATION COMPLETE.\n"
printf "#############################################\n"


printf "\n#############################################\n"
printf "INSTALLING NDN TOOLS...\n"
printf "#############################################\n"

cd $NDNTOOLS

./waf configure
./waf
sudo ./waf install

printf "\n#############################################\n"
printf "NDN TOOLS INSTALLATION COMPLETE.\n"
printf "#############################################\n"


printf "\n#############################################\n"
printf "INSTALLING TRAFFIC GENERATOR...\n"
printf "#############################################\n"

cd $NDNTRAFFICGEN

./waf configure
./waf
sudo ./waf install

printf "\n#############################################\n"
printf "TRAFFIC GENERATOR INSTALLATION COMPLETE.\n"
printf "#############################################\n"


printf "\n#############################################\n"
printf "INSTALLING NLSR...\n"
printf "#############################################\n"

cd $NDNNLSR

./waf configure
./waf
sudo ./waf install

printf "\n#############################################\n"
printf "NLSR INSTALLATION COMPLETE.\n"
printf "#############################################\n"


sudo apt clean && sudo apt autoclean && sudo apt -y autoremove

printf "\n#############################################\n"
printf "CLEANUP COMPLETE.\n"
printf "#############################################\n"
