#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export USERNAME=user
export USER_UID=1000

sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

apt update
apt upgrade -y
apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh htop nvtop zsh-syntax-highlighting
apt install -y --no-install-recommends python3.10 python3.10-dev python3.10-venv python3.10-distutils python3-pip
rm -rf /var/lib/apt/lists/*

userdel -rf ubuntu || true
useradd -m ${USERNAME} --uid=${USER_UID}
usermod -aG sudo ${USERNAME}

echo "${USERNAME}:password" | chpasswd
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
chsh -s /bin/zsh ${USERNAME}

sudo -u ${USERNAME} -i /bin/bash <<EOF
sh -c "$(curl -fsSL https://install.ohmyz.sh)" "" --unattended
git clone https://gitee.com/albpeed/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
EOF


