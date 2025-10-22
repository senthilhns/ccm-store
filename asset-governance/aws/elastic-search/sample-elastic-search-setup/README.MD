# OpenSearch/Elasticsearch Terraform Quickstart

## Prerequisites
- AWS account with VPC and subnets
- Terraform >= 1.0.0
- AWS CLI configured

## Service-Linked Role (First-Time Only)
Enable the AWS service-linked role for OpenSearch to allow it to create domains in your VPC (skip if already done):
```bash
aws iam create-service-linked-role --aws-service-name opensearchservice.amazonaws.com
```

## Setup
1. **Clone this repo and navigate to this directory.**
2. **Copy and edit variables:**
   - Copy `terraform.tfvars.example` to `terraform.tfvars`
   - Edit values to match your VPC, subnets, and desired configuration

3. **Initialize Terraform:**
```bash
terraform init
```

4. **Review the plan:**
```bash
terraform plan
```

5. **Apply to create resources:**
```bash
terraform apply
```

After successful apply you will see the output like this
```bash
 $ tofu output
# domain_arn = "arn:aws:es:ap-south-1:xxxxxxxxxxxxx:domain/os23-rltst"
# domain_endpoint = "vpc-os23-rltst-lrscqec4cgazeotwaofbtlwecm.ap-south-1.es.amazonaws.com"
# domain_id = "xxxxxxxxxxxxx/os23-rltst"
# jumpbox_private_key_pem = <sensitive>
# jumpbox_public_ip = "13.203.209.115"
# kibana_endpoint = "vpc-os23-rltst-lrscqec4cgazeotwaofbtlwecm.ap-south-1.es.amazonaws.com/_plugin/kibana/"
```

6. ** Test the elastic / open search setup is working fine**
```bash
# ssh into jumpbox
ssh -i jumpbox.pem ubuntu@13.203.209.115

# Run all commands from inside of jumpbox
sudo apt update
sudo apt install python3-pip -y
pip3 install --user awscurl
sudo apt install awscli -y
aws configure
~/.local/bin/awscurl --service es -XGET "https://vpc-os23-rltst-lrscqec4cgazeotwaofbtlwecm.ap-south-1.es.amazonaws.com/" --region ap-south-1
# sample output will look like below
{
  "name" : "56aa9ac11eb5c172863acd8aabe05492",
  "cluster_name" : "xxxxxxxxxxxxx:os23-rltst",
  "cluster_uuid" : "sxUHYhmtQCag0xBUjsSZlQ",
  "version" : {
    "distribution" : "opensearch",
    "number" : "1.3.2",
    "build_type" : "tar",
    "build_hash" : "unknown",
    "build_date" : "2025-10-07T10:38:59.676998Z",
    "build_snapshot" : false,
    "lucene_version" : "8.10.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "The OpenSearch Project: https://opensearch.org/"
}
```

## Outputs
- Domain endpoint and Kibana endpoint will be shown after apply.

## Public Access (for quick testing)
- The default config allows public HTTPS (port 443) access. **Do not use in production!**
- Restrict access by setting `restrict_public_access = true` and editing `allowed_cidr_blocks` in `terraform.tfvars`.

## Cleanup
To destroy all resources:
```bash
terraform destroy
```

## Notes
- Domain name must start with a lowercase letter, be 3-28 chars, and only contain a-z, 0-9, and hyphens.
- For production, always restrict access and enable fine-grained access controls.
