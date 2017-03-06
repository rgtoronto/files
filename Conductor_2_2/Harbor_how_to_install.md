## Setup Portus Server
    apt install ruby
    gem install bundler
    apt-get install docker.io docker-compose
    git clone https://github.com/SUSE/Portus.git
    cd Portus/
    ./compose-setup.sh -e 172.29.2.69
    
## Setup client
    vi /etc/default/docker

    DOCKER_OPTS="--insecure-registry 10.4.19.4:5000"
    service docker restart