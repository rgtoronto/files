### Basics
    1. the key must be DNS subdomain as per RFC 1035 with a max length of 253 characters
    2. you need to base64-encode the value yourself
    3. a secret’s value is limited to 1MB in size

### Steps
#### 1. Suppose you want to share the value some-base64-encoded-payload under the key my-secret-key as a Kubernetes Secret for a pod. This means first you’d base64-encode it like so:
        echo -n some-base64-encoded-payload | base64
        c29tZS1iYXNlNjQtZW5jb2RlZC1wYXlsb2Fk
        Note the -n parameter with echo; this is necessary to suppress the trailing newline character. If you don’t do this, your value is not correctly encoded.
#### 2. you can use it in a YAML doc
        cat example-secret.yaml
        apiVersion: v1
        kind: Secret
        metadata:
          name: mysecret
        type: Opaque
        data:
          my-super-secret-key: c29tZS1iYXNlNjQtZW5jb2RlZC1wYXlsb2Fk
#### 3. K8s create this secret
        kubectl create -f example-secret.yaml
        secrets/mysecret
        
#### 4. Verify the secret was created
        kubectl get secrets
        NAME        TYPE      DATA
        mysecret    Opaque    1
#### 5. Create a yaml file for pod with secret, and note:
        example-secret.yaml should never ever be committed to a source control system such as Git. If you do that, you’re exposing the secret and the whole exercise would have been for nothing.
        
        cat example-secret-pod.yaml
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            name: secretstest
          name: secretstest
        spec:
          volumes:
            - name: "secretstest"
              secret:
                secretName: mysecret
          containers:
            - image: nginx:1.9.6
              name: awebserver
              volumeMounts:
                - mountPath: "/tmp/mysec"
                  name: "secretstest"
#### 6. Submit the request to create a pod
        kubectl create -f example-secret-pod.yaml
        pods/secretstest

#### 7. Check if secret worked
        kubectl describe pods secretstest
            Name:               secretstest
            Namespace:          default
            Image(s):           nginx:1.9.6
            Node:               10.0.1.193/10.0.1.193
            Labels:             name=secretstest
            Status:             Running
            ...
#### Reference:
    http://kubernetes.io/docs/user-guide/secrets/#creating-a-secret-manually
    https://mesosphere.com/blog/2015/11/12/sharing-secret-data-in-kubernetes/
    http://kubernetes.io/docs/user-guide/secrets/#using-secrets-as-files-from-a-pod
    http://kubernetes.io/docs/user-guide/kubectl-overview/