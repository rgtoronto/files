### Step 1: Create the SSL Certificate
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
    sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
### Step 2: Configure Apache to Use SSL
#### Create an Apache Configuration Snippet with Strong Encryption Settings
    sudo nano /etc/apache2/conf-available/ssl-params.conf
    /etc/apache2/conf-available/ssl-params.conf
    # from https://cipherli.st/
    # and https://raymii.org/s/tutorials/Strong_SSL_Security_On_Apache2.html
    
    SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
    SSLProtocol All -SSLv2 -SSLv3
    SSLHonorCipherOrder On
    Header always set Strict-Transport-Security "max-age=63072000; includeSubdomains; preload"
    Header always set X-Frame-Options DENY
    Header always set X-Content-Type-Options nosniff
    # Requires Apache >= 2.4
    SSLCompression off 
    SSLSessionTickets Off
    SSLUseStapling on 
    SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
    
    SSLOpenSSLConfCmd DHParameters "/etc/ssl/certs/dhparam.pem"
    
#### Modify the Default Apache SSL Virtual Host File
    sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak
    sudo nano /etc/apache2/sites-available/default-ssl.conf
    /etc/apache2/sites-available/default-ssl.conf
    <IfModule mod_ssl.c>
            <VirtualHost _default_:443>
                    ServerAdmin your_email@example.com
                    ServerName server_domain_or_IP
    
                    DocumentRoot /var/www/html
    
                    ErrorLog ${APACHE_LOG_DIR}/error.log
                    CustomLog ${APACHE_LOG_DIR}/access.log combined
    
                    SSLEngine on
    
                    SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
    
                    <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                    SSLOptions +StdEnvVars
                    </FilesMatch>
                    <Directory /usr/lib/cgi-bin>
                                    SSLOptions +StdEnvVars
                    </Directory>
    
                    BrowserMatch "MSIE [2-6]" \
                                   nokeepalive ssl-unclean-shutdown \
                                   downgrade-1.0 force-response-1.0
    
            </VirtualHost>
    </IfModule>
#### (Recommended) Modify the Unencrypted Virtual Host File to Redirect to HTTPS
    sudo nano /etc/apache2/sites-available/000-default.conf
    add following line 
    
    Redirect "/" "https://your_domain_or_IP"
    
### Step 4: Enable the Changes in Apache
    sudo a2enmod ssl
    sudo a2enmod headers
    sudo a2ensite default-ssl
    sudo a2enconf ssl-params
    sudo apache2ctl configtest
    sudo systemctl restart apache2
### Step 5: Test Encryption
    https://server_domain_or_IP