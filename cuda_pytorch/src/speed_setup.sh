#!/bin/bash

# 生成 SSH 密钥
mkdir -p /home/user/.ssh
cp -r /data/cls1-srv2-pool/.ssh/* /home/user/.ssh/
chmod 700 /home/user/.ssh
chmod 600 /home/user/.ssh/id_rsa
chmod 644 /home/user/.ssh/id_rsa.pub
