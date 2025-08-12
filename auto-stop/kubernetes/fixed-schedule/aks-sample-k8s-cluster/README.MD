After successful "tofu apply"
```bash
az aks get-credentials --resource-group akstest5aug --name k8s005cluster
kubectl apply -f test-http-app.yaml
kubectl get pods
kubectl get svc http-test-service
```

while destroying, do this
```bash

kubectl delete svc http-test-service

