# GKE Sample K8s Cluster

This folder contains Terraform and Kubernetes manifests to deploy a sample GKE (Google Kubernetes Engine) cluster with Harness CCM AutoStopping integration, following the structure of AKS/EKS samples.

```bash
gcloud container clusters get-credentials gke-k8s-cluster-g101 --region asia-south1 --project hns-sbox
kubectl get nodes
gcloud container clusters resize gke-k8s-cluster-g101 \
  --node-pool=primary-node-pool \
  --num-nodes=1 \
  --region=asia-south1 \
  --project=hns-sbox
```