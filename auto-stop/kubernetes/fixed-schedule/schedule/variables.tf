variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "time_zone" {
  description = "Time zone for the autostopping schedule"
  type        = string
  default     = "America/New_York"
}

variable "schedule_name" {
  description = "Name for the autostopping schedule"
  type        = string
  default     = "ec2-weekday-schedule"
}

variable "rule_id" {
  description = "Numeric ID of the specific autostopping rule to attach to the schedule"
  type        = number
}

