### Step 1: Generate a Private Key
    root@dcos-09:/docker-registry# openssl genrsa -des3 -out server.key 1024
    Generating RSA private key, 1024 bit long modulus
    ....................................++++++
    .........................++++++
    e is 65537 (0x10001)
    Enter pass phrase for server.key:
    Verifying - Enter pass phrase for server.key:

### Step 2: Generate a CSR (Certificate Signing Request)
    root@dcos-09:/docker-registry# openssl req -new -key server.key -out server.csr
    Enter pass phrase for server.key:
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
    Organization Name (eg, company) [Internet Widgits Pty Ltd]:IBM
    Organizational Unit Name (eg, section) []:Spectrum
    Common Name (e.g. server FQDN or YOUR name) []:172.29.2.69
    Email Address []:guo@ca.ibm.com
    
    Please enter the following 'extra' attributes
    to be sent with your certificate request

### Step 3: Remove Passphrase from Key
    cp server.key server.key.org
    openssl rsa -in server.key.org -out server.key
    
    -rw-r--r--  1 root root       753 Jul 20 11:57 server.csr
    -rw-r--r--  1 root root       891 Jul 20 12:02 server.key
    -rw-r--r--  1 root root       963 Jul 20 12:01 server.key.org

### Step 4: Generating a Self-Signed Certificate
    root@dcos-09:/docker-registry# openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
    Signature ok
    subject=/C=CA/ST=Ontario/L=Toronto/O=IBM/OU=Spectrum/CN=172.29.2.69/emailAddress=guo@ca.ibm.com
    Getting Private key

### Step 5: Installing the Private Key and Certificate
    cp server.crt /usr/local/apache/conf/ssl.crt
    cp server.key /usr/local/apache/conf/ssl.key

### Step 6: Configuring SSL Enabled Virtual Hosts
    sudo vim /etc/apache2/sites-available/default-ssl.conf
        SSLEngine on
        SSLCertificateFile /usr/local/apache/conf/ssl.crt/server.crt
        SSLCertificateKeyFile /usr/local/apache/conf/ssl.key/server.key
        SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown
        CustomLog logs/ssl_request_log "%t %h %{SSL_PROTOCOL}x %{SSL_CIPHER}x \"%r\" %b"
        
### Step 7: Restart Apache and Test
    Ubuntu 14.04
    /etc/init.d/httpd stop     
    /etc/init.d/httpd stop
    
    or Uruntu 16.04
    systemctl restart apache2
    
    https://172.29.2.69