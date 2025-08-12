
// Harness autostopping schedule that attaches all EC2 rules
// Between the start_time and end_time, ec2 instance instances remain running
// on MON, TUE, WED, THU, FRI
resource "harness_autostopping_schedule" "ec2_auto_stop_schedule" {
  name          = var.schedule_name
  schedule_type = "uptime"
  time_zone     = var.time_zone

  repeats {
    days       = ["MON", "TUE", "WED", "THU", "FRI"]
    start_time = "11:00"
    end_time   = "17:00"
  }

  rules = [var.rule_id]
}
