    docker run -v "$(pwd)/cluster":/installer/cluster --entrypoint=ansible-playbook ma1demo2.eng.platformlab.ibm.com/installer:latest -e @cluster/config.yaml data.yaml

#### Error Message 1
    TASK [setup] *******************************************************************
    fatal: [172.29.2.68]: FAILED! => {"changed": false, "cmd": "/usr/local/bin/ohai", "failed": true, "msg": "[Errno 2] No such file or directory", "rc": 2} 

##### Slove the issue:
    gem uninstall ohai
    
#### Error Message 2
    TASK [master : pull and start Kubelet container on master node] ****************
    fatal: [172.29.2.68]: FAILED! => {"changed": false, "failed": true, "module_stderr": "", "module_stdout": "Traceback (most recent call last):\r\n  File \"/tm    from ansible.module_utils.docker_common import *\r\n  File \"/tmp/ansible_0GfFeO/ansible_modlib.zip/ansible/module_utils/docker_common.py\", line 32, in \", line 53, in <module>\r\n    from .packages.urllib3.contrib import pyopenssl\r\n  File \"/usr/local/lib/python2.7/dist-packages/requests/packages/urllib3/SSL.SSLv3_METHOD,\r\nAttributeError: 'module' object has no attribute 'PROTOCOL_SSLv3'\r\n", "msg": "MODULE FAILURE", "parsed": false}

##### Solve the issue:
    easy_install --upgrade pip
    pip uninstall pyopenssl
    pip install mozdownload