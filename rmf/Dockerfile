# 使用 NVIDIA 运行时的 Ubuntu 24.04 作为基础镜像
FROM m.daocloud.io/docker.io/nvidia/cuda:12.6.0-runtime-ubuntu24.04

# 设置环境变量，避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更换 apt 源为阿里云源
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources

RUN rm /etc/apt/sources.list.d/cuda*.list

# 更新 apt 并安装 git 和 zsh
RUN apt update && \
    apt install -y --no-install-recommends build-essential vim git zsh wget curl sudo x11-apps tmux curl && \
    apt install -y --no-install-recommends autossh htop nvtop iputils-ping && \
    apt install -y --no-install-recommends lsb-release gnupg mesa-utils tzdata python3-pip && \
    apt clean
RUN rm -rf /var/lib/apt/lists/*

# ros2
RUN sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://mirrors.ustc.edu.cn/ros2/ubuntu noble main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN curl -sSL https://ghfast.top/https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | gpg --dearmor -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN apt update && \
    apt install -y --no-install-recommends ros-jazzy-desktop && \
    apt install -y --no-install-recommends ros-jazzy-rmf-dev ros-jazzy-ros-gz-bridge && \
    apt install -y --no-install-recommends ros-dev-tools && \
    apt clean

# # ign gazebo fortress
RUN curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
RUN apt update && \
    apt install -y --no-install-recommends gz-harmonic

# 创建 speed 用户并赋予 sudo 权限
RUN useradd -m -s /usr/bin/zsh speed && \
    echo 'speed ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY src /home/speed
RUN chown -R speed:speed /home/speed

# 确保 zsh 配置文件存在，并修改 PS1
USER speed
WORKDIR /home/speed

RUN git config --global user.name "speed-ubuntu2404-docker" && \
    git config --global user.email "speed@docker.com"

# 下载 Oh My Zsh
RUN git clone https://gitee.com/albpeed/ohmyzsh ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 安装 zsh 插件
RUN git clone https://gitee.com/albpeed/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://gitee.com/albpeed/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 配置 zsh 插件
# 配置 zshrc
RUN sed -i 's/plugins=(git)/plugins=(git extract zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc && \
    sed -i 's/ZSH_THEME=".*"/ZSH_THEME="ys"/' ~/.zshrc && \
    echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc && \
    echo 'source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc && \
    echo 'source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

# 修改 ys 主题，替换 %m 为 speed-zsh-docker
RUN sed -i 's/%m/speed-ros2/g' ~/.oh-my-zsh/themes/ys.zsh-theme

# 设置容器启动时默认执行的命令
CMD ["zsh"]

