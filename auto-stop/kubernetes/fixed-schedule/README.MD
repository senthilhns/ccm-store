
---
## Install metrics server

```bash
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm install metrics-server metrics-server/metrics-server -n kube-system
```
or
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```


## Create a cost connector - 
k8s cloud connector should be already existing for this refer to sample-k8s-cluster/README.MD
In the k8s cost connector UI be sure to select the Auto Stopping feature in feature selection

### Create connector from UI
    Account Settings ->
        Connectors ->
            Kubernetes Cluster (Cost CCM) ->
                from step "Secret Creation" download yaml and save as auto-stop-connector-secret.yaml
                then from step "Provide Permissions - Download YAML" download as ccm-kubernetes.yaml
                kubectl apply -f ccm-kubernetes.yaml

### Create a file auto-stop-connector-secret.yaml
Account Settings ->
    Connectors ->
        Kubernetes Cluster (Cost CCM) ->
            from step "Secret Creation" download yaml and save as auto-stop-connector-secret.yaml
            the yaml file looks like below do the following to replace <YOUR_HARNESS_API_TOKEN> with the correct token  
```yaml
apiVersion: v1
stringData:
  token:  <YOUR_HARNESS_API_TOKEN>
kind: Secret
metadata:
  name: harness-api-key
  namespace: harness-autostopping
type: Opaque
```
```bash
kubectl create namespace harness-autostopping
kubectl apply -f auto-stop-connector-secret.yaml
```

### Set kubernetes permissions
    Account Settings -> (continuation of previous steps in sequences)
        Connectors ->
            Kubernetes Cluster (Cost CCM) ->                
                then from step "Provide Permissions - Download YAML" download as ccm-kubernetes.yaml
                
```bash
kubectl apply -f ccm-kubernetes.yaml
```

--- 
### Install metrics Server
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Complete the cost connector workflow

### Create http ingress file http-ingress.yaml
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: http-test-ingress
  namespace: default
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: http-test-service
                port:
                  number: 80
```

apply yaml

```bash
kubectl apply -f http-ingress.yaml
```

### Modify the Autostop rule yaml shown in the UI during rule creation 
see e.g below
```yaml
apiVersion: ccm.harness.io/v1
kind: AutoStoppingRule
metadata:
  name: jul24eks-eks-schedule
  namespace: default
  annotations:
    harness.io/cloud-connector-id: myawsconn
spec:
  service:
    name: http-test-service
    port: 80
  ingress:
    name: http-test-ingress
    controllerName: nginx
  idleTimeMins: 15
  hideProgressPage: false
```

apply yaml

```bash
kubectl apply -f auto-stop-rule.yaml
```
