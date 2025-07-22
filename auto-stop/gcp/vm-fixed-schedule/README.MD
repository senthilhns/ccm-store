
### Step 1 Check gcp cli works fine 
Test gcp cli works 
```bash
gcloud compute instances list \
  --format="value(name,zone)" \
  --filter="labels.<label_key>=<label_value>" \
  --project="<project_id>"
```
e.g command
```bash
gcloud compute instances list \
  --format="value(name,zone)" \
  --filter="labels.schedule=jul22asched" \
  --project="hns-sbox"

  # sample output will be like below  
  jul22-ubuntu-vm	asia-south1-a
  ```

### Step 2 Check python script works well using the underlying gcloud cli command
Test the python script

```bash
echo '{"label":"<label_key>","value":"<label_value>","project":"<project_id>"}' | python3 list_gcp_vms_by_label.py
```

e.g command

```bash
echo '{"label":"schedule","value":"peakuptimeschedule02","project":"hns-sbox"}' | \
 python3 list_gcp_vms_by_label.py
 
 # sample output will be like below
 {"instance_names": "jul22-ubuntu-vm"}
```


### Step 3
Copy terraform.tfvars.example as terraform.tfvars and fill in the values

### step 4
Use terraform or open terraform (tofu) for this step

```bash
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

### Step 5
Goto your Harness account console in web browser and in auto stopping rules check all rules are created correctly

