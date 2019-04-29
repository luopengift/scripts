#!/bin/bash

#ln -s $GOPATH/src/github.com/golang $GOPATH/src/golang.org/x

PKG=$2
if [ "$PKG" == "" ]; then
  echo "Usage: ./get-pkg.sh [install|update] ctypto"
  exit -1
fi

case $1 in
    "install")
        set -x
        git -C $GOPATH/src/github.com/golang/ clone https://github.com/golang/$PKG.git
        #go get github.com/golang/$PKG
        ln -s $GOPATH/src/github.com/golang/$PKG $GOPATH/src/golang.org/x/$PKG
        ;;
    "update")
        set -x
        go get -u $GOPATH/src/github.com/golang/$PKG
        ;;
    *)
        echo "Usage: ./get-pkg.sh [install|update] ctypto"
        ;;
esac
#git -C $GOPATH/src/github.com/googleapis/ clone https://github.com/googleapis/google-cloud-go.git
#ln -s $GOPATH/github.com/googleapis/google-cloud-go/ $GOPATH/src/cloud.google.com/go
