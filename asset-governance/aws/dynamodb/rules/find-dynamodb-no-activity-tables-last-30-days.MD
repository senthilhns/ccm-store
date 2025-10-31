```sh
# check find-redis-low-bytes-handled.yaml rule findings
c7n validate find-dynamodb-no-activity-tables-last-30-days.yaml # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./find-dynamodb-no-activity-tables-last-30-days.yaml # runs the policy and writes results to /tmp/output_dir
```

*** view the output
```    
# syntax highlighted output
jq . /tmp/output_dir/find-dynamodb-no-activity-tables-last-30-days/resources.json
```

*** sample output
```json
[
  {
    "AttributeDefinitions": [
      {
        "AttributeName": "name",
        "AttributeType": "S"
      },
      {
        "AttributeName": "type",
        "AttributeType": "S"
      }
    ],
    "TableName": "QA-TEST-STOP-START-SCHEDULE-02-STACK-ConfigTable-4LZFXP8IHSHG",
    "KeySchema": [
      {
        "AttributeName": "type",
        "KeyType": "HASH"
      },
      {
        "AttributeName": "name",
        "KeyType": "RANGE"
      }
    ],
    "TableStatus": "ACTIVE",
    "CreationDateTime": "2023-11-13T13:32:10.687000+05:30",
    "ProvisionedThroughput": {
      "NumberOfDecreasesToday": 0,
      "ReadCapacityUnits": 0,
      "WriteCapacityUnits": 0
    },
    "TableSizeBytes": 1421,
    "ItemCount": 10,
    "TableArn": "arn:aws:dynamodb:ap-south-1:xxxxxxxxxxxxxx:table/QA-TEST-STOP-START-SCHEDULE-02-STACK-ConfigTable-4LZFXP8IHSHG",
    "TableId": "6e72e787-e7db-4286-9fc5-9a4a2dbffc93",
    "BillingModeSummary": {
      "BillingMode": "PAY_PER_REQUEST",
      "LastUpdateToPayPerRequestDateTime": "2023-11-13T13:32:10.687000+05:30"
    },
    "SSEDescription": {
      "Status": "ENABLED",
      "SSEType": "KMS",
      "KMSMasterKeyArn": "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxx:key/36ba7829-b84d-40f2-9d01-674227b512ef"
    },
    "DeletionProtectionEnabled": false,
    "WarmThroughput": {
      "ReadUnitsPerSecond": 12000,
      "WriteUnitsPerSecond": 4000,
      "Status": "ACTIVE"
    },
    "Tags": [],
    "c7n.metrics": {
      "AWS/DynamoDB.ConsumedReadCapacityUnits.Average.30": [
        {
          "Timestamp": "2025-10-01T15:00:00+00:00",
          "Average": 0.0,
          "Unit": "Count"
        }
      ],
      "AWS/DynamoDB.ConsumedWriteCapacityUnits.Average.30": [
        {
          "Timestamp": "2025-10-01T15:00:00+00:00",
          "Average": 0.0,
          "Unit": "Count"
        }
      ]
    }
  },
  {
    "AttributeDefinitions": [
      {
        "AttributeName": "Name",
        "AttributeType": "S"
      },
      {
        "AttributeName": "account-region",
        "AttributeType": "S"
      }
    ],
    "TableName": "QA-TEST-STOP-START-SCHEDULE-02-STACK-MaintenanceWindowTable-1O03KZZNNJ8FE",
    "KeySchema": [
      {
        "AttributeName": "Name",
        "KeyType": "HASH"
      },
      {
        "AttributeName": "account-region",
        "KeyType": "RANGE"
      }
    ],
    "TableStatus": "ACTIVE",
    "CreationDateTime": "2023-11-13T13:32:10.578000+05:30",
    "ProvisionedThroughput": {
      "NumberOfDecreasesToday": 0,
      "ReadCapacityUnits": 0,
      "WriteCapacityUnits": 0
    },
    "TableSizeBytes": 0,
    "ItemCount": 0,
    "TableArn": "arn:aws:dynamodb:ap-south-1:xxxxxxxxxxxxxx:table/QA-TEST-STOP-START-SCHEDULE-02-STACK-MaintenanceWindowTable-1O03KZZNNJ8FE",
    "TableId": "f43ccfce-8ab0-411e-8cd8-fea9d4fef5a1",
    "BillingModeSummary": {
      "BillingMode": "PAY_PER_REQUEST",
      "LastUpdateToPayPerRequestDateTime": "2023-11-13T13:32:10.578000+05:30"
    },
    "SSEDescription": {
      "Status": "ENABLED",
      "SSEType": "KMS",
      "KMSMasterKeyArn": "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxx:key/36ba7829-b84d-40f2-9d01-674227b512ef"
    },
    "DeletionProtectionEnabled": false,
    "WarmThroughput": {
      "ReadUnitsPerSecond": 12000,
      "WriteUnitsPerSecond": 4000,
      "Status": "ACTIVE"
    },
    "Tags": [],
    "c7n.metrics": {
      "AWS/DynamoDB.ConsumedReadCapacityUnits.Average.30": [
        {
          "Timestamp": "2025-10-01T15:00:00+00:00",
          "Average": 0.0,
          "Unit": "Count"
        }
      ],
      "AWS/DynamoDB.ConsumedWriteCapacityUnits.Average.30": [
        {
          "Timestamp": "2025-10-01T15:00:00+00:00",
          "Average": 0.0,
          "Unit": "Count"
        }
      ]
    }
  },
  {
    "AttributeDefinitions": [
      {
        "AttributeName": "account-region",
        "AttributeType": "S"
      },
      {
        "AttributeName": "service",
        "AttributeType": "S"
      }
    ],
    "TableName": "QA-TEST-STOP-START-SCHEDULE-02-STACK-StateTable-LO9T7CEFUGXC",
    "KeySchema": [
      {
        "AttributeName": "service",
        "KeyType": "HASH"
      },
      {
        "AttributeName": "account-region",
        "KeyType": "RANGE"
      }
    ],
    "TableStatus": "ACTIVE",
    "CreationDateTime": "2023-11-13T13:32:10.584000+05:30",
    "ProvisionedThroughput": {
      "NumberOfDecreasesToday": 0,
      "ReadCapacityUnits": 0,
      "WriteCapacityUnits": 0
    },
    "TableSizeBytes": 99,
    "ItemCount": 1,
    "TableArn": "arn:aws:dynamodb:ap-south-1:xxxxxxxxxxxxxx:table/QA-TEST-STOP-START-SCHEDULE-02-STACK-StateTable-LO9T7CEFUGXC",
    "TableId": "babd22e2-be7b-4901-b23a-df24a6335fae",
    "BillingModeSummary": {
      "BillingMode": "PAY_PER_REQUEST",
      "LastUpdateToPayPerRequestDateTime": "2023-11-13T13:32:10.584000+05:30"
    },
    "SSEDescription": {
      "Status": "ENABLED",
      "SSEType": "KMS",
      "KMSMasterKeyArn": "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxx:key/36ba7829-b84d-40f2-9d01-674227b512ef"
    },
    "DeletionProtectionEnabled": false,
    "WarmThroughput": {
      "ReadUnitsPerSecond": 12000,
      "WriteUnitsPerSecond": 4000,
      "Status": "ACTIVE"
    },
    "Tags": [],
    "c7n.metrics": {
      "AWS/DynamoDB.ConsumedReadCapacityUnits.Average.30": [
        {
          "Timestamp": "2025-10-01T15:00:00+00:00",
          "Average": 0.0,
          "Unit": "Count"
        }
      ],
      "AWS/DynamoDB.ConsumedWriteCapacityUnits.Average.30": [
        {
          "Timestamp": "2025-10-01T15:00:00+00:00",
          "Average": 0.0,
          "Unit": "Count"
        }
      ]
    }
  }
]
```

