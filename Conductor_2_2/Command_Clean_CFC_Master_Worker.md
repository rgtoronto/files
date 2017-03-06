    docker stop master-kubelet
    docker rm -f $(docker ps -a -q)
    rm -rf /etc/kubernetes /etc/cfc /var/lib/{cosmos,etcd,kubelet,mesos,mysql,registry}
    docker rmi -f $(docker images -q)
    
    
    docker stop worker-mesos
    docker rm -f $(docker ps -a -q)
    umount /var/lib/mesos/slaves/*/frameworks/*/executors/*/runs/*/pods/*/volumes/*/*
    rm -rf /etc/{flannel,cfc} /var/lib/mesos /etc/systemd/system/docker.service.d/*.conf /var/lib/docker/network/*
    systemctl daemon-reload
    service docker stop
    ip link del docker0
    service docker start
    docker rmi -f $(docker images -q)