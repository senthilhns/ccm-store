// Get all  RDS instances with the specified Schedule tag
data "aws_db_instances" "db_instances" {
  tags = {
    Schedule = var.schedule_name_tag
  }
}

// Harness autostopping rule for each RDS instance that has the Schedule tag as var.schedule_name_tag
resource "harness_autostopping_rule_rds" "rds_auto_stop_rule" {
  for_each = var.add_rds_schedule_rules ? toset(data.aws_db_instances.db_instances.instance_identifiers) : []
  name               = "${each.key}${var.schedule_name}Rule"
  cloud_connector_id = var.harness_cloud_connector_id
  idle_time_mins     = 5
  database {
    id     = each.key
    region = var.region
  }
}

// Harness autostopping schedule that attaches all RDS rules
// Between the start_time and end_time, rds instances remain running
// on MON, TUE, WED, THU, FRI
resource "harness_autostopping_schedule" "rds_auto_stop_schedule" {
  count = var.add_rds_schedule_rules ? 1 : 0
  name          = var.schedule_name
  schedule_type = "uptime"
  time_zone     = var.time_zone

  repeats {
    days       = ["MON", "TUE", "WED", "THU", "FRI"]
    start_time = "11:00"
    end_time   = "17:00"
  }

  rules = concat(
    var.add_rds_schedule_rules ? [for rule in harness_autostopping_rule_rds.rds_auto_stop_rule : rule.id] : []
  )
}