*** Get quick summary of the dynamodb details 
```bash
jq -r '.[] | "\(.TableName) | \(.BillingModeSummary.BillingMode) | \(.TableSizeBytes) | \(.ItemCount) | \(.CreationDateTime) | \(.c7n.metrics."AWS/DynamoDB.ConsumedReadCapacityUnits.Average.30"[0].Average) | \(.c7n.metrics."AWS/DynamoDB.ConsumedWriteCapacityUnits.Average.30"[0].Average)"' /tmp/output_dir/find-dynamodb-no-activity-tables-last-30-days/resources.json

# sample output below
# QA-TEST-STOP-START-SCHEDULE-02-STACK-ConfigTable-4LZFXP8IHSHG | PAY_PER_REQUEST | 1421 | 10 | 2023-11-13T13:32:10.687000+05:30 | null | null
# QA-TEST-STOP-START-SCHEDULE-02-STACK-MaintenanceWindowTable-1O03KZZNNJ8FE | PAY_PER_REQUEST | 0 | 0 | 2023-11-13T13:32:10.578000+05:30 | null | null
# QA-TEST-STOP-START-SCHEDULE-02-STACK-StateTable-LO9T7CEFUGXC | PAY_PER_REQUEST | 99 | 1 | 2023-11-13T13:32:10.584000+05:30 | null | null
```
