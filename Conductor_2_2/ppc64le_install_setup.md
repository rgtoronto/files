##### To install docker on pwoer machine:
    Docker on RedHat Power LE
    We can get the latest rpm package for docker version 1.11.2 from 
        http://ftp.unicamp.br/pub/ppc64el/rhel/7_1/docker-ppc64el/. 
        we first install: 
            docker-selinux-1.11.2-0.ael7b.noarch.rpm
        then 
            docker-1.11.2-0.ael7b.ppc64le.rpm

        rpm -i  command install docker. E.g
        rpm -i docker-io-1.6.2-20150204gitf9978e8.ael7b.ppc64le.rpm
##### How to reguster with redhat account or a license.

    If packages are on distro disk, you can use:
    
    yum list 
    yum install [package_name]
    
    Otherwise you should use Satellite repository.
    
    Register through proxy on the 172.29.0.0/16 networks:
    wget -qO- --no-check-certificate https://rhn.linux.ibm.com/pub/bootstrap/bootstrap.sh | /bin/bash
    run rhn_register first!!!
    rhn_register    
    wait for it to finish, exit and register later
    vi /etc/sysconfig/rhn/u2date
          enableProxy=1
          enableProxyAuth=0
          httpProxy=proxy-ma.platformlab.ibm.com:3128
    now run rhn_register again:
    rhn_register