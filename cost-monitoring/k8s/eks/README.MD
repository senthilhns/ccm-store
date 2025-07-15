
### Setup Harness Delegate
```bash
helm repo add harness-delegate https://app.harness.io/storage/harness-download/delegate-helm-chart/
helm repo update harness-delegate
helm repo add harness-delegate https://app.harness.io/storage/harness-download/delegate-helm-chart/
helm repo update harness-delegate
helm upgrade -i helm-delegate --namespace harness-delegate-ng --create-namespace \
  harness-delegate/harness-delegate-ng \
  --set delegateName=helm-delegate \
  --set accountId=xxxxx \
  --set delegateToken=xxxxx \
  --set managerEndpoint=https://app.harness.io \
  --set delegateDockerImage=us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.06.86100 \
  --set replicas=1 --set upgrader.enabled=true
```

### Permissions to be given for the CCM, RBAC permissions
kubectl apply -f ccm-k8s-permissions.yaml

