https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-14-04

root@dcos-09:~/docker-registry/nginx# openssl req -x509 -new -nodes -key devdockerCA.key -days 10000 -out devdockerCA.crt
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:CA
State or Province Name (full name) [Some-State]:Ontario
Locality Name (eg, city) []:Toronto
Organization Name (eg, company) [Internet Widgits Pty Ltd]:NOName
Organizational Unit Name (eg, section) []:No
Common Name (e.g. server FQDN or YOUR name) []:No
Email Address []:no
