#!/usr/bin/env python3
import json
import subprocess
import sys

def main():
    with open("find_vm.log", "a") as log:
        args = json.load(sys.stdin)
        label = args.get("label")
        value = args.get("value")
        project = args.get("project", "")
        filter_expr = f"labels.{label}={value}"
        # Use gcloud to get numeric instance IDs
        cmd = [
            "gcloud", "compute", "instances", "list",
            "--format=value(id)",
            "--filter", filter_expr
        ]
        if project:
            cmd += ["--project", project]
        log.write(f"[DEBUG] Running command: {' '.join(cmd)}\n")
        result = subprocess.run(cmd, stdout=subprocess.PIPE, text=True)
        log.write(f"[DEBUG] Raw output: {result.stdout}\n")
        instance_ids = [line.strip() for line in result.stdout.strip().split("\n") if line.strip()]
        log.write(f"[DEBUG] Instance IDs: {instance_ids}\n")
        print(json.dumps({"instance_ids": ",".join(instance_ids)}))

if __name__ == "__main__":
    main()
