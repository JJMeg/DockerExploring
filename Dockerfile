## Dockerfile中每一条指令都会建立一层，包括RUN行为，新建一层，执行名命令，执行完毕，commit这一层的修改，构成新镜像

From ubuntu ## 基础镜像，在这个镜像基础上做定制，FROM scratch表示不以任何镜像为基础

RUN apt-get update && apt-get install -y libssl1.0.0 libssl-dev // 执行命令，可写成多条
## RUN apt-get update
## RUN apt-get install -y libssl1.0.0 libssl-dev

FROM golang:1.12.9

COPY mongodb-linux-x86_64-3.6.13/bin/mongod /usr/local/bin/
RUN mkdir -p /data/db

ENV PATH="/usr/bin/gcc:${PATH}"

WORKDIR /ws

CMD mongod --fork --logpath /var/log/mongodb.log && go test -mod=vendor ./...


## 镜像是多层存储，每一层的东西在下一层不会被删除，在每层添加需要的清理无关的，避免臃肿的镜像

## 构建： "docker build -t [targetname: tag] -f [dockerfilePath] ." 
## eg：docker build -t golang12:mongod -f .\gowithmongo .
## 若未指定-f 文件默认去寻找当前目录下的Dockerfile
