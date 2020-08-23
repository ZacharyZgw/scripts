#!/bin/bash
#define the env 
export LANG="en_US.UTF-8"

printMsg(){
  echo  "$(date +'%Y-%m-%d %H:%M:%S')-----------$1-----------"
}
if [ $# -lt 7 ]; then
  printMsg "脚本参数错误，例如:./start.sh 8080 8080 container_name image_name host_dir container_dir"
  exit 1
fi

#container name
container_name=$3
#host port eg:127.0.0.1:8080 or 8080
host_port=$1
#container port
container_port=$2
#image name
image_name=$4
#host file dir
host_filedir=$5
#container file dir
container_filedir=$6
#run mode,eg:predict or train
run_mode=$7


#查找指定容器是否已运行，是则停掉容器
printMsg "check old container"
docker ps |grep ${container_name} | awk '{print $6}' | xargs docker stop
printMsg "create container"

docker run -it -d -p ${host_port}:${container_port} --name ${container_name} -v ${host_filedir}:${container_filedir} ${image_name} /bin/bash
docker start ${container_name}

printMsg "以后台运行方式运行镜像${image_name},创建容器${container_name}"
printMsg "本地主机的${host_port}端口映射到容器的${container_port}端口"
printMsg "本地主机的${host_filedir}目录挂载到容器的${container_filedir}目录"

printMsg "进入容器执行命令"
docker exec -it ${container_name} /bin/bash .${container_filedir}/${run_mode}.sh





