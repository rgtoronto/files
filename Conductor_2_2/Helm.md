### Setup helm client

##### get helm client image from daily server
    # docker run --rm -v $(pwd)/:/data ma1dock1.platformlab.ibm.com/library/helm:v2.0.0 cp /usr/local/bin/helm /data
    
##### kubectl describe services/helm --namespace=kube-system -s cfc-master:8888
        # kubectl describe services/helm --namespace=kube-system -s 9.21.58.21:8888
        Name:                   helm
        Namespace:              kube-system
        Labels:                 kubernetes.io/cluster-service=true
                                kubernetes.io/name=Helm
        Selector:               k8s-app=helm
        Type:                   NodePort
        IP:                     10.0.0.214
        Port:                   api     8000/TCP
        NodePort:               api     30174/TCP
        Endpoints:              10.1.9.4:8000
        Port:                   grpc    44134/TCP
        NodePort:               grpc    31364/TCP
        Endpoints:              10.1.9.4:44134
        Session Affinity:       None
        No events.
        
        # kubectl get nodes -s 9.21.58.21:8888
        NAME       STATUS    AGE
        ma1demo3   Ready     4h

##### run following command to setup variables
    # export HELM_HOME=/usr/local/bin/helm
    # export HELM_HOST=ma1demo3:31364  
    
    where ma1demo3: is the node your helm docker container is running on
          31364:    is the port number from NodePort section from above
          
##### run following command to check the helm version
    # helm version
    Client: &version.Version{SemVer:"v2.0.0", GitCommit:"51bdad42756dfaf3234f53ef3d3cb6bcd94144c2", GitTreeState:"clean"}
    Server: &version.Version{SemVer:"v2.0.0", GitCommit:"51bdad42756dfaf3234f53ef3d3cb6bcd94144c2", GitTreeState:"clean"}

##### create a folder for your local chart repo
    # mkdir chart_repo
    # cd chart_repo
    
##### Create your own chart    
    # helm create nginx
    # cd nginx
    
    Modify Chart.yaml and values.yaml file to confir your chart

##### package and verify your chart
    # helm package nginx
    # helm lint --strict nginx

##### add your chart to a repo
    # 
    