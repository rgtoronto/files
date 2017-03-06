# How to install Keystone on Ubuntu 16.04
## Pre-install:

##  Install Keystone
### [1]	Install Keystone. (disable auto-start)
    root@dcos-07:~# echo "manual" > /etc/init/keystone.override 
    root@dcos-07:~# aptitude -y install keystone python-openstackclient apache2 libapache2-mod-wsgi python-oauth2client
### [2]	Add a User and Database on MariaDB for Keystone
#### Install database to store data for Keystone
    apt-get install mysql-server python-mysqldb
#### Create user and database
    root@dcos-07:~# mysql -uroot -p
    Enter password:
    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MariaDB connection id is 32
    Server version: 10.0.24-MariaDB-7 Ubuntu 16.04
    Copyright (c) 2000, 2016, Oracle, MariaDB Corporation Ab and others.
    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
    MariaDB [(none)]> create database keystone;
    Query OK, 1 row affected (0.00 sec)
    MariaDB [(none)]> grant all privileges on keystone.* to keystone@'localhost' identified by 'password';
    Query OK, 0 rows affected (0.00 sec)
    MariaDB [(none)]> grant all privileges on keystone.* to keystone@'%' identified by 'password';
    Query OK, 0 rows affected (0.00 sec)
    MariaDB [(none)]> flush privileges;
    Query OK, 0 rows affected (0.00 sec)
    MariaDB [(none)]> exit
    Bye
### [3]	Configure Keystone
#### [3.1] Modify keystone.conf
    root@dcos-07:~# vi /etc/keystone/keystone.conf
    # line 13: uncomment and change to any Token
    admin_token = admintoken
    # line 551: change ( MariaDB connection info )
    connection = mysql+pymysql://keystone:password@10.0.0.30/keystone
    # line 1248: add Memcache server
    [memcache]
    servers = 10.0.0.30:11211
    # line 1986: add
    [token]
    provider = fernet
    # line 2012: uncomment
    driver = memcache
    root@dcos-07:~# su -s /bin/bash keystone -c "keystone-manage db_sync" 
    # initialize Fernet key
    root@dcos-07:~# keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone 
### [4]	Configure Apache httpd.
    root@dcos-07:~# vi /etc/apache2/apache2.conf
    # line 70: add own hostname
    ServerName 172.29.2.67
#### [4.1] Create wsgi-keystone.conf for Apache service
    root@dcos-07:~# vi /etc/apache2/sites-available/wsgi-keystone.conf
    # create new like follows
    Listen 443
    Listen 5000
    Listen 35357
    
    LoadModule ssl_module /usr/lib64/apache2-prefork/mod_ssl.so
    
    <VirtualHost *:443>
        WSGIScriptAlias / /var/www/cgi-bin/keystone/main
        ErrorLog /var/log/apache2/keystone.log
        LogLevel debug
        CustomLog /var/log/apache2/access.log combined
        SSLEngine on
        SSLCertificateFile   /etc/ssl/certs/ssl-cert-snakeoil.pem
        SSLCertificateKeyFile /etc/apache2/ssl/apache.key
        SSLCACertificatePath /etc/apache2/ssl
        SSLOptions +StdEnvVars
        SSLVerifyClient optional
    </VirtualHost>

    <VirtualHost *:5000>
        WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
        WSGIProcessGroup keystone-public
        WSGIScriptAlias / /usr/bin/keystone-wsgi-public
        WSGIApplicationGroup %{GLOBAL}
        WSGIPassAuthorization On
        <IfVersion >= 2.4>
          ErrorLogFormat "%{cu}t %M"
        </IfVersion>
        ErrorLog /var/log/apache2/keystone.log
        CustomLog /var/log/apache2/keystone_access.log combined
    
        <Directory /usr/bin>
            <IfVersion >= 2.4>
                Require all granted
            </IfVersion>
            <IfVersion < 2.4>
                Order allow,deny
                Allow from all
            </IfVersion>
        </Directory>
    </VirtualHost>
    
    <VirtualHost *:35357>
        WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
        WSGIProcessGroup keystone-admin
        WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
        WSGIApplicationGroup %{GLOBAL}
        WSGIPassAuthorization On
        <IfVersion >= 2.4>
          ErrorLogFormat "%{cu}t %M"
        </IfVersion>
        ErrorLog /var/log/apache2/keystone.log
        CustomLog /var/log/apache2/keystone_access.log combined
    
        <Directory /usr/bin>
            <IfVersion >= 2.4>
                Require all granted
            </IfVersion>
            <IfVersion < 2.4>
                Order allow,deny
                Allow from all
            </IfVersion>
        </Directory>
    </VirtualHost>

### root@dcos-07:~# a2ensite wsgi-keystone 
    Enabling site wsgi-keystone.
    To activate the new configuration, you need to run:
      service apache2 reload
    root@dcos-07:~# rm -f /var/lib/keystone/keystone.db 
    root@dcos-07:~# systemctl restart apache2

### Useful link:
    http://docs.openstack.org/developer/keystone/installing.html
    https://www.server-world.info/en/note?os=Ubuntu_16.04&p=openstack_mitaka&f=3
    
### Create a keystone user
    curl -s  -H "X-Auth-Token: $OS_TOKEN"  -H "Content-Type: application/json"  -d '{"user": {"name": "newuser", "password": "changeme", "domain_id": "777da59d975849ccbf37ea06245a25a5"}}'  http://172.29.2.67:5000/v3/users | python -mjson.tool

### Create s keystone domain
    curl -s -H "X-Auth-Token: $OS_TOKEN" -H "Content-Type: application/json" -d '{ "domain": { "name": "newdomain"}}'  http://172.29.2.67:5000/v3/domains | python -mjson.tool
    
### list domains
    curl -s -H "X-Auth-Token: $OS_TOKEN" http://localhost:5000/v3/domains | python -mjson.tool

## useful link
### keystone rest api    
    http://docs.openstack.org/developer/keystone/api_curl_examples.html
### how to setup tokenless keystone authorization
    http://docs.openstack.org/developer/keystone/configure_tokenless_x509.html