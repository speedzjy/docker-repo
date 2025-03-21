#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export USERNAME=speed
export USER_UID=1000

# 更换 apt 源为阿里云源
sed -i 's@//.*archive.ubuntu.com@//mirrors.aliyun.com@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

apt update
apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh 


useradd -m -s /usr/bin/zsh ${USERNAME}
echo '${USERNAME} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

userdel -rf ubuntu || true
useradd -m ${USERNAME} --uid=${USER_UID}
usermod -aG sudo ${USERNAME}

echo "${USERNAME}:password" | chpasswd
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME}
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
chsh -s /bin/zsh ${USERNAME}

# 下载 Oh My Zsh
git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 安装和配置 zsh 插件
git clone https://gitee.com/albpeed/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's/plugins=(git)/plugins=(git extract zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="ys"/' ~/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

# 修改 ys 主题，替换 %m 为 speed-zsh-docker
# sed -i 's/%m/speed-cls-docker/g' ~/.oh-my-zsh/themes/ys.zsh-theme

