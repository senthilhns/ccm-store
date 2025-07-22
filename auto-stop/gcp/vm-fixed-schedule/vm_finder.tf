data "external" "vms_by_label" {
  program = ["python3", "${path.module}/list_gcp_vms_by_label.py"]

  query = {
    label   = var.schedule_tag_key
    value   = var.schedule_name_tag
    project = var.project_id
  }
}
