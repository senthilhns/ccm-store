```sh
# check find-redis-low-bytes-handled.yaml rule findings
c7n validate find-legacy-cache-cluster-node-types.yaml # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./find-legacy-cache-cluster-node-types.yaml # runs the policy and writes results to /tmp/output_dir
```

*** view the output
```    
# syntax highlighted output
jq . /tmp/output_dir/find-legacy-cache-cluster-node-types/resources.json
```

*** sample output
```json
[
  {
    "CacheClusterId": "oct-21-003-oct-21-001-redis-cluster",
    "ClientDownloadLandingPage": "https://console.aws.amazon.com/elasticache/home#client-download:",
    "CacheNodeType": "cache.t2.micro",
    "Engine": "redis",
    "EngineVersion": "6.2.6",
    "CacheClusterStatus": "available",
    "NumCacheNodes": 1,
    "PreferredAvailabilityZone": "ap-south-1b",
    "CacheClusterCreateTime": "2025-10-21T15:10:15.953000+00:00",
    "PreferredMaintenanceWindow": "fri:20:00-fri:21:00",
    "PendingModifiedValues": {},
    "CacheSecurityGroups": [],
    "CacheParameterGroup": {
      "CacheParameterGroupName": "default.redis6.x",
      "ParameterApplyStatus": "in-sync",
      "CacheNodeIdsToReboot": []
    },
    "CacheSubnetGroupName": "oct-21-003-elasticache-subnet-group",
    "AutoMinorVersionUpgrade": true,
    "SecurityGroups": [
      {
        "SecurityGroupId": "sg-04e77b8246506bc4b",
        "Status": "active"
      }
    ],
    "SnapshotRetentionLimit": 0,
    "SnapshotWindow": "02:00-03:00",
    "AuthTokenEnabled": false,
    "TransitEncryptionEnabled": false,
    "AtRestEncryptionEnabled": false,
    "ARN": "arn:aws:elasticache:ap-south-1:xxxxxxxxxxxxx:cluster:oct-21-003-oct-21-001-redis-cluster",
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
        "Value": "oct-21-003"
      },
      {
        "Key": "Name",
        "Value": "sample-redis-cluster"
      }
    ],
    "c7n:MatchedFilters": [
      "CacheNodeType"
    ]
  }
]
```

*** Get quick summary of the redis cluster
```bash
jq -r '.[] | "\(.CacheClusterId) | \(.CacheNodeType) | \(.Engine) | \(.EngineVersion) | \(.CacheClusterStatus) | \(.NumCacheNodes) | \(.PreferredAvailabilityZone)"' /tmp/output_dir/find-redis-low-bytes-handled/resources.json
# sample output below
# oct-21-003-oct-21-001-redis-cluster | cache.t2.micro | redis | 6.2.6 | available | 1 | ap-south-1b
```
