# stack-rancherdesktop-k8s

## Assumption & Preparation

- Kibana will be available on https://localhost-kb
- Elasticsearch will be exposed on https://localhost-es
- Tested on [Rancher Desktop](https://rancherdesktop.io/), but should also work in other K8s environment
- Using traefik ingress, but should also work with other ingress as well. 

### Preparation Steps
1. Edit /etc/hosts file to enable resolution to ```localhost-kb``` and ```localhost-es```
2. Clone this git to local host 
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

1. Kibana will be available at ```https://localhost-kb``` the user id is ```elastic``` the password can be retrieved by pass.sh script:
    ```
    sh ./pass.sh
    ```
2. Elasticsearch can be reached at ```https://localhost-es``` please note that it will use port 443 as it is exposed via an ingress. The default auth will be ```elastic``` and password as above.
3. ***Check the ILM for filebeat & metricbeat indices, make sure it will be deleted after certain period of time***
