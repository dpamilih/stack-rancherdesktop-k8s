# stack-rancherdesktop-k8s

## Assumption & Preparation

- Kibana will be available on https://localhost-kb
- Elasticsearch will be exposed on https://localhost-es
- Stack monitoring using metricbeat and filebeat will be enabled ***don't forget to configure ILM for these indices, as the default one will will not be limited in disk space usage***
- The stack will be using ```elastic-system``` namespace
- Tested on [Rancher Desktop](https://rancherdesktop.io/), but should also work in other K8s environment
- Using traefik ingress, but should also work with other ingress as well. 

### Preparation Steps
1. Edit /etc/hosts file to enable resolution to ```localhost-kb``` and ```localhost-es```
2. Clone this git to your host 
    ```
    git clone https://github.com/dpamilih/stack-rancherdesktop-k8s
    ```
3. If using Rancher Desktop the default configuration will not work as it expect a proper TLS certs on the backend while elasticsearch and kibana image will use self-signed cert by default. Run the following to update the traefik configuration to not check valid cert on the backend 
     ```
     helm repo add traefik https://helm.traefik.io/traefik
     helm repo update
     helm -n kube-system upgrade traefik traefik/traefik -f traefik-values.yml
     ```

## Install the stack

1. Install ECK, this example is using helm chart
    ```
    helm repo add elastic https://helm.elastic.co
    helm repo update
    helm install elastic-operator elastic/eck-operator -n elastic-system --create-namespace
    ```
2. Install elasticsearch & kibana
    ```
    kubectl apply -f elasticsearch.yaml
    ```
3. Install ingress to expose the pods to outside world
    ```
    kubectl apply -f stack-ingress.yaml
    ```
4. Install beats to monitor cluster
    ```
    kubectl apply -f stack-monitoring-filebeat.yaml
    kubectl apply -f stack-monitoring-metricbeat.yaml
    ```
5. Kibana will be available at ```https://localhost-kb``` the user id is ```elastic``` the password can be retrieved by pass.sh script:
    ```
    sh ./pass.sh
    ```
6. Elasticsearch can be reached at ```https://localhost-es``` please note that it will use port 443 as it is exposed via an ingress. The default auth will be ```elastic``` and password as above.
6. ***Check the ILM for filebeat & metricbeat indices, make sure it will be deleted after certain period of time***
