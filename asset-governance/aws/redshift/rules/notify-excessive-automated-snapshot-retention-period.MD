
```sh
# check find-redis-low-bytes-handled.yaml rule findings
c7n validate notify-excessive-automated-snapshot-retention-period.yaml # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./notify-excessive-automated-snapshot-retention-period.yaml # runs the policy and writes results to /tmp/output_dir
```

*** view the output
```    
# syntax highlighted output
jq . /tmp/output_dir/notify-excessive-automated-snapshot-retention-period/resources.json
```

*** sample output
```json
[
  {
    "ClusterIdentifier": "oct-21-016-redshift-cluster-for-testing",
    "NodeType": "ra3.xlplus",
    "ClusterStatus": "available",
    "ClusterAvailabilityStatus": "Available",
    "MasterUsername": "awsuser",
    "DBName": "dev",
    "Endpoint": {
      "Address": "oct-21-016-redshift-cluster-for-testing.ccxfq7u0wyku.ap-south-1.redshift.amazonaws.com",
      "Port": 5439,
      "VpcEndpoints": [
        {
          "VpcEndpointId": "vpce-004bebce261bba9d5",
          "VpcId": "vpc-0f435a788ecfb84fa",
          "NetworkInterfaces": [
            {
              "NetworkInterfaceId": "eni-07f325ba7af8b6a08",
              "SubnetId": "subnet-0b29b316bb0e744b5",
              "PrivateIpAddress": "172.31.46.196",
              "AvailabilityZone": "ap-south-1a"
            }
          ]
        }
      ]
    },
    "ClusterCreateTime": "2025-10-21T18:11:09.608000+00:00",
    "AutomatedSnapshotRetentionPeriod": 15,
    "ManualSnapshotRetentionPeriod": -1,
    "ClusterSecurityGroups": [],
    "VpcSecurityGroups": [
      {
        "VpcSecurityGroupId": "sg-0c991d3fabd82112f",
        "Status": "active"
      }
    ],
    "ClusterParameterGroups": [
      {
        "ParameterGroupName": "default.redshift-2.0",
        "ParameterApplyStatus": "in-sync"
      }
    ],
    "ClusterSubnetGroupName": "oct-21-016-redshift-subnet-group-for-testing",
    "VpcId": "vpc-0f435a788ecfb84fa",
    "AvailabilityZone": "ap-south-1a",
    "PreferredMaintenanceWindow": "wed:07:00-wed:07:30",
    "PendingModifiedValues": {},
    "ClusterVersion": "1.0",
    "AllowVersionUpgrade": true,
    "NumberOfNodes": 1,
    "PubliclyAccessible": true,
    "Encrypted": true,
    "ClusterPublicKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCMBHJCs2Q1sMy1wX8M4SLsD86X3K3IrMKQcJHOTUIkg550nxYppKtkL4rVibsf3TtjKMmVtJMd/N1hWpcNnTOJiaPhkJpYD5q6VmnbpzsFCxGt0jWaSlJ8G+le/HxXAUuHyhohwWGYjjot6RuGxi7YX65yLZPVZELRdeMfrNdhmTegUGppI8sKJs7o0uE8LAPNG9k0DSiaxdEef6ZJeey/RNqT0y3y3HxWl3XPle6uQiQs8EnejcYYUv6K4HV8/5Bbv+bahfAHWHaVRQk6gvz0javkPqVlnzGB0zomTqxwEQwSZiMhSFF67nkRJ3oY2o2lthr0475SUZi3b+YRjVZn Amazon-Redshift\n",
    "ClusterNodes": [
      {
        "NodeRole": "SHARED",
        "PrivateIPAddress": "172.31.34.169",
        "PublicIPAddress": "3.108.114.46"
      }
    ],
    "ClusterRevisionNumber": "138443",
    "Tags": [
      {
        "Key": "Environment",
        "Value": "nonprod"
      },
      {
        "Key": "Owner",
        "Value": "cloud-custodian-demo"
      },
      {
        "Key": "CostCenter",
        "Value": "testing"
      },
      {
        "Key": "StackPrefix",
        "Value": "oct-21-016"
      },
      {
        "Key": "Name",
        "Value": "oct-21-016-redshift-cluster-for-testing"
      }
    ],
    "KmsKeyId": "AWS_OWNED_KMS_KEY",
    "EnhancedVpcRouting": false,
    "IamRoles": [],
    "MaintenanceTrackName": "current",
    "DeferredMaintenanceWindows": [],
    "NextMaintenanceWindowStartTime": "2025-10-22T07:00:00+00:00",
    "AvailabilityZoneRelocationStatus": "disabled",
    "ClusterNamespaceArn": "arn:aws:redshift:ap-south-1:xxxxxxxxxxxxx:namespace:59feb684-34fb-4e8b-aa04-d7878f27f7e1",
    "TotalStorageCapacityInMegaBytes": 4000000,
    "AquaConfiguration": {
      "AquaStatus": "disabled",
      "AquaConfigurationStatus": "auto"
    },
    "MultiAZ": "Disabled",
    "c7n:MatchedFilters": [
      "AutomatedSnapshotRetentionPeriod"
    ]
  }
]
```

*** Get quick summary of the redshift cluster
```bash
jq -r '.[] | "\(.ClusterIdentifier) | \(.NodeType) | \(.ClusterVersion) | \(.ClusterStatus) | \(.NumberOfNodes) | \(.AvailabilityZone)"' /tmp/output_dir/notify-excessive-automated-snapshot-retention-period/resources.json
# will show output similar to following
# oct-21-016-redshift-cluster-for-testing | ra3.xlplus | 1.0 | available | 1 | ap-south-1a
```