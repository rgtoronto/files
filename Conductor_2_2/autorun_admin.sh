    docker pull hello-world 
    now=$(date +"%m_%d_%Y") 
    filename=cfc-image-manager_admin_$now.txt 
    counter=0
      echo "Test result for CFC-Image-Manager admin">${filename}
        export CLUSTER_MASTER="master.cfc:8500"
        export IMAGE_MANAGER="master.cfc" 
    function write_to_result {
      echo $1>>${filename}
    }
        function jwt_token_test
        {
        	echo "---------------------------Token JWT Test------------------------------"
        	docker login -u admin -p admin ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagejwt
        	docker push ${CLUSTER_MASTER}/project1/imagejwt
        	export CMD='curl -s -k -u admin:admin "https://${IMAGE_MANAGER}/image-manager/api/v1/auth/token?service=token-service&scope=registry:catalog:*"'
        	export IM_TOKEN=$(eval $CMD | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        	echo $IM_TOKEN
                export CMD='curl -k -s -H "Authorization: Bearer $IM_TOKEN" "https://${CLUSTER_MASTER}/v2/_catalog"'
        	eval ${CMD} -i
        	( eval ${CMD} | python -mjson.tool|grep "project1/imagejwt" ) && write_to_result "JWT TOKEN Test: PASS" || write_to_result "JWT TOKEN Test: FAIL"
                export CMD='curl -s -k -XPOST -d "{ \"uid\": \"admin\", \"password\": \"admin\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    http://${IMAGE_MANAGER}:8101/acs/api/v1/auth/login'
                export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        	export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagejwt"'
                eval ${CMD}
    		counter=$((counter+1))
        }
        function list_test
        {
        	echo "----------------------------List Test Start-----------------------------"
    		docker login -u admin -p admin ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagelist
        	docker push ${CLUSTER_MASTER}/project1/imagelist
        	export CMD='curl -s -k -XPOST -d "{ \"uid\": \"admin\", \"password\": \"admin\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    http://${IMAGE_MANAGER}:8101/acs/api/v1/auth/login'
        	export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        	echo ${KS_TOKEN}
        	echo **The KS_TOKEN created above will be used in the next curl commands**
        	export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories"'
        	( eval ${CMD} | python -mjson.tool|grep 'project1/imagelist') && write_to_result "List Test : PASS" || write_to_result " List Test : FAIL"
                export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagelist"'
                eval ${CMD}
    			counter=$((counter+1))
    }
    function list_user1_test
        {
        	echo "----------------------------List User1 Test Start-----------------------------"
    		docker login -u user1 -p user1 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagelist
        	docker push ${CLUSTER_MASTER}/project1/imagelist
    		
    		docker login -u admin -p admin ${CLUSTER_MASTER}
        	export CMD='curl -s -k -XPOST -d "{ \"uid\": \"admin\", \"password\": \"admin\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    http://${IMAGE_MANAGER}:8101/acs/api/v1/auth/login'
        	export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        	echo ${KS_TOKEN}
        	echo **The KS_TOKEN created above will be used in the next curl commands**
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories"'
        	( eval ${CMD} | python -mjson.tool|grep 'project1/imagelist') && write_to_result "List User1 Test : PASS" || write_to_result " List User1 Test : FAIL"
                export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagelist"'
                eval ${CMD}
    			counter=$((counter+1))
    }
    function list_admin1_test
        {
        	echo "----------------------------List Admin1 Test Start-----------------------------"
    	docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagelist
        	docker push ${CLUSTER_MASTER}/project1/imagelist
    
    	docker login -u admin -p admin ${CLUSTER_MASTER}
        	export CMD='curl -s -k -XPOST -d "{ \"uid\": \"admin\", \"password\": \"admin\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    http://${IMAGE_MANAGER}:8101/acs/api/v1/auth/login'
        	export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        	echo ${KS_TOKEN}
        	echo **The KS_TOKEN created above will be used in the next curl commands**
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories"'
        	( eval ${CMD} | python -mjson.tool|grep 'project1/imagelist') && write_to_result "List Admin1 Test : PASS" || write_to_result " List Admin1 Test : FAIL"
                export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagelist"'
                eval ${CMD}
    			counter=$((counter+1))
    }
        function list_detail_test
        {
        	echo "---------------------------- List Detail Test Positive Start -----------------------------"
    		docker login -u admin -p admin ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagedetail:detailtest
    		docker push ${CLUSTER_MASTER}/project1/imagedetail:detailtest
    		
                    export CMD='curl -s -k -XPOST -d "{ \"uid\": \"admin\", \"password\": \"admin\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    http://dcos-04.ma.platformlab.ibm.com:8101/acs/api/v1/auth/login'
                            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
                                    echo ${KS_TOKEN}
        	export CMD='curl -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagedetail"'
        	(eval ${CMD} | python -mjson.tool|grep '"name": "detailtest"') && write_to_result "List Detail Test Positive: PASS" || write_to_result "List Detail Test Positive
    : FAIL"
    	        export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagedetail"'
                eval ${CMD}
    			counter=$((counter+1))
        
        }
        function modify_test
        {
        	echo "--------------------------- Modify Test Start -----------------------------"
        	docker login -u admin -p admin ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/admin/imagemodifytest
        	docker push ${CLUSTER_MASTER}/admin/imagemodifytest
        	export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            
            export CMD='curl -i -k -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/admin/imagemodifytest"'
        	eval ${CMD}
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagemodifytest"'
        	(eval ${CMD} | python -mjson.tool|grep "global") && write_to_result "Modify Test: PASS" ||write_to_result "Modify Test : FAIL"
    		export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagemodifytest"'
    		eval ${CMD
    		counter=$((counter+1))}
        
        }
        function modify_image_admin1_project_test
        {
        	echo "----------------------------Modify Image Admin1 Project Test Start -----------------------------"
    		docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/image3modifysameproject
        	docker push ${CLUSTER_MASTER}/project1/image3modifysameproject
    		docker login -u admin -p admin ${CLUSTER_MASTER}
            export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
        	export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project1/image3modifysameproject"'
        	eval ${CMD}
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/image3modifysameproject"'
        	(eval ${CMD} | python -mjson.tool|grep 'global') && write_to_result "Modify Image Admin1 Project Test: PASS" || write_to_result "Modify Image Admin1 Project Test : FAIL"
            export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/image3modifysamproject"'
            eval ${CMD}
    		counter=$((counter+1))
        }
        function modify_project_image_test
        {
        	echo "----------------------------Modify Project Image Test Start -----------------------------"
        	docker login -u user1 -p user1 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/adminimage
        	docker push ${CLUSTER_MASTER}/project1/adminimage
        	docker login -u admin -p admin ${CLUSTER_MASTER}
            export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
        	export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project1/adminimage"'
        	eval ${CMD}
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/adminimage"'
        	(eval ${CMD} | python -mjson.tool|grep 'global') && write_to_result "Modify Project Image Test : FAIL" || write_to_result "Modify Project Image Test : PASS"
                export CMD='curl -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/adminimage"'
                eval ${CMD}
    			counter=$((counter+1))
        }
        function remove_image_test
        {
            docker login -u admin -p admin ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/project1/image1
            docker push ${CLUSTER_MASTER}/project1/image1
    		export CFC_UID="admin"
    		export CFC_PASSWD="admin"
    		export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: 
    application/json"
    	https://master.cfc/acs/api/v1/auth/login'
    		export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    		echo ${KS_TOKEN}
        	echo "----------------------------Remove Image Test Start -----------------------------"
    		export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}" -H "Content-Type: application/json" 
    "http://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project1/image1"'
    		eval ${CMD}
        	export CMD='curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/image1"'
        	eval ${CMD}
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories"'
        	(eval ${CMD} | python -mjson.tool|grep 'project1/image1') && write_to_result "Remove Image Test: FAIL" || write_to_result "Remove Image Test : PASS"
    		counter=$((counter+1))
        }
        function remove_image_project_test
        {
        	echo "----------------------------Remove Image Project Test Start -----------------------------"
    		docker login -u user1 -p user1 ${CLUSTER_MASTER}
        	docker login -u user11 -p user11 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagesameproject
        	docker push ${CLUSTER_MASTER}/project1/imagesameproject
        	docker login -u admin -p admin ${CLUSTER_MASTER}
    		export CFC_UID="admin"
    		export CFC_PASSWD="admin"
    		export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: 
    application/json"
    	https://master.cfc/acs/api/v1/auth/login'
    		export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    		echo ${KS_TOKEN}
    		export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}" -H "Content-Type: application/json" 
    "http://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project1/imagesameproject"'
    		eval ${CMD}
        	export CMD='curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://$IMAGE_MANAGER/image-manager/api/v1/repositories/project1/imagesameproject"'
        	eval ${CMD}
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/"'
        	(eval ${CMD} | python -mjson.tool|grep 'project1/imagesameproject') && write_to_result "Remove Image Project Test: FAIL" || write_to_result "Remove Image Project Test : 
    PASS"
    		counter=$((counter+1))
        }
        
        function remove_image_admin1_project_test
        {
        	echo "----------------------------Remove Image2 Different Project Test Negative Start -----------------------------"
        	docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/admin1/imagediffproject
        	docker push ${CLUSTER_MASTER}/admin1/imagediffproject
        	docker login -u admin -p admin ${CLUSTER_MASTER}
    		export CFC_UID="admin"
    		export CFC_PASSWD="admin"
    		export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: 
    application/json"
    	https://master.cfc/acs/api/v1/auth/login'
    		export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    		echo ${KS_TOKEN}
    		export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}" -H "Content-Type: application/json" 
    "http://${IMAGE_MANAGER}/image-manager/api/v1/metadata/admin1/imagediffproject"'
    		eval ${CMD}
        	export CMD='curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin1/imagediffproject"'
        	eval ${CMD}
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories"'
        	(eval ${CMD} | python -mjson.tool|grep 'admin1/imagediffproject') && write_to_result "Remove Image Admin1 Project Test: FAIL" || write_to_result "Remove Image Admin1 
    Project Test : PASS"
    		counter=$((counter+1))
        }
        function remove_public_project_image
        {
        	echo "----------------------------Remove Public Project Image Test Start -----------------------------"
        	docker login -u admin -p admin ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/project1/imagepublic
        	docker push ${CLUSTER_MASTER}/project1/imagepublic
    		export CFC_UID="admin"
    		export CFC_PASSWD="admin"
    		export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: 
    application/json"
    	https://master.cfc/acs/api/v1/auth/login'
    		export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
    		echo ${KS_TOKEN}
        	export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "http://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project1/imagepublic"'
        	export CMD='curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagepublic"'
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagepublic"'
        	(eval ${CMD}| grep -q 'project1/imagepublic') && write_to_result "Remove Public Project Image Test: FAIL" || write_to_result "Remove Public Project Image Test Negative : 
    PASS"
    		counter=$((counter+1))
        }
    	
    	function remove_public_admin1_image
        {
        	echo "----------------------------Remove Public Project Image Test Start -----------------------------"
        	docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
        	docker tag hello-world ${CLUSTER_MASTER}/admin11/imagepublic
        	docker push ${CLUSTER_MASTER}/admin1/imagepublic
    		export CFC_UID="admin1"
        export CFC_PASSWD="admin1"
        export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
        export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        echo ${KS_TOKEN}
        	curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "http://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project1/imagepublic"
    		docker login -u admin -p admin ${CLUSTER_MASTER}
    		export CFC_UID="admin"
        export CFC_PASSWD="admin"
        export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
        export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        echo ${KS_TOKEN}
        	curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagepublic"
        	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagepublic"'
        	(eval ${CMD}| grep -q 'project1/imagepublic') && write_to_result "Remove Public Project Image Test: FAIL" || write_to_result "Remove Public Project Image Test Negative : 
    PASS"
    		counter=$((counter+1))
        }
    	
    function pull_image_test {
    	echo "----------------------------Pull Image Test Start -----------------------------"
    	docker login -u admin -p admin ${CLUSTER_MASTER}
    	docker tag hello-world ${CLUSTER_MASTER}/admin/imagepull
    	docker push ${CLUSTER_MASTER}/admin/imagepull
        export CFC_UID="admin"
        export CFC_PASSWD="admin"
        export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
        export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
        echo ${KS_TOKEN}
    	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepull"'
        (eval ${CMD}| grep -q 'admin/imagepull') && write_to_result "Pull Image Test - admin/imagepull push to image registry succeed" || write_to_result "Pull Image Test - 
    admin/imagepull push to registry failed"
        export output=$(docker pull ${CLUSTER_MASTER}/admin/imagepull)
        (echo "$output"| grep 'Digest: sha256') && write_to_result "Pull Image Test: PASS" || write_to_result "Pull Image Test : FAIL"
        export CMD='curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepull"'
    	eval ${CMD} counter=$((counter+1))
    }
    function pull_image_same_project_test {
            echo "----------------------------Pull Image Same Project Test Start -----------------------------"
            docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/admin/imagepull11
            docker push ${CLUSTER_MASTER}/admin/imagepull11
            export CFC_UID="admin1"
            export CFC_PASSWD="admin1"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepull11"'
            (eval ${CMD}| grep -q 'admin/imagepull11') && write_to_result "Pull Image Test - admin/imagepull push to image registry succeed" || write_to_result "Pull Image Test - 
    admin/imagepull push to registry failed"
    	    docker login -u admin -p admin ${CLUSTER_MASTER}
            export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            
        export output=$(docker pull ${CLUSTER_MASTER}/admin/imagepull11)
        (echo "$output"| grep 'Digest: sha256') && write_to_result "Pull Image Same Project Test: PASS" || write_to_result "Pull Image Same Project Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepull11" counter=$((counter+1))
    }
    function pull_image_different_project_public_test {
            echo "----------------------------Pull Image Different Project Public Test Start -----------------------------"
            docker login -u user2 -p user2 ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/project2/imagepull2
            docker push ${CLUSTER_MASTER}/project2/imagepull2
            export CFC_UID="user2"
            export CFC_PASSWD="user2"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project2/imagepull2"'
            eval ${CMD}
            export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project2/imagepull2"'
            (eval ${CMD} | python -mjson.tool|grep 'global') && write_to_result "pull image differnt project public test scope change to global" || write_to_result "pull image differnt 
    project public test scope change failed to global"
    	docker login -u admin -p admin ${CLUSTER_MASTER}
     export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
        export output=$(docker pull ${CLUSTER_MASTER}/project2/imagepull2)
        (echo "$output"| grep 'Digest: sha256') && write_to_result "Pull Image Different Project Public Test: PASS" || write_to_result "Pull Image Different Project Public Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project2/imagepull2" counter=$((counter+1))
    }
    function pull_image_different_project_project_negative_test {
            echo "----------------------------Pull Image Different Project project Negative Test Start -----------------------------"
            docker login -u user2 -p user2 ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/project2/imagepullproject
            docker push ${CLUSTER_MASTER}/project2/imagepullproject
            export CFC_UID="user2"
            export CFC_PASSWD="user2"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project2/imagepullproject"'
            eval ${CMD}
            docker login -u admin -p admin ${CLUSTER_MASTER}
        	export output=$(docker pull ${CLUSTER_MASTER}/project2/imagepullproject)
        	(echo "$output"| grep 'Digest: sha256') && write_to_result "Pull Image Different Project Project Negative Test: PASS" || write_to_result "Pull Image Different Project 
    project Negative Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project2/imagepullproject" counter=$((counter+1))
    }
    function pull_non_existing_image_negative_test {
            echo "----------------------------Pull Non Existing Image Negative Test Start -----------------------------"
            docker login -u admin -p admin ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/project1/imagepull
            docker push ${CLUSTER_MASTER}/project1/imagepull
    	 export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export output=$(docker pull ${CLUSTER_MASTER}/project1/nonexistingimage)
            (echo "$output"| grep 'Digest: sha256') && write_to_result "Pull Non Existing Image Negative Test: FAIL" || write_to_result "Pull Non Existing Image Negative Test : PASS" 
    counter=$((counter+1))
    }
    function push_image_test {
    	echo "----------------------------Push Image Test Start -----------------------------"
    	docker login -u admin -p admin ${CLUSTER_MASTER}
    	docker tag hello-world ${CLUSTER_MASTER}/project1/imagepush
        export output=$(docker push ${CLUSTER_MASTER}/project1/imagepush)
        (echo "$output"| grep 'digest: sha256') && write_to_result "Push Image Test: PASS" || write_to_result "Push Image Test : FAIL"
        export CMD='curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project1/imagepush"'
    	eval ${CMD}
    	counter=$((counter+1))
    }
    function push_image_same_project_test {
            echo "----------------------------Push Image Same Project Test Start -----------------------------"
            docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/admin/imagepush11
            docker push ${CLUSTER_MASTER}/admin/imagepush11
            export CFC_UID="admin1"
            export CFC_PASSWD="admin1"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepush11"'
            (eval ${CMD}| grep -q 'admin/imagepush11') && write_to_result "Push Image Same Project Test - admin/imagepush11 push to image registry succeed" || write_to_result "Push 
    Image Same Project Test - admin/imagepush11 push to registry failed"
    	    docker login -u admin -p admin ${CLUSTER_MASTER}
            export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            
        export output=$(docker push ${CLUSTER_MASTER}/admin/imagepush11)
        (echo "$output"| grep 'digest: sha256') && write_to_result "Pull Image Same Project Test: PASS" || write_to_result "Pull Image Same Project Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepush11"
    	counter=$((counter+1))
    }
    function push_image_admin_public_test {
            echo "----------------------------Push Image Admin Public Test Start -----------------------------"
            docker login -u admin -p admin ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/admin/imagepushpublic
            docker push ${CLUSTER_MASTER}/admin/imagepushpublic
    	export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
    	export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"global\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/admin/imagepushpublic"'
            eval ${CMD}
    	export CMD='curl -k -s -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepushpublic"'
            (eval ${CMD}| grep -q 'global') && write_to_result "Push Image Admin Public Test - project1/imagepull push to image registry succeed" || write_to_result "Push Image Admin 
    Public Test - project1/imagepull push to registry failed"
            export CMD=$(docker push ${CLUSTER_MASTER}/admin/imagepushpublic)
            (echo ${CMD}| grep -q 'digest: sha256') && write_to_result "Push Image Admin Public Test: PASS" || write_to_result "Push Image Admin Public Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepushpublic"
    		counter=$((counter+1))
    }
    function push_image_different_project_project_negative_test {
            echo "----------------------------Push Image Different Project project Negative Test Start -----------------------------"
            docker login -u user2 -p user2 ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/project2/imagepushproject
            docker push ${CLUSTER_MASTER}/project2/imagepushproject
            export CFC_UID="user2"
            export CFC_PASSWD="user2"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/project2/imagepushproject"'
            eval ${CMD}
            docker login -u admin -p admin ${CLUSTER_MASTER}
        	export output=$(docker push ${CLUSTER_MASTER}/project2/imagepushproject)
        	(echo "$output"| grep 'digest: sha256') && write_to_result "Push Image Different Project Project Negative Test: PASS" || write_to_result "Push Image Different Project 
    project Negative Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/project2/imagepushproject"
    		counter=$((counter+1))
    }
    function push_image_admin_project_negative_test {
            echo "----------------------------Push Image Admin Project Test Start -----------------------------"
            docker login -u admin1 -p admin1 ${CLUSTER_MASTER}
            docker tag hello-world ${CLUSTER_MASTER}/admin/imagepushadminproject
            docker push ${CLUSTER_MASTER}/admin/imagepushadminproject
            export CFC_UID="admin1"
            export CFC_PASSWD="admin1"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export CMD='curl -k -i -H "Authorization: Bearer ${KS_TOKEN}" -XPOST -d "{\"scope\": \"project\"}" -H "Content-Type: application/json" 
    "https://${IMAGE_MANAGER}/image-manager/api/v1/metadata/admin/imagepushadminproject"'
            eval ${CMD}
            docker login -u admin -p admin ${CLUSTER_MASTER}
            export CFC_UID="admin"
            export CFC_PASSWD="admin"
            export CMD='curl -k -s -XPOST -d "{ \"uid\":\"${CFC_UID}\", \"password\": \"${CFC_PASSWD}\" }" -H "Content-Type: application/json" -H "Accept-Type: application/json" 
    https://master.cfc/acs/api/v1/auth/login'
            export KS_TOKEN=$(eval ${CMD} | python -c 'import sys, json; print json.load(sys.stdin)["token"]')
            echo ${KS_TOKEN}
            export output=$(docker push ${CLUSTER_MASTER}/admin/imagepushadminproject)
            (echo "$output"| grep 'digest: sha256') && write_to_result "Push Image Admin Project Test: PASS" || write_to_result "Push Image Admin Project Test : FAIL"
            curl -k -s -XDELETE -H "Authorization: Bearer $KS_TOKEN" "http://${IMAGE_MANAGER}/image-manager/api/v1/repositories/admin/imagepushadminproject"
    		counter=$((counter+1))
    }
    jwt_token_test 
    list_test 
    list_user1_test 
    list_admin1_test 
    list_detail_test 
    modify_test 
    modify_image_admin1_project_test 
    modify_admin_image_test remove_image_test 
    remove_image_project_test 
    remove_image_admin1_project_test 
    pull_image_test 
    pull_image_same_project_test 
    pull_image_different_project_public_test 
    pull_non_existing_image_negative_test 
    push_image_test 
    push_image_same_project_test 
    push_image_admin_public_test 
    push_image_different_project_project_negative_test 
    push_image_admin_project_negative_test 
    write_to_result "Total $counter test cases executed"
