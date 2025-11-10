
### Test the dynamodb installation

#### Write an entry to DB
```bash
aws dynamodb put-item \
    --table-name example-dynamodb-table \
    --item '{
        "id": {"S": "test1"},
        "name": {"S": "Test Item"},
        "description": {"S": "This is a test item"}
    }' \
    --region ap-south-1
```

#### Verify the entry is written or not
```bash
aws dynamodb get-item \
    --table-name example-dynamodb-table \
    --key '{"id": {"S": "test1"}}' \
    --region ap-south-1
```
