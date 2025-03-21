#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export USERNAME=speed
export USER_UID=1000

sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

apt update
apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh htop nvtop
apt install -y --no-install-recommends python3.10 python3.10-dev python3.10-venv python3.10-distutils python3-pip
rm -rf /var/lib/apt/lists/*

useradd -m -s /usr/bin/zsh ${USERNAME}
echo '${USERNAME} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

userdel -rf ubuntu || true
useradd -m ${USERNAME} --uid=${USER_UID}
usermod -aG sudo ${USERNAME}

echo "${USERNAME}:password" | chpasswd
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
chsh -s /bin/zsh ${USERNAME}

# 切换到 speed 用户并进入其主目录
sudo -u ${USERNAME} -i bash <<EOF
cd /home/${USERNAME}

mkdir -p ~/.config/pip
echo "[global]" > ~/.config/pip/pip.conf
echo "index-url = https://pypi.mirrors.ustc.edu.cn/simple/" >> ~/.config/pip/pip.conf

# 下载 Oh My Zsh
git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 安装和配置 zsh 插件
git clone https://gitee.com/albpeed/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 修改 zsh 配置
sed -i 's/plugins=(git)/plugins=(git extract zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="ys"/' ~/.zshrc
echo 'source \$ZSH/oh-my-zsh.sh' >> ~/.zshrc
echo 'source \$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'source \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

# sed -i 's/%m/speed-cls-docker/g' ~/.oh-my-zsh/themes/ys.zsh-theme
EOF

