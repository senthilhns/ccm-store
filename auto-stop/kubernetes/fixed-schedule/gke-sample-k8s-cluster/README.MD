# GKE Sample K8s Cluster

This folder contains Terraform and Kubernetes manifests to deploy a sample GKE (Google Kubernetes Engine) cluster with Harness CCM AutoStopping integration, following the structure of AKS/EKS samples.

### Create cluster
```bash
cp terraform.tfvars.example terraform.tfvars # edit and set parameters
tofu init
tofu validate
tofu plan
tofu apply -auto-approve
```

### Set kubectl credentials e.g command below
```bash
gcloud container clusters get-credentials gke-k8s-cluster-g101 --region asia-south1 --project hns-sbox
```

### Check kubernetes cluster
```bash
kubectl get nodes
gcloud container clusters resize gke-k8s-cluster-g101 \
  --node-pool=primary-node-pool \
  --num-nodes=1 \
  --region=asia-south1 \
  --project=hns-sbox
```

### Install metrics Server