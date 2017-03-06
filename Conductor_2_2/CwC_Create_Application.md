##### json file
    {
      "kind": "Deployment",
      "apiVersion": "extensions/v1beta1",
      "metadata": {
        "name": "nginx-gg"
      },
      "spec": {
        "replicas": 2,
        "template": {
          "metadata": {
            "labels": {
              "app": "nginx-gg"
            }
          },
          "spec": {
            "containers": [
              {
                "name": "nginx",
                "image": "nginx",
                "imagePullPolicy": "Always",
                "ports": [
                  {
                    "protocol": "TCP"
                    "containerPort": 80
                  }
                ],
                "resources": {
                  "limits": {}
                }
              }
            ]
          }
        }
      }
    }