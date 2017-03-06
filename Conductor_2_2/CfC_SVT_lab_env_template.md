### CfC SVT lab env setup on X86
#### 1. Hardware and software
##### 1.1 OS
    Red Hat Enterprise Linux 7.2
##### 1.2 Hardware
    300 2-vCPU VMs

#### 2. Setting up passwordless SSH among master and worker nodes
    Before installing the IBM Spectrum Conductor for Containers you must generate SSH key pairs on your machines and set up passwordless SSH.
    Note:Root user must be used to generate SSH keys and set up passwordless SSH.
    
##### Generating SSH Keys
    On your boot node, perform the following steps:
    1.Create a directory to store the keys.
        mkdir -p keys_dir
    2.Generate the keys.
        ssh-keygen -t rsa -f keys_dir/ssh_key -P ''
        
##### Setting up passwordless SSH
    To set up passwordless SSH, you must copy the generated ssh key to all masterand worker nodes.
    From your boot node, perform the following steps:
        ssh-copy-id -i keys_dir/ssh_key root@master_nodes_ip
        ssh-copy-id -i keys_dir/ssh_key root@worker_nodes_ip
        Where master_nodes_ip and worker_nodes_ip is the IP address of a master or workernode in the cluster.
        
#### 3. All cluster nodes are able to access each other using hostname/FQDN
    Ensure that all master, worker, and proxy nodes are able to access each other using their host name or fully qualified domain name (FQDN). 
    Host names must be in all lowercase letters.
    
#### 4. Ensure that clocks are synchronized across all nodes in the cluster

#### 5. master.cfc is a built-in domain for the IBM Spectrum Conductor for Containers cluster. Ensure that this domain is not being used by any of nodes

#### 6. On master nodes, ensure that the vm.max_map_countsetting is at least 262144.T
    set this minimum vm.max_map_countvalue, run: sysctl -w vm.max_map_count=262144
    
#### 7. Docker installation on each node in cluster
    the latest version of docker
    see https://docs.docker.com/engine/installation/.
    
#### 8. install docker-py
    On master, worker, and proxy nodes, install docker-py.
    For Ubuntu:
    #apt install python-setuptools
    #easy_install pip
    #pip install 'docker-py>=1.7.0'
    For RHEL:
    #yum install python-setuptools
    #easy_install pip
    #pip install 'docker-py>=1.7.0' 
    
#### 9. Default ports should be open and avaiable
    https://ibm.ent.box.com/v/containerDocs#%5B%7B%22num%22%3A273%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2Cnull%2Cnull%2Cnull%5D
    
#### 10. On all nodes, ensure that Docker engine is started.
    systemctl start docker