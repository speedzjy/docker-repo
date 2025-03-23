#!/bin/bash

# 确保脚本以交互模式运行
set -e

# 检查是否提供了 IP 地址
if [ $# -ne 1 ]; then
    echo "用法: $0 <IPv4 地址>"
    exit 1
fi

IP_ADDRESS=$1
REMOTE_USER="speed"
REMOTE_PATH="Downloads/cplex_studio2211.linux_x86_64.bin"
LOCAL_PATH="~/Downloads/cplex_studio2211.linux_x86_64.bin"

echo "即将从 ${REMOTE_USER}@${IP_ADDRESS}:${REMOTE_PATH} 拷贝文件到${LOCAL_PATH}..."
# 执行 SCP 远程拷贝
scp "${REMOTE_USER}@${IP_ADDRESS}:${REMOTE_PATH}" "${LOCAL_PATH}"
if [ $? -ne 0 ]; then
    echo "SCP 失败，请检查网络或权限。"
    exit 1
fi

echo "文件已成功拷贝到 ${LOCAL_PATH}"

# 修改权限
chmod +x "${LOCAL_PATH}"
echo "权限修改完成: ${LOCAL_PATH} 现在可执行。"
# 执行文件
echo "即将执行 ${LOCAL_PATH} ..."
read -p "确认执行? (y/n): " execute_confirm
if [[ "$execute_confirm" != "y" ]]; then
    echo "执行取消。"
    exit 1
fi

"${LOCAL_PATH}"
