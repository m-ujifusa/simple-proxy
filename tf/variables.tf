variable "name_prefix" {
  default     = "your-prefix"
  description = "Prefix for resources, only use dashes for special characters."
  type        = string
}

variable "proxy_port" {
  default     = 3128
  description = "Port traffic is proxied through."
  type        = number
}

variable "ami_id" {
  default     = "ami-080e1f13689e07408"
  description = "Default AWS Ubuntu 22"
  type        = string
}

variable "turn_on_proxy_schedule" {
  default     = "cron(0 16 * * ? *)"
  description = "Every day at 11am Central Standard Time in UTC"
}

variable "turn_off_proxy_schedule" {
  default     = "cron(0 4 * * ? *)"
  description = "Every day at 11pm Central Standard Time in UTC"
}