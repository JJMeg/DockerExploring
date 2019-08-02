<p align="center">
  <a href="#">
    <img height="120" src="https://simpleicons.org/icons/docker.svg?sanitize=true">
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
  attach      Attach local standard input, output, and error streams to a running container
  build       通过Dockerfile中的配置构建镜像
  commit      根据容器的修改创建新的镜像
  cp          本地文件系统及镜像之间的文件复制
  create      创建新的容器
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        在正在运行中的容器中执行命令
  export      将容器的文件系统导出打包
  history     展示镜像历史
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       登陆到Docker registry
  logout      登出Docker registry
  logs        获取容器的日志
  pause       暂停一个或多个容器中的所有进程
  port        列出容器的端口映射
  ps          列出所有容器
  pull        从registry拉取镜像或仓库
  push        推送镜像或仓库到registry
  rename      重命名容器
  restart     重启一个或多个容器
  rm          移除一个或多个容器
  rmi         移除一个或多个镜像
  run         在新容器中执行命令
  save        将一个或多个镜像打包
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
