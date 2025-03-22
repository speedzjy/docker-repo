#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
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

# 切到user
exec su - ${USERNAME}
cd /home/user
# sudo -u ${USERNAME} -i /bin/bash <<EOF
git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh
git clone https://gitee.com/albpeed/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

mkdir -p /home/user/speed
cd /home/user/speed
python3 -m venv rl_venv
source rl_venv/bin/activate
mkdir -p /home/user/speed/rl_venv/ws

pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu124

ssh-keygen -t rsa -b 4096 -C "speed@docker.com" -f "$HOME/.ssh/id_rsa" -N "" -q
# EOF