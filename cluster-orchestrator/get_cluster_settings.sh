#!/bin/bash
# Usage: ./get_eks_cluster_info.sh <cluster_name>

CLUSTER_NAME=$1

if [ -z "$CLUSTER_NAME" ]; then
  echo "Usage: $0 <cluster_name>"
  exit 1
fi

# Get cluster details
CLUSTER_JSON=$(aws eks describe-cluster --name "$CLUSTER_NAME" --output json)

# Extract fields
CLUSTER_ENDPOINT=$(echo $CLUSTER_JSON | jq -r '.cluster.endpoint')
CLUSTER_OIDC_ARN=$(echo $CLUSTER_JSON | jq -r '.cluster.identity.oidc.issuer' | sed 's~^https://~~')
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
CLUSTER_OIDC_ARN="arn:aws:iam::${ACCOUNT_ID}:oidc-provider/${CLUSTER_OIDC_ARN}"

CLUSTER_SUBNET_IDS=$(echo $CLUSTER_JSON | jq -r '.cluster.resourcesVpcConfig.subnetIds[]')
CLUSTER_SG_IDS=$(echo $CLUSTER_JSON | jq -r '.cluster.resourcesVpcConfig.securityGroupIds[]')

# ----------------------------
# Get AMIs from nodegroups
# ----------------------------
NODEGROUPS=$(aws eks list-nodegroups --cluster-name "$CLUSTER_NAME" --query 'nodegroups[]' --output text)
AMIS=()

for ng in $NODEGROUPS; do
  NG_JSON=$(aws eks describe-nodegroup --cluster-name "$CLUSTER_NAME" --nodegroup-name "$ng" --output json)

  # 1) If launch template is used
  LT_ID=$(echo $NG_JSON | jq -r '.nodegroup.launchTemplate.id // empty')
  if [ -n "$LT_ID" ]; then
    AMI=$(aws ec2 describe-launch-template-versions \
      --launch-template-id "$LT_ID" \
      --query 'LaunchTemplateVersions[-1].LaunchTemplateData.ImageId' \
      --output text)
    [ "$AMI" != "None" ] && AMIS+=("$AMI")
  fi

  # 2) Otherwise, fall back to ASG instance image
  ASG_NAME=$(echo $NG_JSON | jq -r '.nodegroup.resources.autoScalingGroups[0].name')
  if [ -n "$ASG_NAME" ]; then
    INSTANCES=$(aws autoscaling describe-auto-scaling-groups \
      --auto-scaling-group-names "$ASG_NAME" \
      --query 'AutoScalingGroups[0].Instances[*].InstanceId' \
      --output text)
    for inst in $INSTANCES; do
      AMI=$(aws ec2 describe-instances \
        --instance-ids "$inst" \
        --query 'Reservations[0].Instances[0].ImageId' \
        --output text)
      [ "$AMI" != "None" ] && AMIS+=("$AMI")
    done
  fi
done

# Deduplicate AMIs
AMIS=($(printf "%s\n" "${AMIS[@]}" | sort -u))

# ----------------------------
# Connector ID (custom logic)
# ----------------------------
CCM_CONNECTOR_ID="${CLUSTER_NAME}connCostaccess"

# ----------------------------
# Print results
# ----------------------------
echo "cluster_name               = \"$CLUSTER_NAME\""
echo "cluster_endpoint           = \"$CLUSTER_ENDPOINT\""
echo "cluster_oidc_arn           = \"$CLUSTER_OIDC_ARN\""

echo "cluster_subnet_ids         = ["
for sn in $CLUSTER_SUBNET_IDS; do
  echo "  \"$sn\","
done
echo "]"

echo "cluster_security_group_ids = ["
for sg in $CLUSTER_SG_IDS; do
  echo "  \"$sg\","
done
echo "]"

echo "cluster_amis               = ["
for ami in "${AMIS[@]}"; do
  echo "  \"$ami\","
done
echo "]"

echo "ccm_k8s_connector_id       = \"$CCM_CONNECTOR_ID\""
