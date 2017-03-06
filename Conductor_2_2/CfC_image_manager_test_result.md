### Environment setup
    1 master, 2 slaves
    admin role user: admin, admin1
    regular user: user1, user2
    projects: project1, project2, admin
### Test scripts
#### admin
##### JWT Token
    export CMD='curl -s -u admin:admin "http://localhost:8600/image-manager/api/v1/auth/token?service=token-service&scope=registry:catalog:*"'
    export IM_TOKEN=$(eval $CMD | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    echo $IM_TOKEN
    export CMD='curl -s -H "Authorization: Bearer $IM_TOKEN" "http://localhost:8500/v2/_catalog"'
    eval ${CMD} -i
##### Push image
    docker tag hello-world localhost:8500/admin/hello-world:v1
    docker tag hello-world localhost:8500/project1/hello-world:v1
    docker tag hello-world localhost:8500/project-non/hello-world:v1
    docker push localhost:8500/admin/hello-world:v1
    docker push localhost:8500/project1/hello-world:v1
    docker push localhost:8500/project-non/hello-world:v1
    
##### Pull image
    docker pull localhost:8500/admin/hello-world:v1
    docker pull localhost:8500/project1/hello-world:v1
    docker pull localhost:8500/project-non/hello-world:v1

###### Precondition for List, scope, delete
    export CMD='curl -s -XPOST -d "{ \"uid\": \"admin\", \"password\": \"admin\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" http://dcos-04.ma.platformlab.ibm.com:8101/acs/api/v1/auth/login'
    export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    echo ${KS_TOKEN}
    echo **The KS_TOKEN created above will be used in the next curl commands**

##### List images
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories"'
    eval ${CMD} | python -mjson.tool
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/project-a/ubuntu"'
    eval ${CMD} | python -mjson.tool

##### Modify scope
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/users1/alpine"'
    eval ${CMD} | python -mjson.tool
    
    export CMD='curl -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}"  -H "Content-Type: application/json" "http://localhost:8600/image-manager/api/v1/metadata/users1/alpine"'
    eval ${CMD}
    
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/users1/alpine"'
    eval ${CMD} | python -mjson.tool


##### Remove images
    export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/project-a/ubuntu"'
    eval ${CMD}

#### user1
##### JWT Token
    export CMD='curl -s -u user1:user1 "http://localhost:8600/image-manager/api/v1/auth/token?service=token-service&scope=registry:catalog:*"'
    export IM_TOKEN=$(eval $CMD | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    echo $IM_TOKEN
    export CMD='curl -s -H "Authorization: Bearer $IM_TOKEN" "http://localhost:8500/v2/_catalog"'
    eval ${CMD} -i
    
##### Push image
    docker tag hello-world localhost:8500/admin/hello-world:v1
    docker tag hello-world localhost:8500/project1/hello-world:v1
    docker tag hello-world localhost:8500/project-non/hello-world:v1
    docker push localhost:8500/admin/hello-world:v1
    docker push localhost:8500/project1/hello-world:v1
    docker push localhost:8500/project-non/hello-world:v1
    
##### Pull image
    docker pull localhost:8500/admin/hello-world:v1
    docker pull localhost:8500/project1/hello-world:v1
    docker pull localhost:8500/project-non/hello-world:v1
    
##### List images
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories"'
    eval ${CMD} | python -mjson.tool
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/project-a/ubuntu"'
    eval ${CMD} | python -mjson.tool
##### Modify scope
    export CMD='curl -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}"  -H "Content-Type: application/json" "http://localhost:8600/image-manager/api/v1/metadata/users1/alpine"'
    eval ${CMD}
    export CMD='curl -s -H "Authorization: Bearer ${KS_TOKEN}" "http://localhost:8600/image-manager/api/v1/repositories/users1/alpine"'
    eval ${CMD} | python -mjson.tool
##### Remove images
    export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/project-a/ubuntu"'
    eval ${CMD}
    
#### admin role user
##### JWT Token
    export CMD='curl -s -u admin:admin "http://localhost:8600/image-manager/api/v1/auth/token?service=token-service&scope=registry:catalog:*"'
    export IM_TOKEN=$(eval $CMD | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    echo $IM_TOKEN
    export CMD='curl -s -H "Authorization: Bearer $IM_TOKEN" "http://localhost:8500/v2/_catalog"'
    eval ${CMD} -i
##### Push image
    docker tag hello-world localhost:8500/admin/hello-world:v1
    docker tag hello-world localhost:8500/project1/hello-world:v1
    docker tag hello-world localhost:8500/project-non/hello-world:v1
    docker push localhost:8500/admin/hello-world:v1
    docker push localhost:8500/project1/hello-world:v1
    docker push localhost:8500/project-non/hello-world:v1
    
##### Pull image
    docker pull localhost:8500/admin/hello-world:v1
    docker pull localhost:8500/project1/hello-world:v1
    docker pull localhost:8500/project-non/hello-world:v1
    
##### List images
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories"'
    eval ${CMD} | python -mjson.tool
    export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/project-a/ubuntu"'
    eval ${CMD} | python -mjson.tool
##### Modify scope
    export CMD='curl -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}"  -H "Content-Type: application/json" "http://localhost:8600/image-manager/api/v1/metadata/users1/alpine"'
    eval ${CMD}
    export CMD='curl -s -H "Authorization: Bearer ${KS_TOKEN}" "http://localhost:8600/image-manager/api/v1/repositories/users1/alpine"'
    eval ${CMD} | python -mjson.tool
##### Remove images
    export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://localhost:8600/image-manager/api/v1/repositories/project-a/ubuntu"'
    eval ${CMD}