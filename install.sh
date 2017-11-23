#!/bin/bash
#set -x
PWD=$(pwd)
SYSTEM=$(uname -a)
echo "查看系统版本:$SYSTEM"
##--##
GCC_VERSION='7.2.0'
PYTHON_VERSION='3.6.3'

read -p '选择操作系统型号[window|linux|darwin]:' SYSTEM
case "$SYSTEM"  in
    window)
    	echo '暂时不支持window系统!' && exit -1 ;;
    linux)
	GOLANG='go1.9.2.linux-amd64.tar.gz'
	;;
    darwin)
    	GOLANG='go1.9.darwin-amd64.tar.gz'
        ;;
    *)
        echo '选择失败' && exit -1 ;;
esac


RUNTIME_PATH='/opt'
mkdir -p RUNTIME_PATH

#GCC
read -p '是否安装gcc环境[y/N]:' IS_GCC
if [ $IS_GCC = 'Y' ] || [ $IS_GCC = 'y' ]
then
    cd $PWD
    echo '开始安装gcc...'
    GCC_PATH=$RUNTIME_PATH/gcc-$GCC_VERSION
    tar -xf $GCC && cd gcc-$GCC_VERSION
    ./contrib/download_prerequisites
    mkdir build && cd build/
    ../configure --prefix=$GCC_PATH --enable-checking=release --enable-languages=c,c++ --disable-multilib
    make && make install
    GCC_PROFILE='/etc/profile.d/gcc.sh'
    echo "export GCC_PATH=$GCC_PATH" >> $GCC_PROFILE
    echo 'export PATH=$GCC_PATH/bin:$PATH' >> $GCC_PROFILE
    source /etc/profile
    echo "gcc安装成功,版本:$(gcc -v)"
fi

#GOLANG
read -p '是否安装Golang环境[y/N]:' IS_GOLANG
if [ $IS_GOLANG = 'Y' ] || [ $IS_GOLANG = 'y' ]
then
    cd $PWD
    echo '开始安装Golang...'
    GOROOT="$RUNTIME_PATH/go"
    tar -xf $GOLANG -C $RUNTIME_PATH
    GOLANG_PROFILE='/etc/profile.d/golang.sh'
    echo "export GOROOT=$GOROOT" >> $GOLANG_PROFILE
    echo "export GOPATH=" >> $GOLANG_PROFILE
    echo 'export PATH=$GOROOT/bin:$PATH' >> $GOLANG_PROFILE
    source /etc/profile
    echo "Golang安装成功,版本:$(go version)"
fi

read -p "是否安装Python环境[y/N]:" IS_PYTHON
if [ $IS_PYTHON = "Y" ] || [ $IS_PYTHON = "y" ]
then
    cd $PWD
    echo '开始安装Python...'
    PYTHON_PATH="$RUNTIME_PATH/Python-$PYTHON_VERSION"
    tar -xf Python-$PYTHON_VERSION.tar.xz && cd Python-$PYTHON_VERSION
    ./configure --prefix=$PYTHON_PATH --enable-optimizations
    make && make install
    PYTHON_PROFILE='/etc/profile.d/python.sh'
    echo "export PYTHON_PATH=$PYTHON_PATH" >> $PYTHON_PROFILE
    echo 'export PATH=$PYTHON_PATH/bin:$PATH' >> $PYTHON_PROFILE
    ln -s $PYTHON_PATH/bin/python3 $PYTHON_PATH/bin/python
    ln -s $PYTHON_PATH/bin/pip3 $PYTHON_PATH/bin/pip
    source /etc/profile
    echo "Python安装成功,版本:$(which python)"

fi

read -p "是否安装xgboost[y/N]:" IS_XGBOOST
if [ $IS_XGBOOST = "Y" ] || [ $IS_XGBOOST = "y" ]
then
    cd $PWD
    git clone --recursive https://github.com/dmlc/xgboost
    cd xgboost/
    git submodule init && git submodule update
    make
    ./build.sh
    cd python-package/
    python setup.py install
fi

read -p "是否安装Java[y/N]:" IS_JAVA
if [ $IS_JAVA = "Y" ] || [ $IS_JAVA = "y" ]
then
fi
function DOWNLOAD() {
    cd $PWD
    wget https://studygolang.com/dl/golang/$GOLANG
    wget http://ftp.gnu.org/gnu/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.xz
    wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz
}




#安装JAVA
