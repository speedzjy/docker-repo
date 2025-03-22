ARG CUDA_BASE=12.4.1-cudnn-devel-ubuntu22.04
FROM nvidia/cuda:${CUDA_BASE}

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 更新 apt 并安装 git 和 zsh
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends curl wget git sudo neovim tmux less ssh zsh htop nvtop zsh-syntax-highlighting && \
    apt install -y  python3.10 python3.10-dev python3.10-venv python3.10-distutils python3-pip && \
    apt clean
RUN rm -rf /var/lib/apt/lists/*

RUN useradd -m ${USERNAME} --uid=${USER_UID} \
    && usermod -aG sudo ${USERNAME} \
    && echo 'user:password' | chpasswd \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME} \
    && chown -R ${USERNAME}:${USERNAME} ${MINICONDA_PATH} \
    && chsh -s /bin/bash ${USERNAME} \
    && service ssh start

USER ${USERNAME}
WORKDIR /home/${USERNAME}
COPY src /home/${USERNAME}

RUN sudo chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} \
    && sudo cp -rT /home/${USERNAME} /etc/skel
