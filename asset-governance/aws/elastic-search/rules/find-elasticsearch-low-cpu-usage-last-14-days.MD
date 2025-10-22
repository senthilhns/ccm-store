

```sh
# check find-redis-low-bytes-handled.yaml rule findings
c7n validate find-elasticsearch-low-cpu-usage-last-14-days.yaml # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./find-elasticsearch-low-cpu-usage-last-14-days.yaml # runs the policy and writes results to /tmp/output_dir
```

*** sample output just for testing example cpu average % was checked for < 10%
```json
[
  {
    "DomainId": "xxxxxxxxxxxxx/os23-rltst",
    "DomainName": "os23-rltst",
    "ARN": "arn:aws:es:ap-south-1:xxxxxxxxxxxxx:domain/os23-rltst",
    "Created": true,
    "Deleted": false,
    "Endpoints": {
      "vpc": "vpc-os23-rltst-lrscqec4cgazeotwaofbtlwecm.ap-south-1.es.amazonaws.com"
    },
    "Processing": false,
    "UpgradeProcessing": false,
    "ElasticsearchVersion": "OpenSearch_1.3",
    "ElasticsearchClusterConfig": {
      "InstanceType": "t3.small.elasticsearch",
      "InstanceCount": 2,
      "DedicatedMasterEnabled": false,
      "ZoneAwarenessEnabled": true,
      "ZoneAwarenessConfig": {
        "AvailabilityZoneCount": 2
      },
      "WarmEnabled": false,
      "ColdStorageOptions": {
        "Enabled": false
      }
    },
    "EBSOptions": {
      "EBSEnabled": true,
      "VolumeType": "gp3",
      "VolumeSize": 10,
      "Iops": 3000,
      "Throughput": 125
    },
    "AccessPolicies": "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Action\":\"es:*\",\"Resource\":\"arn:aws:es:ap-south-1:xxxxxxxxxxxxx:domain/os23-rltst/*\",\"Condition\":{\"StringEquals\":{\"aws:AuthType\":\"SIGV4\"}}}]}",
    "SnapshotOptions": {
      "AutomatedSnapshotStartHour": 0
    },
    "VPCOptions": {
      "VPCId": "vpc-0f435a788ecfb84fa",
      "SubnetIds": [
        "subnet-02a9761b861bd9bb7",
        "subnet-0b29b316bb0e744b5"
      ],
      "AvailabilityZones": [
        "ap-south-1b",
        "ap-south-1a"
      ],
      "SecurityGroupIds": [
        "sg-077941d2d05093b07"
      ]
    },
    "CognitoOptions": {
      "Enabled": false
    },
    "EncryptionAtRestOptions": {
      "Enabled": false
    },
    "NodeToNodeEncryptionOptions": {
      "Enabled": false
    },
    "AdvancedOptions": {
      "override_main_response_version": "false",
      "rest.action.multi.allow_explicit_index": "true"
    },
    "ServiceSoftwareOptions": {
      "CurrentVersion": "OpenSearch_1_3_R20250920-P1",
      "NewVersion": "",
      "UpdateAvailable": false,
      "Cancellable": false,
      "UpdateStatus": "COMPLETED",
      "Description": "There is no software update available for this domain.",
      "AutomatedUpdateDate": "1970-01-01T05:30:00+05:30",
      "OptionalDeployment": true
    },
    "DomainEndpointOptions": {
      "EnforceHTTPS": false,
      "TLSSecurityPolicy": "Policy-Min-TLS-1-2-2019-07",
      "CustomEndpointEnabled": false
    },
    "AdvancedSecurityOptions": {
      "Enabled": false,
      "InternalUserDatabaseEnabled": false,
      "AnonymousAuthEnabled": false
    },
    "AutoTuneOptions": {
      "State": "DISABLED"
    },
    "ChangeProgressDetails": {
      "ChangeId": "1922b834-cb18-474d-a4c8-d746b7d9597d",
      "ConfigChangeStatus": "Completed",
      "StartTime": "2025-10-22T18:46:27.147000+05:30",
      "LastUpdatedTime": "2025-10-22T18:46:43.804000+05:30",
      "InitiatedBy": "CUSTOMER"
    },
    "DomainProcessingStatus": "Active",
    "ModifyingProperties": [],
    "Tags": [
      {
        "Key": "Environment",
        "Value": "test"
      },
      {
        "Key": "Purpose",
        "Value": "policy-test"
      },
      {
        "Key": "ManagedBy",
        "Value": "Terraform"
      },
      {
        "Key": "Name",
        "Value": "os23-opensearch"
      }
    ],
    "c7n.metrics": {
      "AWS/ES.CPUUtilization.Average.14": [
        {
          "Timestamp": "2025-10-21T13:50:00+00:00",
          "Average": 6.901960784313726,
          "Unit": "Percent"
        }
      ]
    }
  }
]
```

*** Get quick summary of the elastic / open search cluster
```bash
jq -r '.[] | "\(.DomainName) | \(.ElasticsearchVersion) | \(.ElasticsearchClusterConfig.InstanceType) | \(.ElasticsearchClusterConfig.InstanceCount) | \(.EBSOptions.VolumeType) | \(.EBSOptions.VolumeSize) | \(.c7n.metrics["AWS/ES.CPUUtilization.Average.14"][0].Average)"' /tmp/output_dir/find-elasticsearch-low-cpu-usage-last-14-days/resources.json
os23-rltst | OpenSearch_1.3 | t3.small.elasticsearch | 2 | gp3 | 10 | null
```
