##### installer output message on 20160809 build

    root@ma1demo1:/# docker run -v "$(pwd)/cluster":/installer/cluster ma1demo2.eng.platformlab.ibm.com/installer:latest
    
    PLAY [deploy master node] ******************************************************
    
    TASK [setup] *******************************************************************
    ok: [9.21.58.21]
    
    TASK [common : get cluster etcd url] *******************************************
    ok: [9.21.58.21]
    
    TASK [common : get mesos master url] *******************************************
    ok: [9.21.58.21]
    
    TASK [common : set is_systemd_configured variable] *****************************
    skipping: [9.21.58.21]
    
    TASK [common : check if docker.socket file is exist] ***************************
    ok: [9.21.58.21]
    
    TASK [common : set is_docker_socket_exist variable] ****************************
    skipping: [9.21.58.21]
    
    TASK [common : enable docker service] ******************************************
    ok: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/conf directory is exist] *************
    ok: [9.21.58.21]
    
    TASK [master : ensure mesos-cloud.conf file is exist] **************************
    ok: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/scripts directory is exist] **********
    ok: [9.21.58.21]
    
    TASK [master : ensure setup_flannel_network.sh file is exist] ******************
    ok: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/conf directory is exist] *************
    ok: [9.21.58.21]
    
    TASK [master : ensure keystone auth secret key is exist] ***********************
    ok: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/pods directory is exist] *************
    ok: [9.21.58.21]
    
    TASK [master : ensure keystone-auth PodSpec file is exist] *********************
    ok: [9.21.58.21]
    
    TASK [master : pull and start Kubelet container on master node] ****************
    changed: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/pods directory is exist] *************
    ok: [9.21.58.21]
    
    TASK [master : ensure etcd PodSpec file is exist] ******************************
    ok: [9.21.58.21]
    
    TASK [master : wait for etcd to be started] ************************************
    ok: [9.21.58.21]
    
    TASK [master : ensure flannel PodSpec file is exist] ***************************
    changed: [9.21.58.21]
    
    TASK [master : ensure kube-apiserver PodSpec file is exist] ********************
    changed: [9.21.58.21]
    
    TASK [master : wait for kube-apiserver to be started] **************************
    ok: [9.21.58.21]
    
    TASK [master : ensure kube-controller-manager PodSpec file is exist] ***********
    changed: [9.21.58.21]
    
    TASK [master : ensure kube-scheduler PodSpec file is exist] ********************
    changed: [9.21.58.21]
    
    TASK [master : ensure mesos-master PodSpec file is exist] **********************
    changed: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/pods directory is exist] *************
    ok: [9.21.58.21]
    
    TASK [master : ensure router PodSpec file is exist] ****************************
    changed: [9.21.58.21]
    
    TASK [master : ensure the /etc/kubernetes/pods directory is exist] *************
    ok: [9.21.58.21]
    
    TASK [master : ensure appstore PodSpec file is exist] **************************
    changed: [9.21.58.21]
    
    PLAY [deploy worker node] ******************************************************
    
    TASK [setup] *******************************************************************
    ok: [9.21.58.24]
    ok: [9.21.58.23]
    
    TASK [common : get cluster etcd url] *******************************************
    ok: [9.21.58.23]
    ok: [9.21.58.24]
    
    TASK [common : get mesos master url] *******************************************
    ok: [9.21.58.23]
    ok: [9.21.58.24]
    
    TASK [common : set is_systemd_configured variable] *****************************
    skipping: [9.21.58.23]
    skipping: [9.21.58.24]
    
    TASK [common : check if docker.socket file is exist] ***************************
    ok: [9.21.58.24]
    ok: [9.21.58.23]
    
    TASK [common : set is_docker_socket_exist variable] ****************************
    skipping: [9.21.58.23]
    skipping: [9.21.58.24]
    
    TASK [common : enable docker service] ******************************************
    ok: [9.21.58.24]
    ok: [9.21.58.23]
    
    TASK [worker : pull and start Flannel container on worker node] ****************
    changed: [9.21.58.24]
    changed: [9.21.58.23]
    
    TASK [worker : wait for flannel container to be started] ***********************
    ok: [9.21.58.23]
    ok: [9.21.58.24]
    
    TASK [worker : fetch the remote flannel env file] ******************************
    changed: [9.21.58.23]
    changed: [9.21.58.24]
    
    TASK [worker : get flannel subnet] *********************************************
    ok: [9.21.58.23]
    ok: [9.21.58.24]
    
    TASK [worker : get flannel mtu] ************************************************
    ok: [9.21.58.23]
    ok: [9.21.58.24]
    
    TASK [worker : ensure the /etc/systemd/system/docker.service.d directory is exist] ***
    ok: [9.21.58.23]
    ok: [9.21.58.24]
    
    TASK [worker : create /etc/systemd/system/docker.service.d/flannel.conf for docker.socket OS] ***
    changed: [9.21.58.24]
    changed: [9.21.58.23]
    
    TASK [worker : create /etc/systemd/system/docker.service.d/flannel.conf for none docker.socket OS] ***
    skipping: [9.21.58.23]
    skipping: [9.21.58.24]
    
    TASK [worker : configure /etc/default/docker to use flannel network] ***********
    skipping: [9.21.58.23]
    skipping: [9.21.58.24]
    
    RUNNING HANDLER [worker : reload systemd daemon] *******************************
    changed: [9.21.58.24]
    changed: [9.21.58.23]
    
    RUNNING HANDLER [worker : stop docker service] *********************************
    changed: [9.21.58.23]
    changed: [9.21.58.24]
    
    RUNNING HANDLER [worker : remove docker0 bridge] *******************************
    changed: [9.21.58.24]
    changed: [9.21.58.23]
    
    RUNNING HANDLER [worker : start docker service] ********************************
    changed: [9.21.58.23]
    changed: [9.21.58.24]
    
    TASK [worker : set /etc/machine-id on non-systemd system] **********************
    skipping: [9.21.58.23]
    skipping: [9.21.58.24]
    
    TASK [worker : pull and start mesos-agent container on worker node] ************
    changed: [9.21.58.23]
    changed: [9.21.58.24]
    
    PLAY RECAP *********************************************************************
    9.21.58.21                 : ok=27   changed=8    unreachable=0    failed=0
    9.21.58.23                 : ok=17   changed=8    unreachable=0    failed=0
    9.21.58.24                 : ok=17   changed=8    unreachable=0    failed=0
    
    
    POST DEPLOY MESSAGE ************************************************************
    
    UI URL is http://9.21.58.21 , default username/password is admin/admin