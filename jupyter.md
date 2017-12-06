## 修改jupyter,实现远程调用

1. 确定jupyter的安装路径
```
find / -name notebook
```
2. 修改notebook/notenookapp.py文件, /tmp/notebookapp.py为修改后的文件
```
diff notebook/notebookapp.py /tmp/notebookapp.py
576c576,577
<             return 'localhost'
---
>             return "0.0.0.0"
>             #return 'localhost'
1486c1487,1488
<                 '    %s' % url_concat(self.connection_url, {'token': self.token}),
---
>                 #'    %s' % url_concat(self.connection_url, {'token': self.token}),
>                 '    %s' % url_concat("http://"+socket.gethostbyname(socket.gethostname())+":"+str(self.port), {'token': self.token}),
```

3. 修改成功，启动服务
```
[root@localhost ~]# jupyter notebook --allow-root
[I 11:52:01.497 NotebookApp] Serving notebooks from local directory: /usr/lib/python2.7/site-packages
[I 11:52:01.498 NotebookApp] 0 active kernels
[I 11:52:01.498 NotebookApp] The Jupyter Notebook is running at:
[I 11:52:01.498 NotebookApp] http://0.0.0.0:8888/?token=6a35ad590a35a9353029484a3d361ed09395a7f5ed576342
[I 11:52:01.498 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 11:52:01.498 NotebookApp] No web browser found: could not locate runnable browser.
[C 11:52:01.498 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://10.100.50.216:8888?token=6a35ad590a35a9353029484a3d361ed09395a7f5ed576342

```
