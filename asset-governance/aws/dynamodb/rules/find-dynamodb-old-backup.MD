```sh
c7n validate find-dynamodb-old-backup.yaml # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./find-dynamodb-old-backup.yaml # runs the policy and writes results to /tmp/output_dir
```

*** view the output
```    
# syntax highlighted output
jq . /tmp/output_dir/find-dynamodb-old-backup.yaml/resources.json
```
