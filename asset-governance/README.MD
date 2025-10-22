## Cloud Custodian Setup (Latest Version)

To install and use the latest Cloud Custodian (c7n):

1. **Install pip (if not installed):**
   ```sh
   sudo apt-get update
   sudo apt-get install python3-pip -y
   ```
2. **(Optional) Create and activate a Python virtual environment:**
   ```sh
   python3 -m venv /opt/c7n
   source /opt/c7n/bin/activate
   ```
3. **Install/Upgrade Cloud Custodian:**
   ```sh
   pip install --upgrade c7n
   ```
4. **Verify installation:**
   ```sh
   c7n version
   which c7n
   ```
5. **Usage:**
   - Validate a policy:
     ```sh
     c7n validate <policy-file.yaml>
     ```
   - Run a policy:
     ```sh
     c7n run -s output_dir <policy-file.yaml>
     ```

**Note:** Ensure your AWS credentials are configured (via `aws configure` or env vars).

## Optional c7n link for using without "source" of venv

To create or update a symbolic link (symlink):
```bash
  sudo ln -s /opt/c7n/bin/custodian /usr/local/bin/c7n
```