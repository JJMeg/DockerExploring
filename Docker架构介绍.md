
### Docker概述
Docker是开发、部署、运行应用的开放平台，docker可把应用与基础架构分开，使得发布软件更加快捷。通过Docker可以用与管理应用同样的方式管理你的基础架构。充分利用Docker快速发布、测试、部署代码，极大减少从写代码到投入生产环境的时间。
### Docker平台
容器的良好隔离性和安全性可在一个主机上同时运行多个容器，可以直接在极其内核中运行，这比使用虚拟机还能运行更多的容器。当然也可以在宿主机上跑虚拟机容器。

### Docker引擎
Docker引擎是C-S架构的应用，包含以下组建：
- 守护进程：长时间运行的服务端进程
- REST API：定义了与守护进程通信和指挥守护进程的一系列接口
- 命令行接口CLI：docker的客户端进程，用户在命令行接口中通过脚本或者docker命令经过REST API交互和控制docker守护进程，守护进程创建和管理Docker对象，例如镜像、容器、网络和数据文件

### Docker架构
C/S架构
客户端与Docker守护进程通信，Docker守护进程做繁重的构建、运行和分发容器操作，客户端和Docker 守护进程可在同一个系统中，当然也可以客户端和远程Docker守护进程连接，客户端和守护进程之间的通信可通过RESTAPI、UNIX套接字或者网络接口完成。

1. Docker daemon：
监听Docker API请求，管理Docker对象，一个守护进程也可以与其他守护进程一起管理Docker服务

2. Docker 客户端：
用户与Docker交互的主要方式，比如Docker命令，可以同时与多个守护进程交互

3. Docker仓库：
存储公共的Docker镜像，当用户拉取镜像是，默认在Docker Hub上找，镜像库也可配置成私有仓库

4. Docker对象：
创建和使用的镜像、容器、网络、数据卷和插件等都为Docker对象

5. Docker镜像：
包含容器创建说明的只读模板，通常情况下一个镜像是基于另一镜像的，会带有一些额外的定制化配置。
可以选择别人创建好并发布到仓库的镜像，也可以创建自己的镜像，只需要创建一个语法简单的Dockerfile，Dockerfile中定义了创建、运行镜像的具体步骤，

6. 容器：
容器是图像的可运行实例。可使用Docker API或CLI创建，启动，停止，移动或删除容器。也可以将容器连接到一个或多个网络，将存储连接到它，甚至可以根据其当前状态创建新映像。默认情况下，容器与其他容器及宿主机相对隔离。您可以控制容器的网络，存储或与其他宿主机上的子系统及容器其间的隔离程度。容器由其镜像以及用户在创建或启动时为其提供的任何配置选项定义。删除容器后，为持久化的状态信息也随之消失。

### 运行一条指令发生了什么？
> $ docker run -it ubuntu /bin/bash
1. 检查镜像：若本地没有ubuntu镜像，Docker从镜像仓库中拉取，与手动`docker pull ubuntu`一样
2. 创建新容器，等同于手动`docker container create`
3. Docker将读写文件系统分配给容器，作为其最后一层。这允许正在运行的容器在其本地文件系统中创建或修改文件和目录。
4. 配置网络：Docker创建了一个网络接口，用于将容器连接到默认网络、为容器分配IP地址。默认情况下，容器使用主机的网络连接连接到外部网络。
5. 启动容器，并执行/bin/bash，由于容器以交互方式运行并连接到终端（-i、-t参数），因此可以使用键盘提供输入，同时将输出记录到终端。
6. 终止容器：输入exit，将终止/bin/bash命令，容器会停止但不会被删除，可以重新启动它或将其删除。

### Docker服务
服务允许用户跨多个Docker守护程序扩展容器，这些守护程序一起作为具有多个管理器和工作程序的群组一起工作。 swarm是一个Docker集群，swarm的每个成员都是Docker守护程序，守护进程间都使用Docker API进行通信。服务允许用户定制状态，例如在任何给定时间必须可用的服务的副本数。默认情况下，服务在所有工作节点之间进行负载平衡。对于消费者来说，Docker服务似乎是一个单独的应用程序。 Docker 1.12版本以上支持swarm模式。

### 底层技术
Docker是用Go编写的，它利用Linux内核的几个功能来提供其功能。

1. Namespace命名空间：
Docker使用称为Namespace的技术来提供称为容器的隔离工作空间。运行容器时，Docker会为该容器创建一组名称空间。这些Namespace提供了一层隔离，容器的每个方面都在一个单独的Namespace中运行，其访问权限仅限于该Namespace。

Docker Engine在Linux上使用以下Namespace：
pid Namespace：进程隔离（PID：进程ID）。
net Namespace：管理网络接口（NET：Networking）。
ipc Namespace：管理对IPC资源的访问（IPC：进程间通信）。
mnt Namespace：管理文件系统挂载点（MNT：Mount）。
uts Namespace：隔离内核和版本标识符。 （UTS：Unix分时系统）。

2. Control groups控制组：
Linux上的Docker Engine还依赖于cgroups技术。 cgroup将应用程序限制为特定的资源集，把进程放到一个组里面统一加以控制。控制组允许Docker Engine将可用的硬件资源共享给容器，并可选择强制执行限制和约束，例如可以限制特定容器的可用内存。

3. Union file systems：
UnionFS是通过创建层来操作的文件系统，使它们非常轻量和快速。 Docker Engine使用UnionFS为容器提供构建块。 Docker Engine可以使用多种UnionFS变量，包括AUFS，btrfs，vfs和DeviceMapper。

4. Container format：
Docker Engine将命名空间，控制组和UnionFS组合成一个称为容器格式的包装器。默认容器格式是libcontainer。将来，Docker可以通过与BSD Jails或Solaris Zones等技术集成来支持其他容器格式。
