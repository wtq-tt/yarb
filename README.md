# yarb 

基于 [yarb](https://github.com/Vu1nT0tal/yarb) 的修改版本，原版我在centos上跑不动！

# 本地搭建

环境配置

```sh
sudo yum update -y

# 开发工具
sudo yum groupinstall -y "Development Tools"

# Python 编译常用依赖
sudo yum install -y \
    gcc \
    make \
    openssl-devel \
    bzip2-devel \
    libffi-devel \
    zlib-devel \
    readline-devel \
    sqlite-devel \
    tk-devel \
    xz-devel \
    wget \
    curl

cd /usr/local/src
sudo wget https://www.python.org/ftp/python/3.9.19/Python-3.9.19.tgz
sudo tar xzf Python-3.9.19.tgz
cd Python-3.9.19


sudo ./configure \
  --prefix=/usr/local/python3.9 \
  --enable-optimizations \
  --with-ssl \
  --enable-shared \
  LDFLAGS="-Wl,-rpath=/usr/local/python3.9/lib"

sudo make -j$(nproc)
sudo make altinstall   # 使用 altinstall 避免覆盖系统别的 python 版本

sudo ln -sf /usr/local/python3.9/bin/python3.9 /usr/bin/python3
sudo ln -sf /usr/local/python3.9/bin/pip3.9   /usr/bin/pip3
```

# 运行

```
$ git clone https://github.com/wtq-tt/yarb.git
$ cd yarb && ./install.sh
#测试一下
$ python3 yarb.py 

#可以做定时任务每日9点执行
crontab -e
0 9 * * * python3 yarb.py 
```

