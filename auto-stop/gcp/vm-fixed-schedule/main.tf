locals {
  zones = [var.zone]
  vm_instance_ids = split(",", data.external.vms_by_label.result["instance_ids"])
}
