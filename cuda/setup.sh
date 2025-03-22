#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export MINICONDA_VERSION=latest
export MINICONDA_PATH=/opt/miniconda
export USERNAME=user
export USER_UID=1000

sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

apt update
apt upgrade -y
apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh htop nvtop
apt install -y --no-install-recommends python3.10 python3.10-dev python3.10-venv python3.10-distutils python3-pip
rm -rf /var/lib/apt/lists/*

userdel -rf ubuntu || true
useradd -m ${USERNAME} --uid=${USER_UID}
usermod -aG sudo ${USERNAME}
echo 'user:password' | chpasswd
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/${USERNAME}

chsh -s /bin/zsh ${USERNAME}

sudo -u ${USERNAME} -i /bin/bash <<EOF
git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh
git clone https://gitee.com/albpeed/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
EOF
