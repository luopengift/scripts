#!/bin/bash

PREFIX=/opt/cfssl
mkdir -p $PREFIX
curl -s -o $PREFIX/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
curl -s -o $PREFIX/cfssljson  https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x /opt/cfssl/*

cat >/etc/profile.d/cfssl.sh << EOF
#!/bin/bash
export CFSSL_PATH=$PREFIX
export PATH=\$CFSSL_PATH:\$PATH
EOF
