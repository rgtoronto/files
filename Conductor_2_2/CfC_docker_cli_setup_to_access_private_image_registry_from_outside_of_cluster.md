##### Ubuntu
    1. add following line in /etc/hosts
    2. Create /etc/systemd/system/docker.service.d/daemon.conf
        [Service]
        Type=notify
        ExecStart=
        ExecStart=/usr/bin/docker daemon -H fd:// --insecure-registry="master.cfc:8500"
    3. systemctl daemon-reload
    4. service docker restart