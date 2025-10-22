```sh
# check find-redis-low-bytes-handled.yaml rule findings
c7n validate notify-cross-region-snapshot-copy-nonprod.yaml # checks policy YAML is valid  or not
c7n run -s /tmp/output_dir ./notify-cross-region-snapshot-copy-nonprod.yaml # runs the policy and writes results to /tmp/output_dir
```


*** Enable cross region snapshot copying
```bash
aws redshift enable-snapshot-copy \
    --cluster-identifier oct-21-016-redshift-cluster-for-testing   \
    --destination-region us-west-2  \
    --retention-period 7
```

*** Check whether cross snapshot is enabled
```bash
$ aws redshift describe-clusters --cluster-identifier oct-21-016-redshift-cluster-for-testing --query 'Clusters[0].ClusterSnapshotCopyStatus'
{
"DestinationRegion": "us-west-2",
"RetentionPeriod": 7,
"ManualSnapshotRetentionPeriod": -1
}
```