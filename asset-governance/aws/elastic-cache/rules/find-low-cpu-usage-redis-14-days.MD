```sh
# check find-low-usage-redis-14-days.yaml rule findings
c7n validate find-low-cpu-usage-redis-14-days # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./find-low-cpu-usage-redis-14-days # runs the policy and writes results to /tmp/output_dir
```

*** view the output
```    
# syntax highlighted output
jq . /tmp/output_dir/find-low-cpu-usage-redis-14-days/resources.json
```

*** sample output
```json
[
  {
    "CacheClusterId": "nov-10-001-nov-10-001-redis-cluster",
    "ClientDownloadLandingPage": "https://console.aws.amazon.com/elasticache/home#client-download:",
    "CacheNodeType": "cache.t2.micro",
    "Engine": "redis",
    "EngineVersion": "6.2.6",
    "CacheClusterStatus": "available",
    "NumCacheNodes": 1,
    "PreferredAvailabilityZone": "ap-south-1b",
    "CacheClusterCreateTime": "2025-11-10T13:43:42.652000+00:00",
    "PreferredMaintenanceWindow": "sat:22:30-sat:23:30",
    "PendingModifiedValues": {},
    "CacheSecurityGroups": [],
    "CacheParameterGroup": {
      "CacheParameterGroupName": "default.redis6.x",
      "ParameterApplyStatus": "in-sync",
      "CacheNodeIdsToReboot": []
    },
    "CacheSubnetGroupName": "nov-10-001-elasticache-subnet-group",
    "AutoMinorVersionUpgrade": true,
    "SecurityGroups": [
      {
        "SecurityGroupId": "sg-04980d92a17fc6889",
        "Status": "active"
      }
    ],
    "SnapshotRetentionLimit": 0,
    "SnapshotWindow": "23:30-00:30",
    "AuthTokenEnabled": false,
    "TransitEncryptionEnabled": false,
    "AtRestEncryptionEnabled": false,
    "ARN": "arn:aws:elasticache:ap-south-1:xxxxxxxxxxxxx:cluster:nov-10-001-nov-10-001-redis-cluster",
    "ReplicationGroupLogDeliveryEnabled": false,
    "LogDeliveryConfigurations": [],
    "NetworkType": "ipv4",
    "IpDiscovery": "ipv4",
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
        "Key": "StackPrefix",
        "Value": "nov-10-001"
      },
      {
        "Key": "Name",
        "Value": "sample-redis-cluster"
      }
    ],
    "c7n.metrics": {
      "AWS/ElastiCache.EngineCPUUtilization.Average.14": [
        {
          "Timestamp": "2025-11-09T14:32:00+00:00",
          "Average": 0.14326990002882678,
          "Unit": "Percent"
        }
      ]
    }
  }
]
```

*** Quick summary of all clusters found the policy for low bytes usage
```bash
jq '.[].CacheClusterId' /tmp/output_dir/find-low-cpu-usage-redis-14-days/resources.json
```
