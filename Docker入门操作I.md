<p align="center">
  <a href="#">
    <img height="200" src="https://simpleicons.org/icons/docker.svg?sanitize=true">
  </a>
</p>

# What is Docker？
Docker是程序员在容器中开发、部署、运行应用的平台，这种使用容器来部署应用的方式可以成为容器化，可以发布到任意的Linux机器上。

# Why Docker？
- 隔离性好：沙箱机制，彼此间无接口，一个容器就是一个独立的环境，不与其他应用争夺系统资源，对系统资源的利用率高。
- 快：与虚拟机技术不同，直接运行在宿主机内核上，不需要像虚拟机技术那样启动完整的操作系统，也因此占用磁盘空间少，节约系统资源，可秒级启动，内存消耗、磁盘读写速度都比虚拟机技术快。
- 省事：完整的开发、运行、测试环境由镜像提供，不会出现环境不一致出现的莫名bug；轻松移植，Docker可以在很多平台上运行，对运维讲，只需要Copy & Run就可以了，不需要担心运行环境的变化导致应用无法运行问题；基于镜像的扩展和你建议，应用维护更轻松。
- 节省成本，一台主机上可以运行很多数量的应用。

# How to work with Docker?

## 1. 官方安装指南
[Windows版本](https://docs.docker.com/docker-for-windows/install/)
[Ubuntu版本](https://docs.docker.com/install/linux/docker-ee/ubuntu/)

## 2. 一些基本概念
- Docker Image：极度精简的Linux程序运行环境
- Docker Registry/Hub：官方Registry生态圈上有大量已经容器化好的应用镜像资源，即拉即用
- Dockerfile：镜像配置，自定义配置镜像内容，包含软件依赖等
- Docker Container：容器，是Image的实例，是一个封闭的沙箱，有生命周期

## 3. 常用命令
```bash
$ docker --help
管理命令:
  builder     管理builds
  config      管理Docker配置
  container   管理容器
  image       管理镜像
  network     管理网络
  plugin      管理插件
  service     管理服务
  volume      管理volumes

Commands:
  build       通过Dockerfile中的配置构建镜像
  commit      根据容器的修改创建新的镜像
  cp          本地文件系统及镜像之间的文件复制
  create      创建新的容器
  exec        在正在运行中的容器中执行命令
  export      将容器的文件系统导出打包
  history     展示镜像历史
  images      列出所有镜像等同于命令：docker image list
  kill        停止一个或多个正在运行的容器
  load        导出用save命令打包导出的镜像
  login       登陆到Docker registry
  logout      登出Docker registry
  logs        获取容器的日志
  pause       暂停一个或多个容器中的所有进程
  port        列出容器的端口映射
  ps          列出所有容器
  pull        从镜像库拉取镜像
  push        推送镜像或仓库到registry
  rename      重命名容器
  restart     重启一个或多个容器
  rm          移除一个或多个容器
  rmi         移除一个或多个镜像
  run         在新容器中执行命令
  save        将一个或多个镜像导出
  search      在Docker Hub中搜索镜像
  start       启动一个或多个镜像
  stats       Display a live stream of container(s) resource usage statistics
  stop        停止一个或多个正在运行的镜像
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         列出容器中正在运行的进程
  unpause     启动一个或多个容器中的所有进程
  update      更新一个或多个容器的配置
  version     获取Docker版本信息
  wait        阻塞等待一个或多个容器停止，并输出退出码
```

## 4. 一个简单的示例
> 拉镜像->配参数->运行容器->跑项目->停止容器

1. 拉取镜像
```bash
$ docker pull java:latest
$ docker image list
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
java                       latest              d23bdf5b1b1b        2 years ago         643MB
```

2. 配置文件映射、工作目录等参数并运行容器
```bash
--workdir=/ws #设置容器内的工作空间
--volume=/test:/ws #本地文件映射到工作空间--volume=本地路径:容器路径，注意：如果路径有空格，加上双引号->--volume="/test project":/ws
-i #-i则让容器的标准输入保持打开
-t #-t让docker分配一个伪终端并绑定到容器的标准输入上
#最后指定要用到的镜像
$ docker run --workdir=/ws --volume=/test:/ws -it java:latest
root@201b7fb2c23c:/ws# 直接进入容器的工作空间，可以自由发挥了

```

3. 停止容器
```bash
# 列出正在运行的容器
# 输出结果会包含容器ID、名称（运行时可以指定名称，否则docker会自动生成名称）、镜像等
$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES                
659805d16ae3        java:latest         "/bin/bash"         About a minute ago   Up About a minute                       zen_ramanujan      

# 1. 可在容器中直接 exit 退出
root@201b7fb2c23c:/ws# exit

# 2. 也可用docker命令
$ docker stop container [docker name]
```

## 其他补充
以上是一个简单的示例，该示例中还可以用到的docker相关的命令有：
1. 进入到一个正在执行的容器的终端: docker exec -it [CONTAINER ID] bash
2. 删除已经是终止状态的容器：docker rm [CONTAINER ID]
3. 删除正在运行的容器：docker rm -f [CONTAINER ID]
4. 删除所有停止的容器：docker container prune

## docker中运行docker
场景：公司给我配的电脑是ThinkPad（真不香），组里的项目是默认在类Unix系统下运行，我的电脑跑不起该项目。在踩过一些慢速大坑后，决定在docker内运行，当然docker内跑项目的效率比虚拟机高多了，但本项目中部分模块要用到docker，那么如何解决呢？
- docker内运行docker，即将宿主机的Docker共享给容器，运行时需要添加的参数如下
```bash
--privileged # 给该容器赋予root权限，只有root用户才能执行docker命令
-v /var/run/docker.sock:/var/run/docker.sock # socket文件映射
-v $(which docker):/bin/docker # docker可执行文件映射
```
为什么会用到docker.sock文件？
sock文件是Unix域套接字文件，docker在运行时启动的docker守护进程默认监听这个套接字，docker引擎用到的HTTP接口均可以通过这个套接字文件调用，做映射后，容器就可以监听套接字文件，也因此权限更加高，可以控制docker的守护进程，调用docker命令。
