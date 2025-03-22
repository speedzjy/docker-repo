#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export USERNAME=user
export USER_UID=1000

sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

apt update
apt upgrade -y
apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh htop nvtop zsh-syntax-highlighting python3.10 python3.10-dev python3.10-venv python3.10-distutils python3-pip
rm -rf /var/lib/apt/lists/*

userdel -rf ubuntu || true
useradd -m ${USERNAME} --uid=${USER_UID}
usermod -aG sudo ${USERNAME}

echo "${USERNAME}:password" | chpasswd
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
chsh -s /bin/zsh ${USERNAME}

sudo -u ${USERNAME} -i /bin/bash <<EOF
git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
git clone https://gitee.com/albpeed/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
EOF

