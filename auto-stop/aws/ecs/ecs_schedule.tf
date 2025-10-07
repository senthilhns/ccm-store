// ECS AutoStopping rule and schedule (single rule, by name)

// Harness autostopping rule for a single ECS service identified by cluster and service NAMEs
resource "harness_autostopping_rule_ecs" "ecs_auto_stop_rule" {
  name               = "${var.schedule_name}EcsRule"
  cloud_connector_id = var.harness_cloud_connector_id
  idle_time_mins     = 5

  container {
    cluster    = var.ecs_cluster_name
    service    = var.ecs_service_name
    region     = var.region
    task_count = 1
  }
}

// Harness autostopping schedule that attaches the single ECS rule
// Between the start_time and end_time, ECS service remains running on MON-FRI
resource "harness_autostopping_schedule" "ecs_auto_stop_schedule" {
  name          = var.schedule_name
  schedule_type = "uptime"
  time_zone     = var.time_zone

  repeats {
    days       = ["MON", "TUE", "WED", "THU", "FRI"]
    start_time = "17:00"
    end_time   = "17:30"
  }

  // Attach the single rule created above
  rules = [harness_autostopping_rule_ecs.ecs_auto_stop_rule.id]
}
