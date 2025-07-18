
// Get all EC2 instances with the specified Schedule tag
data "aws_instances" "vm_instances" {
  instance_tags = {
    Schedule = var.schedule_name_tag
  }
}

// Harness autostopping rule for each EC2 instance that has the Schedule tag as var.schedule_name_tag
resource "harness_autostopping_rule_vm" "ec2_auto_stop_rule" {
  for_each = var.add_ec2_schedule_rules ? toset(data.aws_instances.vm_instances.ids) : []
  name               = "${each.key}${var.schedule_name}Rule"
  cloud_connector_id = var.harness_cloud_connector_id
  idle_time_mins     = 5
  filter {
    vm_ids  = [each.key]
    regions = local.regions
  }
}


// Harness autostopping schedule that attaches all EC2 rules
// Between the start_time and end_time, ec2 instance instances remain running
// on MON, TUE, WED, THU, FRI
resource "harness_autostopping_schedule" "ec2_auto_stop_schedule" {
  count = var.add_ec2_schedule_rules ? 1 : 0
  name          = var.schedule_name
  schedule_type = "uptime"
  time_zone     = var.time_zone

  repeats {
    days       = ["MON", "TUE", "WED", "THU", "FRI"]
    start_time = "11:00"
    end_time   = "17:00"
  }

  rules = concat(
    var.add_ec2_schedule_rules ? [for rule in harness_autostopping_rule_vm.ec2_auto_stop_rule : rule.id] : []
  )
}
