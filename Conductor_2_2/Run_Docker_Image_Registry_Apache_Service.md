Start Your Apache service before doing this.

### Step 1: Create a certs directory:
    mkdir -p certs
    
### Steps 2: create a password file with one entry for the user “testuser”, with password “testpassword”:
    mkdir auth
    docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > auth/htpasswd

### Step 3: Start registry container
    docker run -d -p 5000:5000 --restart=always --name registry \
      -v `pwd`/auth:/auth \
      -e "REGISTRY_AUTH=htpasswd" \
      -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
      -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
      -v `pwd`/certs:/certs \
      -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
      -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
      registry:2
      
    docker login myregistrydomain.com:5000
    docker tag image1 myregistrydomain.com:5000/image1
    docker push myregistrydomain.com:5000/image1