### Network
网络与操作系统无关，不需考虑操作系统处理网络和ip表的细节

几种网络模式
### birdge
- 默认模式，独立运行的容器内常用这种模式
- 多容器与同一个Docker守护进程沟通最适用

### host
- 指定host时将移除容器与宿主机之间的网络隔离，直接使用宿主机的网络
-

### overlay
- 连接多个docker守护进程，常用场景：独立运行的容器与集群服务、不同docker守护进程的多个容器间
- 最适合不同docker下的容器间交互

### macvlan
- 可为容器分配MAC地址

### none
- 需要自定义网卡，集群式服务不适用

### otherPlugins
