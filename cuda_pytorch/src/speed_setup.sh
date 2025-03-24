#!/bin/bash

# 确保切换到 user 用户
cd /home/user

# 创建 speed 目录和 Python 虚拟环境
mkdir -p /home/user/speed
mkdir -p /home/user/Downloads
cd /home/user/speed
python3 -m venv rl_venv
source rl_venv/bin/activate
mkdir -p /home/user/speed/rl_venv/ws

# 安装 PyTorch 和其他依赖
pip install --upgrade pip
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu124
pip install pip==22.3.1
pip install tensorboard gym==0.19.0 colorama==0.4.6 numpy==1.26.4 pandas==2.2.3 setuptools
pip install --upgrade pip

# 生成 SSH 密钥
mkdir -p ~/.ssh
cp -r /data/cls1-srv2-pool/.ssh/* ~/.ssh/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
