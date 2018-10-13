#!/bin/bash
PKG=$1
if [ "$PKG" == "" ]; then
  echo "Usage: ./get-pkg.sh ctypto"
  exit -1
fi

set -x
#git -C $GOPATH/src/github.com/golang/ clone https://github.com/golang/$PKG.git
go get github.com/golang/$PKG
ln -s $GOPATH/src/github.com/golang/$PKG $GOPATH/src/golang.org/x/$PKG
