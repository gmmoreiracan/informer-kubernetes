#!/bin/bash
#Env Variables
export  K8S_NAMESPACE='servicenow' \
    K8S_CLUSTER='default' \
    SN_INSTANCE='dev185921' \
    SN_USER='cno_informer' \
    SN_PASS='M!d.us3r.' \
    SN_HELM_URL='https://install.service-now.com/glide/distribution/builds/package/informer/1.0.2/informer-helm-1.0.2.tgz' \
    SN_HELM_MEMORY_LIMIT='512Mi' \
    DOCKER_USERNAME='gmmoreira.eng@gmail.com' \
    DOCKER_PASSWORD='cmVmdGtuOjAxOjE3MzkxNzY1NzY6SU5INDZOVEZhWDJORTRGQVNHcXpYOGRZY0VU' \
    DOCKER_EMAIL='gmmoreira.eng@gmail.com' \
    DOCKER_SERVER='https://bisnages.jfrog.io'
    CNO_IMAGE_REPO='bisnages.jfrog.io/servicenow-informer/informer:1.0.2'
    CNO_IMAGE_REPO_TAG='1.0.2'


#Create Namespace
kubectl create namespace $K8S_NAMESPACE

#Create Secret
kubectl create secret generic k8s-informer-cred-$SN_INSTANCE --from-literal=.user=$SN_USER --from-literal=.password=$SN_PASS  -n $K8S_NAMESPACE

#Create Repo Secret
kubectl create secret docker-registry k8s-informer-repo-cred --docker-server $DOCKER_SERVER --docker-username $DOCKER_USERNAME --docker-password $DOCKER_PASSWORD --docker-email $DOCKER_EMAIL -n $K8S_NAMESPACE

#Install Helm Chart
helm install -n $K8S_NAMESPACE --set memoryLimit=$SN_HELM_MEMORY_LIMIT --set acceptEula=Y --set instance.name=$SN_INSTANCE --set clusterName=$K8S_CLUSTER --set image.repository=$CNO_IMAGE_REPO --set image.tag=$CNO_IMAGE_REPO_TAG k8s-informer $SN_HELM_URL
```