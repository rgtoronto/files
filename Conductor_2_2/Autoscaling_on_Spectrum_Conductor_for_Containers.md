Since we have IBM Spectrum Conductor with Containers 0.1.0 released, people know it could repsond to end user requests quickly and create software fast.
We probably also try to build a service which is expanded fast than what you expected, and running out of resources.

### Before you begin:
    1. Installed IBM Spectrum Conductor for Containers following the user guide: link to user guide
    2. We could use a customized docker image based on php-apache server. you can find image here.
        https://github.com/kubernetes/kubernetes/tree/8caeec429ee1d2a9df7b7a41b21c626346b456fb/docs/user-guide/horizontal-pod-autoscaling/image
        
### Here is the steps how autoscaling works on IBM Spectrum Conductor for Containers.

#### 1. Create php-apache application
    From web management console, select Applications on left panel, then click on "Deploy Application", 
    ![Alt text](C:\Docs_Rebecca\CwC\autoscaling-app.png?raw=true "Optional Title")
#### 2.