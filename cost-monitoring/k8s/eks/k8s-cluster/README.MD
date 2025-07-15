
After successful "tofu apply"
```bash
aws eks update-kubeconfig --region ap-south-1 --name Jul01Ekst3xlarge-eks
kubectl apply -f test-http-app.yaml
kubectl get pods
kubectl get svc http-test-service
```

delegate setup with Helm
Following can be obtained from Harness UI
Account Settings -> 
    Connectors -> 
        Kubernetes Cluster (Cloud Provider) -> 
            Step (3) Delegate setup -> 
                Install new Delegate -> 
                    Helm Chart -> copy paste the commands and execute like below

```bash
helm repo add harness-delegate https://app.harness.io/storage/harness-download/delegate-helm-chart/
helm repo update harness-delegate
helm upgrade -i helm-delegate --namespace harness-delegate-ng --create-namespace \
  harness-delegate/harness-delegate-ng \
  --set delegateName=helm-delegate \
  --set accountId=xxxxxxxxxxxxxxx \
  --set delegateToken=xxxxxxxxxxxxxxxxxxxx= \
  --set managerEndpoint=https://app.harness.io \
  --set delegateDockerImage=us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.06.86100 \
  --set replicas=1 --set upgrader.enabled=true
```

or use a Helm chart as follows
```yaml
```
while destroying, do this 
```bash

kubectl delete svc http-test-service

aws elb describe-load-balancers
aws elbv2 describe-load-balancers
aws elb delete-load-balancer --load-balancer-name a5ba2c491eff04c5fbdd6fa53cf1a895

aws ec2 detach-internet-gateway \
  --internet-gateway-id igw-06c9e4c87f7fbed28 \
  --vpc-id vpc-0321debb5a3fc7eeb

# Check below returns empty if not delete it
aws ec2 describe-network-interfaces --filters Name=vpc-id,Values=vpc-0321debb5a3fc7eeb
aws ec2 describe-subnets --filters Name=vpc-id,Values=vpc-0321debb5a3fc7eeb
aws ec2 describe-route-tables --filters Name=vpc-id,Values=vpc-0321debb5a3fc7eeb
aws ec2 describe-security-groups --filters Name=vpc-id,Values=vpc-0321debb5a3fc7eeb

aws ec2 delete-security-group --group-id sg-09358419df9a6f281

```