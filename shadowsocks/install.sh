#!/bin/bash

pip install shadowsocks
cp shadowsocks.json /etc/shadowsocks.json
cp shadowsocks.service /usr/lib/systemd/system/shadowsocks.service
systemctl daemon-reload
systemctl enable shadowsocks
systemctl start shadowsocks
