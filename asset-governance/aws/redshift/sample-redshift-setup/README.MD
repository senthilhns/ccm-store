# Minimal Redshift Setup for Policy Testing

This Terraform setup creates a minimal-cost AWS Redshift cluster designed to be detected by specific Cloud Custodian policies.

## Features

- **Minimal Cost**: Deploys a single `dc2.large` node.
- **Policy-Triggering Configuration**:
  - Automated snapshot retention period is set to **15 days** (to trigger the `> 14 days` policy).
  - Cross-region snapshot copy is **enabled** (to trigger the `cross-region copy` policy).
- **Public Access**: The cluster is publicly accessible for easy testing.

## Usage

1.  **Configure your AWS credentials** (via environment variables or `aws configure`).

2.  **Create a `terraform.tfvars` file** with your VPC and subnet IDs:

    ```hcl
    vpc_id     = "vpc-xxxxxxxxxxxxxxxxx"
    subnet_ids = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyyyyy"]
    ```

3.  **Initialize Terraform**:

    ```sh
    terraform init
    ```

4.  **Apply the configuration**:

    ```sh
    terraform apply
    ```

5.  **Test the redshift setup login using psql client**:
```bash
tofu output cluster_endpoint
# <cluster_endpoint> output will be something like below don't include the :5439 in the <cluster_endpoint>
# "oct-21-016-redshift-cluster-for-testing.ccxfq7u0wyku.ap-south-1.redshift.amazonaws.com:5439"

PGPASSWORD=Test1234 psql -h <cluster_endpoint> -p 5439 -U awsuser -d dev
```


6.**Check redshift db works**:
```postgresql
CREATE TABLE test_table (id INT, name VARCHAR(100));
INSERT INTO test_table VALUES (1, 'Test');
SELECT * FROM test_table;
```

7.**Destroy Manually to avoid final snapshot creation error**:
```bash
aws redshift delete-cluster   --cluster-identifier oct-21-016-redshift-cluster-for-testing   --final-cluster-snapshot-identifier oct-21-016-final-snapshot   --no-skip-final-cluster-snapshot
aws redshift delete-cluster-snapshot --snapshot-identifier oct-21-016-final-snapshot
terraform state rm aws_redshift_cluster.redshift_cluster
```
