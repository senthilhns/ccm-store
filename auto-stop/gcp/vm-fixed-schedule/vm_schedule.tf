// Get all GCP VMs with the specified Schedule label

// Harness autostopping rule for each VM that has the Schedule tag as var.schedule_name_tag
resource "harness_autostopping_rule_vm" "vm_auto_stop_rule" {
  for_each = var.add_vm_schedule_rules ? { for id in local.vm_instance_ids : id => id } : {}
  name               = "${each.key}-${var.schedule_name}-rule"
  cloud_connector_id = var.harness_cloud_connector_id
  idle_time_mins     = 5
  filter {
    vm_ids  = [each.value]
    regions = local.zones
  }
}

// Harness autostopping schedule that attaches all VM rules
// Between the start_time and end_time, vm instance instances remain running
// on MON, TUE, WED, THU, FRI
resource "harness_autostopping_schedule" "vm_auto_stop_schedule" {
  count = var.add_vm_schedule_rules ? 1 : 0
  name          = var.schedule_name
  schedule_type = "uptime"
  time_zone     = var.time_zone

  repeats {
    days       = ["MON", "TUE", "WED", "THU", "FRI"]
    start_time = "15:00"
    end_time   = "17:00"
  }

  rules = concat(
    var.add_vm_schedule_rules ? [for rule in harness_autostopping_rule_vm.vm_auto_stop_rule : rule.id] : []
  )
}
