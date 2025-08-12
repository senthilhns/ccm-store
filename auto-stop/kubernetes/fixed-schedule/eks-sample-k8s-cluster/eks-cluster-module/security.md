# EKS Cluster IAM Roles & Policies Table

| Resource Name                                                | Type         | Purpose / Why Required                                                                                  |
|-------------------------------------------------------------|--------------|--------------------------------------------------------------------------------------------------------|
| aws_iam_role.eks_cluster                                    | Role         | Allows EKS control plane to manage AWS resources on your behalf.                                       |
| data.aws_iam_policy_document.eks_cluster_assume_role_policy  | Policy Doc   | Allows eks.amazonaws.com to assume the eks_cluster role.                                               |
| aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy | Policy Attach | Grants EKS control plane permissions to manage cluster resources.                                      |
| aws_iam_role.eks_node_group                                 | Role         | Allows EC2 worker nodes to interact with AWS services as part of the EKS node group.                   |
| data.aws_iam_policy_document.eks_node_assume_role_policy     | Policy Doc   | Allows ec2.amazonaws.com to assume the eks_node_group role.                                            |
| aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy | Policy Attach | Allows worker nodes to join the cluster and communicate with the EKS control plane.                    |
| aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly | Policy Attach | Allows worker nodes to pull container images from Amazon ECR.                                          |
| aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy | Policy Attach | Allows worker nodes to manage networking (ENIs) for Kubernetes pods.                                   |
| aws_iam_role_policy_attachment.eks_node_AmazonEKSLoadBalancerControllerPolicy | Policy Attach | Allows provisioning and management of AWS Load Balancers (ELB/ALB) via Kubernetes Service type LB.     |
