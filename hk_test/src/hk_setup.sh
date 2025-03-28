#!/bin/bash

sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sudo sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

sudo apt update
sudo apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh htop nvtop iputils-ping locales gnupg2 lsb-release build-essential
sudo apt install -y --no-install-recommends python3.10 python3.10-dev python3.10-venv python3.10-distutils python3-pip
sudo rm -rf /var/lib/apt/lists/*

sudo chsh -s /bin/zsh $USER

git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh
git clone https://gitee.com/albpeed/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 生成 SSH 密钥
mkdir -p $HOME/.ssh
ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa" -N '' -q
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/id_rsa
chmod 644 $HOME/.ssh/id_rsa.pub

git config --global user.name "hk"
git config --global user.email "hk@robot.com"

sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
sudo apt install -y --no-install-recommends ros-noetic-desktop-full ros-noetic-rqt*
sudo apt install -y --no-install-recommends python3-rosinstall python3-rosinstall-generator python3-wstool python3-roslaunch


cat > "$HOME/.zshrc" <<EOF
# omz:
export ZSH="\$HOME/.oh-my-zsh"
export ZSH_COMPDUMP=\$ZSH/cache/.zcompdump-\$HOST
ZSH_THEME="ys"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
zstyle ':omz:update' mode auto
source \$ZSH/oh-my-zsh.sh

export HISTFILE="\$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
setopt EXTENDED_HISTORY

setopt no_nomatch

source /opt/ros/noetic/setup.zsh

EOF
