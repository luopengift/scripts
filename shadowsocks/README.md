### shadowsocks 安装
1. 安装python（略）
2. 安装shadowsocks
```
pip install shadowsocks
```
3. 配置shadowsocks
```
#/etc/shadowsocks.json
{
 "server":"0.0.0.0",
 "local_address": "127.0.0.1",
 "local_port":1080,
  "port_password": {
     "8888": "123456",
     "18000": "123456",
     "18001": "123456",
     "18002": "123456",
     "18003": "123456"
 },
 "timeout":600,
 "method":"aes-256-cfb",
 "fast_open": false
}
```
4. 启动服务
```
ssserver -c /etc/shadowsocks.json --workers 1 --log-file /var/log/shadowsocks.log -d start
```
5. 客户端下载(可选)

[MacOS](http://p07mgr0ww.bkt.clouddn.com/ShadowsocksX-2.6.3.dmg):http://p07mgr0ww.bkt.clouddn.com/ShadowsocksX-2.6.3.dmg
[android](https://github.com/shadowsocks/shadowsocks-android/releases):http://p07mgr0ww.bkt.clouddn.com/shadowsocks-arm64-v8a-4.5.6.apk
[ios]

6. 配置开机启动(可选，基于Centos7)
```
#/usr/lib/systemd/system/shadowsocks.service
[Unit]
Description=shadowsocks

[Service]
Type=forking
PIDFile=/run/shadowsocks.pid
ExecStart=/bin/ssserver -c /etc/shadowsocks.json --workers 1 --log-file /var/log/shadowsocks.log -d start
ExecReload=/bin/ssserver -d restart
ExecStop=/bin/ssserver -d stop
[Install]
WantedBy=multi-user.target
```
