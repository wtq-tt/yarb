#!/bin/bash

# 解决 CentOS 无 apt-get 问题：用 yum 安装系统依赖（wget）
if [ -f /etc/redhat-release ]; then
    # 红帽系（CentOS/RHEL）系统
    sudo yum update -y
    sudo yum install -y wget gcc python3-devel openssl-devel libffi-devel  # 补充编译依赖
else
    # 兼容 Debian/Ubuntu（可选保留）
    sudo apt-get update
    sudo apt-get install -y wget gcc python3-dev
fi

# 升级 pip 和依赖工具（解决 Python 3.6 兼容性+安装失败问题）
python3 -m pip install --upgrade pip setuptools wheel -i https://pypi.tuna.tsinghua.edu.cn/simple

# 安装 Python 依赖（用国内源加速，避免超时）
python3 -m pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple --ignore-installed pexpect

# 创建 go-cqhttp 目录（避免目录不存在报错）
mkdir -p ./cqhttp

# 下载并解压 go-cqhttp（指定路径，避免权限问题）
wget -q https://github.com/Mrs4s/go-cqhttp/releases/download/v1.0.0-rc2/go-cqhttp_linux_amd64.tar.gz -O ./cqhttp/go-cqhttp.tar.gz

# 解压 go-cqhttp（仅解压二进制文件，删除压缩包）
cd ./cqhttp || exit 1  # 若目录切换失败则退出
tar xzf go-cqhttp.tar.gz go-cqhttp --overwrite  # --overwrite 覆盖已存在文件
rm -f go-cqhttp.tar.gz

# 赋予 go-cqhttp 执行权限
chmod +x go-cqhttp

# 提示安装完成
echo "===== 安装完成！====="
echo "1. 请先配置 config.json（订阅源、推送机器人等）"
echo "2. 若使用 QQ 推送，请进入 cqhttp 目录运行 ./go-cqhttp 完成机器人登录配置"
echo "3. 测试推送：python3 yarb.py --test"